# Unidad 22 — Vistas

## Qué aprenderás
Crear consultas reutilizables como objetos del esquema y distinguir vista normal de tabla y vista materializada.

# 1. Consulta repetida

```sql
SELECT p.id,c.nombre,SUM(d.cantidad*d.precio_unitario) total
FROM pedido p
JOIN cliente c ON c.id=p.cliente_id
JOIN detalle_pedido d ON d.pedido_id=p.id
GROUP BY p.id,c.nombre;
```

Si muchos consumidores necesitan este resultado, podemos darle un nombre.

# 2. Crear vista

```sql
CREATE VIEW resumen_pedidos AS
SELECT p.id AS pedido_id,
       c.nombre AS cliente,
       SUM(d.cantidad*d.precio_unitario) AS total
FROM pedido p
JOIN cliente c ON c.id=p.cliente_id
JOIN detalle_pedido d ON d.pedido_id=p.id
GROUP BY p.id,c.nombre;
```

Luego:
```sql
SELECT * FROM resumen_pedidos;
```

# 3. ¿Guarda los datos?

Una vista normal representa una consulta almacenada como definición. No es simplemente “otra tabla con copia de los datos”.

Cuando consultas la vista, PostgreSQL planifica la consulta subyacente.

# 4. Ventajas

- encapsular consulta;
- ofrecer contrato simplificado;
- controlar exposición de columnas junto con privilegios;
- reutilizar lógica de consulta.

# 5. Limitaciones

Una vista no convierte una consulta lenta en rápida por existir.

Tampoco todas las vistas son actualizables de la misma forma.

# 6. Vista materializada

PostgreSQL ofrece materialized views, que almacenan físicamente el resultado y necesitan actualización/refresh.

Es otro concepto y tiene trade-offs de frescura, almacenamiento y mantenimiento.

# 7. Práctica guiada

Crea `resumen_pedidos`, consulta y después agrega un nuevo detalle.

Vuelve a consultar la vista normal y observa el resultado actualizado.

# 8. Errores frecuentes
- Creer que vista normal copia datos.
- Usarla para ocultar un modelo incomprensible.
- Suponer que mejora rendimiento.
- Dar permisos sin revisar qué columnas expone.

# 9. Ejercicios
Crea vistas de:
- catálogo activo;
- pedidos con total;
- ventas por cliente.

# 10. Reto
Diseña una vista para un usuario de reportes que no deba acceder a todas las columnas internas.

# 11. Autoevaluación
1. ¿Qué almacena conceptualmente una vista normal?
2. ¿Vista y tabla son iguales?
3. ¿Qué es materialized view?
4. ¿Una vista garantiza rendimiento?
5. ¿Cómo puede ayudar como contrato?

# 12. Checklist
- [ ] Creo vistas.
- [ ] Distingo tabla/vista.
- [ ] Distingo vista/materializada.
- [ ] Uso vistas con propósito.

Continúa con transacciones.
