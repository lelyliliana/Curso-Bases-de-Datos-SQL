# Unidad 07: SELECT: consultar datos

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Seleccionar columnas, crear alias y expresiones y distinguir proyección de modificación y reconocer que algunas funciones pueden tener efectos laterales.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

# 1. Consulta
```sql
SELECT id,nombre,precio
FROM producto;
```

# 2. SELECT *
```sql
SELECT * FROM producto;
```
Es útil para exploración. Para reportes/contratos, indicar columnas deja clara la intención y evita traer datos innecesarios.

# 3. Proyección
```sql
SELECT nombre,precio
FROM producto;
```

# 4. Alias
```sql
SELECT nombre AS producto,
       precio AS precio_unitario
FROM producto;
```
El alias cambia el encabezado del resultado, no el esquema.

# 5. Expresiones
```sql
SELECT nombre,
       precio,
       precio * 1.19 AS precio_con_impuesto
FROM producto;
```
El cálculo no actualiza precio.

# 6. Práctica guiada
Datos:

| id | nombre | precio |
|---:|---|---:|
| 1 | Algoritmos | 80 |
| 2 | Bases de Datos | 90 |
| 3 | Teclado | 120 |

Ejecuta:
```sql
SELECT nombre,precio*2 AS precio_dos_unidades
FROM producto;
```

Predice el resultado antes de ejecutarlo.

# 7. SELECT sin FROM
PostgreSQL permite:
```sql
SELECT 2+3 AS resultado;
```

# 8. Errores frecuentes
- Creer que una expresión modifica la tabla.
- Asumir un orden sin ORDER BY.
- Pedir todas las columnas por costumbre.

# 9. Ejercicios
1. Solo nombres.
2. Nombre+precio.
3. Alias.
4. Precio de tres unidades.
5. Descuento calculado sin UPDATE.

# 10. Reto
Diseña consultas distintas para catálogo público, inventario interno y facturación.

# 11. Autoevaluación
1. ¿Qué es proyección?
2. ¿AS modifica la tabla?
3. ¿Una expresión cambia datos?
4. ¿SELECT garantiza orden?
5. ¿Cuándo SELECT * es útil?

# 12. Checklist
- [ ] Selecciono columnas.
- [ ] Uso alias.
- [ ] Creo expresiones.
- [ ] Distingo consultar de modificar.

Continúa con WHERE.


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Qué cambia al calcular un descuento en una consulta?

La proyección selecciona atributos, AS nombra una columna del resultado y una expresión calcula un valor. Esta consulta no contiene operaciones con efectos laterales. En general, SELECT puede llamar funciones que sí modifiquen datos: observa lo que ejecutas, no solo la primera palabra.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad07-select/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Descuentos: 72.00, 81.00, 108.00, 81.00, 45.00. El precio guardado del producto 1 sigue en 80.00.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Muestra id, nombre y costo de tres unidades, sin alterar el precio almacenado.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 06: INSERT: agregar datos](../unidad06-insert/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 08: WHERE y operadores](../unidad08-where/README.md)

