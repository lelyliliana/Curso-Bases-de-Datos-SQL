# Soluciones razonadas: Unidad 18

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Cuatro FK: producto→categoría, pedido→cliente, detalle→pedido y detalle→producto.

**Interpretación:** Un diagrama necesita mínimos y máximos. NOT NULL más FK exige un padre para cada hijo; no exige hijos para cada padre. Detalle representa la asociación N:M entre pedido y producto con cantidad y precio propios. La consulta de catálogo inspecciona lo implementado, no descubre automáticamente todas las reglas del negocio.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Dibuja el modelo tienda y señala una regla que el DER expresa pero una FK sola no garantiza.

```sql
SELECT p.id FROM pedido p WHERE NOT EXISTS(SELECT 1 FROM detalle_pedido d WHERE d.pedido_id=p.id) ORDER BY p.id;
```

**Resultado o evidencia:** Pedido 4. Un pedido creado vacío es válido; exigir detalle al pagar requiere otra operación.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: Un diagrama necesita mínimos y máximos. NOT NULL más FK exige un padre para cada hijo; no exige hijos para cada padre. Detalle representa la asociación N:M entre pedido y producto con cantidad y precio propios. La consulta de catálogo inspecciona lo implementado, no descubre automáticamente todas las reglas del negocio.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
