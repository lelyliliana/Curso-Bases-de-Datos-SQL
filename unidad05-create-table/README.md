# Unidad 05 — CREATE TABLE y tipos
```sql
CREATE TABLE producto (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 nombre text NOT NULL,
 precio numeric(12,2) NOT NULL CHECK (precio > 0)
);
```
Elige tipos según dominio. Evita guardar números/fechas como texto sin razón. **Reto:** crea esquema de ventas.