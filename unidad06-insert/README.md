# Unidad 06 — INSERT: agregar datos

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Insertar una o varias filas, usar DEFAULT y RETURNING y reconocer errores de integridad.

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

## Continuar el curso

- **Unidad anterior:** [Unidad 05 — CREATE TABLE y tipos de datos](../unidad05-create-table/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 07 — SELECT: consultar datos](../unidad07-select/README.md)
