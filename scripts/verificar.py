#!/usr/bin/env python3
"""Comprueba el curso en bases temporales propias, con PostgreSQL real."""
from __future__ import annotations
import csv
import io
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
import threading
import uuid
from decimal import Decimal
from urllib.parse import unquote
import psycopg
from psycopg import sql

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'salidas'
COUNT = 0
ENV = {**os.environ, 'PGCLIENTENCODING': 'UTF8'}
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8')

def check(condition, label):
    global COUNT
    if not condition:
        raise AssertionError(label)
    COUNT += 1

def connect(db):
    return psycopg.connect(dbname=db, autocommit=True, connect_timeout=10)

def run(tool, args, label):
    p = subprocess.run([tool, *args], cwd=ROOT, env=ENV, capture_output=True,
                       encoding='utf-8', errors='replace', timeout=120)
    log = OUT / (re.sub(r'[^a-zA-Z0-9_.-]', '_', label) + '.log')
    log.write_text(p.stdout + p.stderr, encoding='utf-8')
    check(p.returncode == 0, f'{label}: {p.stderr[-2000:]}')
    return p.stdout

def execute_file(db, path):
    run('psql', ['-X', '-d', db, '-v', 'ON_ERROR_STOP=1', '-f', str(path)], str(path))

def rows(c, query, params=None):
    return c.execute(query, params).fetchall()

def expect(c, query, expected, label):
    check(rows(c, query) == expected, label)

def failure(c, query, state, params=None):
    try:
        c.execute(query, params)
    except psycopg.Error as e:
        check(e.sqlstate == state, f'SQLSTATE esperado {state}, recibido {e.sqlstate}')
    else:
        raise AssertionError(f'La sentencia debía fallar con {state}')

def snapshot(c):
    result = {}
    for schema in ('tienda', 'biblioteca'):
        tables = rows(c, "SELECT tablename FROM pg_tables WHERE schemaname=%s ORDER BY tablename", (schema,))
        for (name,) in tables:
            q = sql.SQL('SELECT * FROM {}.{} ORDER BY 1,2').format(sql.Identifier(schema), sql.Identifier(name))
            result[schema + '.' + name] = c.execute(q).fetchall()
    return result

def documentation():
    units = sorted(ROOT.glob('unidad*'))
    check(len(units) == 33, 'Hay 33 unidades')
    for n, unit in enumerate(units):
        check(unit.name.startswith(f'unidad{n:02}'), 'Secuencia de unidades')
        for name in ('README.md', 'PRACTICA.md', 'SOLUCIONES.md'):
            check((unit / name).is_file(), f'{unit.name}/{name}')
    for p in ROOT.rglob('*.md'):
        if any(part.startswith('.') or part == 'salidas' for part in p.relative_to(ROOT).parts):
            continue
        content = p.read_text(encoding='utf-8')
        check('—' not in content, f'Separadores del documento: {p.name}')
        for link in re.findall(r'!?\[[^\]]*\]\(([^)]+)\)', content):
            target = link.split('#', 1)[0]
            if not target or re.match(r'^[a-zA-Z]+:', target):
                continue
            check((p.parent / unquote(target)).exists(), f'Enlace roto: {p.relative_to(ROOT)} → {target}')

def tienda_tests(c):
    expect(c, 'SELECT (SELECT COUNT(*) FROM tienda.categoria),(SELECT COUNT(*) FROM tienda.producto),(SELECT COUNT(*) FROM tienda.cliente),(SELECT COUNT(*) FROM tienda.pedido),(SELECT COUNT(*) FROM tienda.detalle_pedido)', [(4,5,4,5,5)], 'Conteos iniciales tienda')
    expect(c, 'SELECT SUM(precio),AVG(precio),COUNT(descripcion) FROM tienda.producto', [(Decimal('430'),Decimal('86'),3)], 'Métrica de precios y NULL')
    expect(c, 'SELECT SUM(cantidad),SUM(cantidad*precio_unitario) FROM tienda.detalle_pedido', [(11,Decimal('1010'))], 'Unidades y valor histórico')
    expect(c, "SELECT SUM(d.cantidad),SUM(d.cantidad*d.precio_unitario) FROM tienda.pedido p JOIN tienda.detalle_pedido d ON d.pedido_id=p.id WHERE p.estado='PAGADO'", [(5,Decimal('470'))], 'Ventas pagadas')
    expect(c, 'SELECT p.id,COALESCE(SUM(d.cantidad*d.precio_unitario),0) FROM tienda.pedido p LEFT JOIN tienda.detalle_pedido d ON d.pedido_id=p.id GROUP BY p.id ORDER BY p.id', [(1,Decimal('320')),(2,Decimal('90')),(3,Decimal('150')),(4,Decimal('0')),(5,Decimal('450'))], 'Conserva pedido vacío y precios históricos')
    expect(c, 'SELECT c.id,COUNT(p.id) FROM tienda.categoria c LEFT JOIN tienda.producto p ON p.categoria_id=c.id GROUP BY c.id ORDER BY c.id', [(1,2),(2,2),(3,1),(4,0)], 'Categoría vacía cuenta cero')
    expect(c, 'SELECT id FROM tienda.cliente c WHERE NOT EXISTS(SELECT 1 FROM tienda.pedido p WHERE p.cliente_id=c.id) ORDER BY id', [(3,)], 'Sara sin pedidos')
    expect(c, 'SELECT id FROM tienda.producto ORDER BY precio DESC,id LIMIT 3', [(3,),(2,),(4,)], 'Desempate estable')
    expect(c, 'SELECT NULL=NULL,NULL IS NULL,3 NOT IN(1,2,NULL),false AND NULL,true OR NULL', [(None,True,None,False,True)], 'Lógica de tres valores')
    expect(c, 'SELECT COUNT(*),SUM(precio) FROM tienda.producto WHERE precio>1000', [(0,None)], 'Agregación vacía')
    expect(c, 'SELECT id FROM tienda.producto WHERE precio>(SELECT AVG(precio) FROM tienda.producto) ORDER BY id', [(2,),(3,),(4,)], 'Subconsulta promedio')
    for clause, expected in [('UNION',[(1,),(2,),(3,)]),('UNION ALL',[(1,),(1,),(2,),(2,),(3,)]),('INTERSECT',[(2,)]),('EXCEPT',[(1,)])]:
        expect(c, f'WITH a(x) AS(VALUES(1),(1),(2)),b(x) AS(VALUES(2),(3)) SELECT x FROM a {clause} SELECT x FROM b ORDER BY x', expected, clause)
    expect(c, 'SELECT COUNT(*) FROM pg_constraint WHERE contype=\'f\' AND connamespace=\'tienda\'::regnamespace', [(4,)], 'Cuatro FK tienda')
    cases = [
        ("INSERT INTO tienda.categoria(nombre) VALUES('Libros')", '23505'),
        ("INSERT INTO tienda.producto(categoria_id,nombre,precio) VALUES(1,NULL,10)", '23502'),
        ("INSERT INTO tienda.producto(categoria_id,nombre,precio) VALUES(1,'Prueba',0)", '23514'),
        ("INSERT INTO tienda.producto(categoria_id,nombre,precio) VALUES(1,'Prueba','NaN')", '23514'),
        ("INSERT INTO tienda.producto(categoria_id,nombre,precio) VALUES(1,'Prueba',NULL)", '23502'),
        ("INSERT INTO tienda.pedido(cliente_id,estado) VALUES(999999,'CREADO')", '23503'),
        ("INSERT INTO tienda.pedido(cliente_id,estado) VALUES(1,'DESCONOCIDO')", '23514'),
        ("INSERT INTO tienda.detalle_pedido VALUES(1,1,1,80)", '23505'),
        ("DELETE FROM tienda.cliente WHERE id=2", '23503'),
        ("DELETE FROM tienda.producto WHERE id=3", '23503'),
    ]
    for query,state in cases:
        failure(c,query,state)
    before = snapshot(c)
    c.execute('BEGIN')
    c.execute('DELETE FROM tienda.pedido WHERE id=1')
    expect(c, 'SELECT COUNT(*) FROM tienda.detalle_pedido WHERE pedido_id=1', [(0,)], 'CASCADE real')
    c.execute('ROLLBACK')
    check(snapshot(c)==before, 'Rollback recupera filas')
    c.execute('BEGIN')
    c.execute('UPDATE tienda.producto SET precio=85 WHERE id=1')
    c.execute('SAVEPOINT segundo')
    failure(c, 'UPDATE tienda.producto SET precio=-1 WHERE id=1', '23514')
    failure(c, 'SELECT 1', '25P02')
    c.execute('ROLLBACK TO SAVEPOINT segundo')
    expect(c, 'SELECT precio FROM tienda.producto WHERE id=1', [(Decimal('85'),)], 'SAVEPOINT recupera transacción')
    c.execute('ROLLBACK')
    check(snapshot(c)==before, 'Rollback completo tras savepoint')

def import_tests(c):
    c.execute('CREATE TEMP TABLE carga(fuente text,nombre_raw text,correo_raw text)')
    with c.cursor().copy('COPY carga FROM STDIN WITH(FORMAT csv,HEADER true)') as cp:
        cp.write((ROOT/'datos/clientes_importacion.csv').read_bytes())
    c.execute("""CREATE TEMP VIEW clasificado AS WITH n AS(
      SELECT *,btrim(nombre_raw) AS nombre,lower(btrim(correo_raw)) AS correo FROM carga),r AS(
      SELECT *,COUNT(*) OVER(PARTITION BY correo) AS veces FROM n)
      SELECT *,CASE WHEN nombre IS NULL OR nombre='' THEN 'NOMBRE_VACIO'
      WHEN correo IS NULL OR correo='' THEN 'CORREO_VACIO'
      WHEN veces>1 THEN 'CORREO_REPETIDO' ELSE 'ACEPTADO' END AS regla FROM r""")
    expect(c, 'SELECT regla,COUNT(*) FROM clasificado GROUP BY regla ORDER BY regla', [('ACEPTADO',2),('CORREO_REPETIDO',2),('CORREO_VACIO',1),('NOMBRE_VACIO',1)], 'Clasifica seis filas sin perder rechazadas')
    raw = rows(c,'SELECT * FROM carga ORDER BY fuente,nombre_raw NULLS LAST,correo_raw NULLS LAST')
    with c.cursor().copy("COPY(SELECT nombre,correo FROM clasificado WHERE regla='ACEPTADO' ORDER BY correo) TO STDOUT WITH(FORMAT csv,HEADER true)") as cp:
        exported = b''.join(bytes(chunk) for chunk in cp)
    parsed = list(csv.reader(io.StringIO(exported.decode('utf-8'))))
    check(parsed == [['nombre','correo'],['Ana','ana@example.com'],['Luis','luis@example.com']], 'Exportación CSV exacta')
    c.execute('CREATE TEMP TABLE reimportado(nombre text,correo text)')
    with c.cursor().copy('COPY reimportado FROM STDIN WITH(FORMAT csv,HEADER true)') as cp:
        cp.write(exported)
    expect(c,'SELECT nombre,correo FROM reimportado ORDER BY correo',[('Ana','ana@example.com'),('Luis','luis@example.com')],'Importación del CSV exportado')
    check(rows(c,'SELECT * FROM carga ORDER BY fuente,nombre_raw NULLS LAST,correo_raw NULLS LAST')==raw,'Datos crudos conservados')

def concurrency(db,c):
    c.execute('CREATE SCHEMA comprobacion')
    c.execute('CREATE TABLE comprobacion.fila(id integer PRIMARY KEY,valor integer NOT NULL)')
    c.execute('INSERT INTO comprobacion.fila VALUES(1,80)')
    with connect(db) as a, connect(db) as b:
        a.execute('BEGIN')
        a.execute('UPDATE comprobacion.fila SET valor=81 WHERE id=1')
        expect(b,'SELECT valor FROM comprobacion.fila WHERE id=1',[(80,)],'MVCC: no lee cambios sin confirmar')
        b.execute('BEGIN')
        b.execute("SET LOCAL lock_timeout='300ms'")
        failure(b,'UPDATE comprobacion.fila SET valor=82 WHERE id=1','55P03')
        b.execute('ROLLBACK'); a.execute('ROLLBACK')
        expect(b,'SELECT valor FROM comprobacion.fila WHERE id=1',[(80,)],'Rollback libera bloqueo y conserva valor')
        for level,observed in [('READ COMMITTED',81),('REPEATABLE READ',80)]:
            b.execute('UPDATE comprobacion.fila SET valor=80 WHERE id=1')
            a.execute('BEGIN ISOLATION LEVEL '+level)
            expect(a,'SELECT valor FROM comprobacion.fila WHERE id=1',[(80,)],level+' primer snapshot')
            b.execute('UPDATE comprobacion.fila SET valor=81 WHERE id=1')
            expect(a,'SELECT valor FROM comprobacion.fila WHERE id=1',[(observed,)],level+' segunda lectura')
            if level=='REPEATABLE READ':
                failure(a,'UPDATE comprobacion.fila SET valor=82 WHERE id=1','40001')
            a.execute('ROLLBACK')
        c.execute('CREATE TABLE comprobacion.turno(id integer PRIMARY KEY,disponible boolean NOT NULL)')
        c.execute('INSERT INTO comprobacion.turno VALUES(1,true),(2,true)')
        for level,remaining in [('REPEATABLE READ',0),('SERIALIZABLE',1)]:
            c.execute('UPDATE comprobacion.turno SET disponible=true')
            for conn in (a,b):
                conn.execute('BEGIN ISOLATION LEVEL '+level)
                expect(conn,'SELECT COUNT(*) FROM comprobacion.turno WHERE disponible',[(2,)],level+' población inicial')
            a.execute('UPDATE comprobacion.turno SET disponible=false WHERE id=1')
            b.execute('UPDATE comprobacion.turno SET disponible=false WHERE id=2')
            a.execute('COMMIT')
            if level=='SERIALIZABLE':
                failure(b,'COMMIT','40001')
                b.execute('ROLLBACK')
            else:
                b.execute('COMMIT')
            expect(c,'SELECT COUNT(*) FROM comprobacion.turno WHERE disponible',[(remaining,)],level+' write skew')
    # Quita solo el esquema creado por el verificador en su propia base temporal.
    c.execute('DROP SCHEMA comprobacion CASCADE')

def project_tests(db,c):
    expect(c, 'SELECT (SELECT COUNT(*) FROM biblioteca.socio),(SELECT COUNT(*) FROM biblioteca.libro),(SELECT COUNT(*) FROM biblioteca.ejemplar),(SELECT COUNT(*) FROM biblioteca.prestamo)', [(3,3,4,3)], 'Conteos biblioteca')
    expect(c, 'SELECT prestamo_id,codigo,socio FROM biblioteca.prestamos_abiertos ORDER BY prestamo_id', [(2,'A-02','Luis')], 'Vista sin correo y préstamo abierto')
    expect(c, 'SELECT e.id FROM biblioteca.ejemplar e WHERE activo AND NOT EXISTS(SELECT 1 FROM biblioteca.prestamo p WHERE p.ejemplar_id=e.id AND devuelto_en IS NULL) ORDER BY e.id', [(1,),(3,)], 'Disponibles exactos')
    failure(c, "INSERT INTO biblioteca.prestamo(socio_id,ejemplar_id,inicio,vence_en) VALUES(1,2,'2026-02-01','2026-02-10')", '23505')
    failure(c, "SELECT biblioteca.prestar(1,1,'2026-01-02','2026-01-10')", '22023')
    before=snapshot(c)
    execute_file(db,'proyecto-biblioteca/07_pruebas.sql')
    check(snapshot(c)==before, 'Pruebas del proyecto no dejan cambios')
    execute_file(db,'proyecto-biblioteca/06_roles.sql')
    check(snapshot(c)==before, 'Permisos y operaciones de prueba se revierten')
    # Dos solicitudes reales al mismo ejemplar: gana exactamente una.
    barrier=threading.Barrier(2)
    results=[]
    errors=[]
    def borrow(socio):
        try:
            with connect(db) as conn:
                barrier.wait(timeout=10)
                try:
                    result=rows(conn,"SELECT biblioteca.prestar(%s,1,'2026-01-10 10:00+00','2026-01-20 10:00+00')",(socio,))
                    results.append(result[0][0])
                except psycopg.Error as e:
                    errors.append(e.sqlstate)
        except BaseException as e:
            errors.append(repr(e))
    threads=[threading.Thread(target=borrow,args=(s,)) for s in (1,2)]
    for t in threads:t.start()
    for t in threads:t.join(timeout=20)
    check(all(not t.is_alive() for t in threads),'Operaciones concurrentes terminan')
    check(len(results)==1 and errors==['22023'],'Solo una solicitud presta la misma copia')
    expect(c,'SELECT COUNT(*) FROM biblioteca.prestamo WHERE ejemplar_id=1 AND devuelto_en IS NULL',[(1,)],'Un único préstamo abierto real')
    # La prueba usa una base exclusiva; vuelve al caso inicial para el respaldo.
    c.execute('DELETE FROM biblioteca.prestamo WHERE id=%s',(results[0],))
    check(snapshot(c)==before,'Datos de referencia después de concurrencia')

def restore(admin,source,dest,c):
    admin.execute(sql.SQL('CREATE DATABASE {}').format(sql.Identifier(dest)))
    with tempfile.TemporaryDirectory(prefix='curso_sql_backup_') as folder:
        dump=str(Path(folder)/'curso.dump')
        run('pg_dump',['-d',source,'-Fc','-f',dump],'backup')
        listing=run('pg_restore',['--list',dump],'inventario_backup')
        check('prestamo_abierto_unico' in listing and 'tienda' in listing,'Inventario del respaldo')
        run('pg_restore',['-d',dest,'--exit-on-error','--no-owner','--no-privileges',dump],'restauracion')
        with connect(dest) as restored:
            check(snapshot(restored)==snapshot(c),'Restauración: todos los valores de tablas coinciden')
            tienda_tests(restored)
            expect(restored,'SELECT prestamo_id,codigo,socio FROM biblioteca.prestamos_abiertos ORDER BY prestamo_id',[(2,'A-02','Luis')],'Vista restaurada')
            execute_file(dest,'proyecto-biblioteca/07_pruebas.sql')
            execute_file(dest,'proyecto-biblioteca/08_permisos_base.sql')
            execute_file(dest,'proyecto-biblioteca/06_roles.sql')
            failure(restored,"INSERT INTO biblioteca.prestamo(socio_id,ejemplar_id,inicio,vence_en) VALUES(1,2,'2026-02-01','2026-02-10')",'23505')
            expect(restored,"SELECT COUNT(*) FROM pg_indexes WHERE schemaname='tienda' AND indexname IN('pedido_cliente_fecha_idx','producto_categoria_idx','detalle_producto_idx')",[(3,)],'Índices tienda restaurados')


def main():
    OUT.mkdir(exist_ok=True)
    documentation()
    for tool in ('psql','pg_dump','pg_restore'):
        check(shutil.which(tool) is not None, f'{tool} en PATH')
    host=os.environ.get('PGHOST','localhost')
    check(host in ('localhost','127.0.0.1','::1'), 'Usa un servidor de práctica local')
    os.environ.setdefault('PGHOST','localhost'); ENV['PGHOST']=os.environ['PGHOST']
    token=uuid.uuid4().hex[:12]
    db='curso_sql_verificacion_'+token
    restored=db+'_restaurada'
    created=[]
    with connect('postgres') as admin:
        version=admin.info.server_version
        check(170000<=version<190000,'Servidor PostgreSQL 17 o 18')
        expect(admin,'SELECT rolsuper FROM pg_roles WHERE rolname=current_user',[(True,)],'El verificador requiere administrador local para bases y roles temporales')
        print(f'PostgreSQL {version}; inicio de comprobación en bases temporales propias',flush=True)
        try:
            admin.execute(sql.SQL('CREATE DATABASE {}').format(sql.Identifier(db))); created.append(db)
            with connect(db) as c:
                for file in sorted((ROOT/'ejemplos/tienda').glob('*.sql')):
                    execute_file(db,file.relative_to(ROOT))
                tienda_tests(c)
                initial=snapshot(c)
                for unit in sorted(ROOT.glob('unidad*')):
                    for name in ('LABORATORIO.sql','SOLUCION.sql','AMPLIACION.sql','PRACTICA.sql'):
                        p=unit/name
                        if p.exists():
                            execute_file(db,p.relative_to(ROOT))
                            check(snapshot(c)==initial,f'{p.relative_to(ROOT)} conserva datos')
                print('Laboratorios, soluciones y consultas comprobados',flush=True)
                import_tests(c); concurrency(db,c)
                for name in ('01_schema.sql','02_datos.sql','03_consultas.sql','04_operaciones.sql','05_indices.sql'):
                    execute_file(db,'proyecto-biblioteca/'+name)
                project_tests(db,c)
                created.append(restored)
                restore(admin,db,restored,c)
                print(f'OK: {COUNT} comprobaciones; consultas, integridad, permisos, concurrencia, CSV y restauración',flush=True)
        finally:
            for name in reversed(created):
                admin.execute(sql.SQL('DROP DATABASE IF EXISTS {} WITH (FORCE)').format(sql.Identifier(name)))
    (OUT/'resultado.txt').write_text(f'OK: {COUNT} comprobaciones\nServidor: {version}\n',encoding='utf-8')

if __name__=='__main__':
    main()
