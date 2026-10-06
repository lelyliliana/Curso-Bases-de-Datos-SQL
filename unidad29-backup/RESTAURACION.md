# Respaldo lógico y restauración comprobada

Trabaja con datos ficticios y una segunda base **vacía**. En estos comandos el usuario `estudiante` es dueño de curso_sql. Para crear la segunda base necesitas una sesión administrativa (no se concede CREATEDB al estudiante solo para esta práctica).

## 1. Registrar el origen

Desde psql en curso_sql:

```sql
SELECT version(),current_database();
SELECT COUNT(*) FROM tienda.producto;
SELECT p.id,COALESCE(SUM(d.cantidad*d.precio_unitario),0) AS total
FROM tienda.pedido p LEFT JOIN tienda.detalle_pedido d ON d.pedido_id=p.id
GROUP BY p.id ORDER BY p.id;
```

Referencia: cinco productos, totales 320/90/150/0/450. Anota también fecha del respaldo y versión de `pg_dump --version`.

## 2. Crear el archivo (terminal)

Desde una carpeta donde puedas escribir:

```text
pg_dump -h localhost -U estudiante -d curso_sql -Fc -f curso_sql.dump
pg_restore --list curso_sql.dump
```

`pg_dump` obtiene una vista consistente de la base; no requiere cerrar todas las lecturas. El listado permite inspeccionar objetos del archivo, pero aún no demuestra una restauración. Una herramienta pg_dump de versión mayor anterior a la del servidor puede negarse a trabajar: usa la misma versión mayor para la práctica.

## 3. Crear un destino nuevo

En psql como administrador conectado a postgres:

```sql
CREATE DATABASE curso_sql_restaurada OWNER estudiante;
```

Si el nombre ya existe y contiene datos, elige otro. No uses `--clean` para resolver el conflicto sin entender qué borraría.

## 4. Restaurar (terminal)

```text
pg_restore -h localhost -U estudiante -d curso_sql_restaurada --exit-on-error --no-owner --no-privileges curso_sql.dump
```

Estas opciones adaptan los objetos al usuario que restaura y omiten ACL. Sirven para comprobar estructura y datos sin depender de identidades originales. **No prueban que se restauró el modelo de permisos.** En una recuperación real hay que reconstruir roles y concesiones explícitamente, o restaurar ACL con las identidades adecuadas y verificar accesos. En particular, al omitir ACL de funciones se pierde una revocación de EXECUTE a PUBLIC y puede restablecerse el permiso predeterminado. La biblioteca incluye un [script para reaplicar esa política base](../proyecto-biblioteca/08_permisos_base.sql). La restauración debe completarse sin habilitar accesos de usuarios hasta reconstruir y probar permisos.

Un respaldo de formato plain SQL utiliza psql con `-v ON_ERROR_STOP=1 -f archivo.sql`; no es intercambiable con este archivo custom. pg_dump respalda una base, no roles globales, parámetros del servidor ni archivos externos. `pg_dumpall --globals-only` permite respaldar objetos globales con los permisos necesarios; su archivo puede contener información sensible.

## 5. Verificar el destino

Conecta a curso_sql_restaurada y repite consultas del paso 1. Ejecuta también:

```sql
SELECT COUNT(*) FROM pg_constraint
WHERE contype='f' AND connamespace='tienda'::regnamespace;
BEGIN;
INSERT INTO tienda.pedido(cliente_id,estado) VALUES(999999,'CREADO');
-- Debe fallar por FK (23503).
ROLLBACK;
```

Comprueba cuatro FK, conteos de las cinco tablas y valores críticos, no solo «el comando terminó». Si creaste vistas e índices de tu proyecto, revisa sus definiciones y ejecuta sus consultas. Dos bases con el mismo conteo pueden contener valores diferentes.

## 6. Registrar recuperación y límites

Entrega origen/destino, versiones, tamaño del archivo, resultados y tiempo observado. Define para el caso un RPO (pérdida máxima tolerable de datos medida en tiempo) y RTO (tiempo objetivo de recuperar servicio). Un backup diario puede perder casi un día según el momento del incidente. Una réplica puede replicar un borrado accidental: disponibilidad y backup resuelven necesidades diferentes.

El backup lógico de esta unidad no permite recuperar por sí solo cada instante entre respaldos. PITR requiere una estrategia de respaldo físico más archivo de WAL y pruebas de recuperación. El curso presenta esa distinción, sin convertir una copia lógica en una promesa de PITR.

Conserva dumps ficticios fuera de Git; protege los de sistemas reales según sus datos. Verifica restauración periódicamente y documenta fallos para corregir el procedimiento.

[Unidad](README.md) · [Verificación automática](../docs/VERIFICACION.md)
