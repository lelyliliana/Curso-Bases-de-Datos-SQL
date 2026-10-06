# Soluciones razonadas: Unidad 15

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Con pedidos: 1,2,4; sin pedidos: Sara (3). NOT IN produce NULL. Por encima de promedio 86: 2,3,4.

**Interpretación:** EXISTS evalúa presencia de alguna fila y conserva una por cliente. No presupongas que ejecuta físicamente la subconsulta una vez por cada fila: el optimizador puede transformarla. Una subconsulta escalar vacía produce NULL; con más de una fila falla. Una FK NOT NULL en pedido.cliente_id evita NULL allí, pero otras fuentes sí pueden tenerlo.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Busca clientes que compraron Libros en pedidos PAGADO con EXISTS. No cuentes un pedido creado como venta.

```sql
SELECT c.id,c.nombre FROM cliente c WHERE EXISTS (SELECT 1 FROM pedido p JOIN detalle_pedido d ON d.pedido_id=p.id JOIN producto pr ON pr.id=d.producto_id JOIN categoria ca ON ca.id=pr.categoria_id WHERE p.cliente_id=c.id AND p.estado='PAGADO' AND ca.nombre='Libros') ORDER BY c.id;
```

**Resultado o evidencia:** Solo Ana (1). EXISTS no repite su nombre por dos pedidos o varias líneas.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: EXISTS evalúa presencia de alguna fila y conserva una por cliente. No presupongas que ejecuta físicamente la subconsulta una vez por cada fila: el optimizador puede transformarla. Una subconsulta escalar vacía produce NULL; con más de una fila falla. Una FK NOT NULL en pedido.cliente_id evita NULL allí, pero otras fuentes sí pueden tenerlo.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
