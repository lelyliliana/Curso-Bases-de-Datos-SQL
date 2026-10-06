# Soluciones razonadas: Unidad 27

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** El lector consulta cuatro categorías y recibe 42501 al insertar. Rol y concesiones desaparecen con rollback.

**Interpretación:** Ejecuta con un administrador en la base de práctica. NOLOGIN sirve para agrupar privilegios; LOGIN habilita una identidad para conectarse. USAGE permite resolver objetos del esquema, SELECT permite leer la tabla y CONNECT permite conexión a la base. Un propietario puede alterar o borrar sus objetos; no verifiques mínimo privilegio con el mismo dueño. Los permisos son acumulativos por membresías y PUBLIC.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Diseña permisos para un analista que lee tablas actuales y futuras de tienda, sin poder crear objetos. Especifica el propietario para default privileges.

```sql
SELECT n.nspname,r.rolname AS propietario FROM pg_namespace n JOIN pg_roles r ON r.oid=n.nspowner WHERE n.nspname='tienda';
```

**Resultado o evidencia:** Devuelve el dueño real. SOLUCIONES.md contiene el esquema de GRANT y ALTER DEFAULT PRIVILEGES; sustituye el propietario identificado.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: Ejecuta con un administrador en la base de práctica. NOLOGIN sirve para agrupar privilegios; LOGIN habilita una identidad para conectarse. USAGE permite resolver objetos del esquema, SELECT permite leer la tabla y CONNECT permite conexión a la base. Un propietario puede alterar o borrar sus objetos; no verifiques mínimo privilegio con el mismo dueño. Los permisos son acumulativos por membresías y PUBLIC.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
