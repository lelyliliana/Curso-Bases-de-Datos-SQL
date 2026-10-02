# Guía mínima de psql

Comandos de psql comienzan con barra invertida:
```text
\l      bases
\c      conectar
\dt     tablas
\d tabla
\q
```

SQL termina normalmente con punto y coma:
```sql
SELECT current_database();
```

## Diferencia
`\dt` es comando del cliente psql; `SELECT` es SQL enviado al servidor.

## Reto
Conéctate, lista tablas, describe una y ejecuta consulta.
