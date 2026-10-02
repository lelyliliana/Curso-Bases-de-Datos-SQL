# Unidad 09 — ORDER BY, LIMIT y DISTINCT

## Qué aprenderás
Ordenar, limitar y eliminar duplicados del resultado de forma consciente.

# 1. Orden
Sin ORDER BY no asumas orden estable.

```sql
SELECT nombre,precio
FROM producto
ORDER BY precio ASC;
```

DESC invierte el sentido.

# 2. Empates
```sql
ORDER BY precio DESC,id ASC;
```
El segundo criterio hace determinista el desempate.

# 3. LIMIT
```sql
SELECT id,nombre,precio
FROM producto
ORDER BY precio DESC,id
LIMIT 3;
```
Esto sí expresa “los tres primeros según ese orden”.

# 4. DISTINCT
```sql
SELECT DISTINCT producto_id
FROM detalle_pedido;
```
Elimina duplicados del resultado seleccionado.

# 5. DISTINCT no repara un JOIN
Si un pedido tiene tres detalles, tres filas pueden ser correctas. No añadas DISTINCT hasta entender la cardinalidad.

# 6. Práctica guiada
Con precios 80,90,120,90:
1. ordénalos desc;
2. resuelve empate por id;
3. toma LIMIT 2;
4. predice el resultado.

# 7. Ejercicios
1. Más barato.
2. Más caro.
3. Alfabético.
4. Top 5.
5. Estados únicos.
6. Dos criterios.

# 8. Reto
Construye ranking determinista aunque existan empates.

# 9. Autoevaluación
1. ¿Por qué ORDER BY?
2. ¿ASC/DESC?
3. ¿Qué hace LIMIT?
4. ¿Por qué LIMIT sin ORDER BY no define top?
5. ¿Qué hace DISTINCT?
6. ¿Por qué puede ocultar un problema?

# 10. Checklist
- [ ] Ordeno.
- [ ] Resuelvo empates.
- [ ] Uso LIMIT con orden.
- [ ] Uso DISTINCT con intención.

Continúa con UPDATE y DELETE.
