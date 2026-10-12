# Unidad 06: INSERT: agregar datos

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Insertar una o varias filas, usar DEFAULT y RETURNING y reconocer errores de integridad.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

# 1. Primera fila
```sql
INSERT INTO categoria (nombre)
VALUES ('Libros');
```

# 2. ¿Por qué indicar columnas?
Hace explícita la intención y evita depender innecesariamente del orden físico de columnas.

# 3. Varias filas
```sql
INSERT INTO categoria(nombre)
VALUES ('Tecnología'),('Hogar'),('Papelería');
```

# 4. RETURNING
```sql
INSERT INTO categoria(nombre)
VALUES ('Deportes')
RETURNING id,nombre;
```
PostgreSQL devuelve datos de la fila insertada.

# 5. DEFAULT
Si PRODUCTO tiene `activo DEFAULT true`:
```sql
INSERT INTO producto(categoria_id,nombre,precio)
VALUES (1,'Algoritmos',80.00);
```
activo recibe el valor por defecto.

# 6. Dependencias
```text
CATEGORIA
   ↑ FK
PRODUCTO
```
La categoría debe existir antes de referenciarla.

# 7. Práctica guiada
Inserta una categoría con RETURNING. Usa el id devuelto para insertar un producto y vuelve a usar RETURNING.

Comprueba el valor de activo.

# 8. Provoca errores
**UNIQUE:** repite categoría.  
**CHECK:** precio negativo.  
**FK:** categoria_id inexistente.

Lee el mensaje y relaciona el error con la regla.

# 9. NULL vs cadena vacía
`NULL` representa ausencia/desconocimiento según modelo.  
`''` es una cadena existente de longitud cero.

# 10. Ejercicios
1. Inserta tres clientes.
2. Cinco productos.
3. Usa RETURNING.
4. Omite una columna con DEFAULT.
5. Viola UNIQUE.
6. Viola FK.

# 11. Reto
Carga categoria, producto, cliente, pedido y detalle. Dibuja primero el orden de inserción.

# 12. Autoevaluación
1. ¿Qué hace INSERT?
2. ¿Qué hace RETURNING?
3. ¿Cuándo actúa DEFAULT?
4. ¿Por qué importa el orden entre tablas relacionadas?
5. ¿NULL y '' son iguales?

# 13. Checklist
- [ ] Inserto filas.
- [ ] Inserto varias filas.
- [ ] Uso RETURNING.
- [ ] Comprendo DEFAULT.
- [ ] Diagnostico errores de integridad.

Continúa con SELECT.


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Cómo insertar un padre y usar su identificador sin suponer cuál será el siguiente?

RETURNING permite utilizar el ID que realmente se generó. No calcules MAX(id)+1: dos sesiones podrían obtener el mismo candidato. La CTE con INSERT es una extensión de PostgreSQL que une las dos instrucciones; primero puedes probarlas por separado leyendo el ID devuelto. El ROLLBACK elimina filas, pero no devuelve los valores consumidos de secuencias.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad06-insert/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Producto de laboratorio, 25.00, true, NULL; una categoría nueva dentro de la transacción.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Inserta un cliente ficticio con teléfono omitido y devuelve nombre, correo y teléfono. Verifica después del rollback que no existe.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 05: CREATE TABLE y tipos de datos](../unidad05-create-table/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 07: SELECT: consultar datos](../unidad07-select/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Unidad%2006%20%E2%80%94%20INSERT%20del%20curso%20Bases%20de%20Datos%20y%20SQL%20desde%20cero%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2FCurso-Bases-de-Datos-SQL%2Ftree%2Fmain%2Funidad06-insert%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
