# Unidad 25: Índices

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Comprender qué problema resuelve un índice, sus costos y por qué el optimizador puede decidir no usarlo.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Por qué un índice útil en una tabla grande puede ignorarse en una tabla pequeña?

El filtro selecciona 100 de 100000 filas: es suficientemente selectivo para explorar una ruta por índice, sin exigir que un nodo específico aparezca. La PK y UNIQUE ya generan índices; una FK no crea automáticamente uno en su lado hijo. Un B-tree compuesto favorece filtros por columnas iniciales, aunque el optimizador puede usar otras estrategias según versión y distribución. No es una regla de imposible uso sin la primera columna.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad25-indices/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **100 coincidencias antes y después. Los planes y tiempos exactos dependen del entorno.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Compara igualdad selectiva con cliente_id>=0. ¿El mismo índice es útil para todas las filas?

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 24: Concurrencia y aislamiento](../unidad24-concurrencia/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 26: EXPLAIN y planes de ejecución](../unidad26-explain/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Unidad%2025%20%E2%80%94%20%C3%8Dndices%20del%20curso%20Bases%20de%20Datos%20y%20SQL%20desde%20cero%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2FCurso-Bases-de-Datos-SQL%2Ftree%2Fmain%2Funidad25-indices%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
