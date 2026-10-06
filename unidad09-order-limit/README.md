# Unidad 09: ORDER BY, LIMIT y DISTINCT

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Ordenar, limitar y eliminar duplicados del resultado de forma consciente.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Cómo obtener un top reproducible si dos productos cuestan lo mismo?

DISTINCT compara todas las columnas proyectadas: SELECT DISTINCT id,precio conservaría los cinco productos porque id es diferente. LIMIT sin orden no expresa los más caros. Agregar id desempata; NULLS LAST explicita dónde van los desconocidos. Para páginas grandes, OFFSET recorre filas anteriores y puede cambiar si llegan nuevos datos; una clave de continuación estable puede ser preferible.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad09-order-limit/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Top: Teclado (3,120), Bases de datos (2,90), Mouse (4,90). Precios distintos: 50,80,90,120.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Obtén los dos productos más baratos, desempata por id y explica qué pasaría si ambos tuvieran el mismo precio.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 08: WHERE y operadores](../unidad08-where/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 10: UPDATE y DELETE](../unidad10-update-delete/README.md)

