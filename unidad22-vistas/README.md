# Unidad 22: Vistas

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Crear consultas reutilizables como objetos del esquema y distinguir vista normal de tabla y vista materializada.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Una vista normal se actualiza al cambiar la tabla o conserva una copia?

La vista normal conserva la definición; la materializada almacena resultado y puede quedar desactualizada. Este reporte agrupado no es automáticamente actualizable. Una vista no ordena todas las consultas consumidoras: agrega ORDER BY al leer. Para seguridad hay que revisar permisos y semántica del propietario, no solo ocultar columnas visualmente.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad22-vistas/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Vista inicial 320,90,150,0,450. Tras primera actualización: 400. Materializada conserva 400 tras otra actualización, luego REFRESH muestra 480.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Crea una vista de catálogo activo que exponga id, nombre y precio, pero no datos de clientes.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 21: Integridad referencial](../unidad21-integridad/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 23: Transacciones y ACID](../unidad23-transacciones/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Unidad%2022%20%E2%80%94%20Vistas%20del%20curso%20Bases%20de%20Datos%20y%20SQL%20desde%20cero%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2FCurso-Bases-de-Datos-SQL%2Ftree%2Fmain%2Funidad22-vistas%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
