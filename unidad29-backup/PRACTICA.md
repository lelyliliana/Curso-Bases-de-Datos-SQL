# Práctica — Backup y restauración

Ejemplo de formato custom:
```bash
pg_dump -Fc -d mi_base -f mi_base.dump
createdb mi_base_restaurada
pg_restore -d mi_base_restaurada mi_base.dump
```

Los parámetros exactos dependen de host, usuario y entorno.

## Verificación
No basta con que pg_restore termine:
- tablas;
- conteos;
- restricciones;
- consultas críticas.

## Reto
Documenta fecha, herramienta, archivo y resultado de restauración.
