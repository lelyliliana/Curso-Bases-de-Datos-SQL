# Unidad 25 — Índices

## Qué aprenderás
Comprender qué problema resuelve un índice, sus costos y por qué el optimizador puede decidir no usarlo.

# 1. Buscar sin índice

Imagina un libro sin índice alfabético: para encontrar un término quizá debas recorrer muchas páginas.

Una tabla puede requerir un recorrido amplio para encontrar filas.

# 2. Crear índice

```sql
CREATE INDEX idx_producto_nombre
ON producto(nombre);
```

Esto crea una estructura adicional para ciertos accesos por nombre.

# 3. No cambia el resultado lógico

```sql
SELECT * FROM producto
WHERE nombre='Teclado';
```

Debe devolver el mismo resultado correcto con o sin índice.

El índice busca cambiar el costo de encontrarlo, no la semántica.

# 4. Costo

Índices:
- ocupan almacenamiento;
- deben mantenerse en INSERT;
- pueden afectar UPDATE/DELETE;
- añaden decisiones al diseño.

Por eso “indexar todas las columnas” no es estrategia.

# 5. PostgreSQL decide

Con una tabla de tres filas, leer toda la tabla puede ser más barato que usar índice.

Crear un índice **no obliga** a PostgreSQL a elegirlo.

# 6. B-tree

Es el tipo predeterminado/común para muchas comparaciones de igualdad y rango.

PostgreSQL también ofrece Hash, GiST, SP-GiST, GIN, BRIN, entre otros, para necesidades específicas.

No memorices “qué índice usar” sin comprender operador, distribución y consulta.

# 7. Índices compuestos

```sql
CREATE INDEX idx_pedido_cliente_fecha
ON pedido(cliente_id,fecha);
```

El orden de columnas importa para qué patrones de consulta puede ayudar.

No es equivalente automáticamente a tener dos índices separados.

# 8. Índice único

```sql
CREATE UNIQUE INDEX ...
```

Puede proteger unicidad, aunque normalmente expresamos reglas de negocio de unicidad mediante constraint UNIQUE cuando ese es el propósito semántico.

# 9. Práctica guiada

1. Ejecuta EXPLAIN de búsqueda por nombre.
2. Crea índice.
3. Repite.
4. Si sigue Seq Scan, no concluyas que está roto.
5. Genera más datos de práctica.
6. Compara de nuevo.

# 10. Selectividad

Una columna con muy pocos valores distintos (por ejemplo boolean) puede no ser buen candidato para un índice simple en muchas consultas, aunque depende de distribución y predicado.

La respuesta real se mide.

# 11. Errores frecuentes
- Indexar todo.
- Suponer que índice siempre se usa.
- Medir con tres filas.
- Crear índices sin partir de consultas.
- Ignorar costo de escritura.

# 12. Ejercicios
Elige índices para:
- búsqueda por correo;
- pedidos de un cliente por fecha;
- producto por código único;
- filtros de baja selectividad.

Justifica o rechaza cada uno.

# 13. Reto
Selecciona tres consultas reales, propone índices y formula qué evidencia esperarías en EXPLAIN.

# 14. Autoevaluación
1. ¿Qué cambia un índice?
2. ¿Cambia resultados?
3. ¿Qué costos añade?
4. ¿PostgreSQL debe usarlo?
5. ¿Por qué importa orden en índice compuesto?
6. ¿Qué significa selectividad?

# 15. Checklist
- [ ] Creo índices con propósito.
- [ ] Comprendo costo.
- [ ] No exijo que se usen.
- [ ] Parto de consultas reales.

Continúa con EXPLAIN.
