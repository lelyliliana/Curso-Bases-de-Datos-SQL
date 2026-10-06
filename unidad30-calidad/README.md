# Unidad 30: Calidad y limpieza de datos

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Perfilar datos antes de corregirlos, definir reglas de calidad y mantener trazabilidad de las transformaciones.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

# 1. “Limpiar” no significa borrar lo raro

Recibes 10 000 clientes.

Problemas:
- 500 sin correo;
- 40 correos duplicados;
- fechas imposibles;
- nombres con espacios;
- códigos desconocidos.

Antes de modificar, **mide**.

# 2. Dimensiones prácticas

Podemos revisar:
- completitud;
- unicidad;
- validez;
- consistencia;
- oportunidad/actualidad según el caso.

No existe una única lista universal para todos los dominios.

# 3. NULL

```sql
SELECT COUNT(*) FILTER (WHERE correo IS NULL) AS sin_correo,
       COUNT(*) AS total
FROM staging_cliente;
```

Ahora puedes reportar una cantidad/proporción.

# 4. Duplicados

```sql
SELECT correo,COUNT(*) AS cantidad
FROM staging_cliente
WHERE correo IS NOT NULL
GROUP BY correo
HAVING COUNT(*) > 1;
```

Antes de eliminar, pregunta:
- ¿son realmente la misma persona?
- ¿qué regla define duplicado?

# 5. Rangos

```sql
SELECT *
FROM staging_producto
WHERE precio <= 0;
```

La regla proviene del dominio.

# 6. Formatos vs significado

Que un texto tenga forma de fecha no significa que sea una fecha válida para el negocio.

```text
2099-01-01
```

puede ser sintácticamente válida pero imposible si representa fecha de nacimiento de una persona actual.

# 7. Staging

```text
fuente original
      ↓
   STAGING
      ↓ perfil
      ↓ reglas
válidas ──→ modelo final
rechazadas → registro de errores
```

Conserva el valor original cuando la trazabilidad sea importante.

# 8. Transformaciones

Ejemplo:
```sql
UPDATE staging_cliente
SET nombre = trim(nombre);
```

Antes:
- cuenta filas afectadas;
- conserva evidencia;
- justifica regla.

No conviertas automáticamente todas las cadenas vacías en NULL sin saber si significan lo mismo.

# 9. Reporte de calidad

| regla | evaluadas | inválidas | porcentaje |
|---|---:|---:|---:|
| correo obligatorio | 10000 | 500 | 5% |
| correo único | 9500 | 40 | ... |

Esto convierte “los datos están sucios” en evidencia.

# 10. Práctica guiada

Crea staging con:
- duplicado;
- NULL;
- espacios;
- precio negativo.

Perfila cada problema antes de corregir.

# 11. Errores frecuentes
- Corregir sin medir.
- Eliminar duplicados por coincidencia superficial.
- Sobrescribir el valor original.
- Aplicar reglas no documentadas.
- Confundir dato extraño con dato incorrecto.

# 12. Ejercicios
Define y mide cinco reglas sobre la tienda.

# 13. Reto
Produce informe antes/después de limpieza con regla, cantidad, transformación y resultado.

# 14. Autoevaluación
1. ¿Por qué perfilar antes?
2. ¿Duplicado visual siempre significa misma entidad?
3. ¿Qué aporta staging?
4. ¿Qué diferencia hay entre validez sintáctica y de negocio?
5. ¿Por qué conservar trazabilidad?

# 15. Checklist
- [ ] Perfilo.
- [ ] Documento reglas.
- [ ] Separo staging/final.
- [ ] Conservo rechazadas/evidencia.
- [ ] Mido antes/después.

Ahora estás listo para integrar lo aprendido.


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Cómo medir calidad y conservar el dato original antes de corregir espacios?

La clasificación registra una primera causa por fila; el perfil puede registrar varias incidencias y su suma superar el número de rechazadas. pg_input_is_valid verifica conversión del tipo, no todas las reglas del dominio. numeric admite valores especiales como NaN; una política real puede requerir rechazarlos explícitamente. No sobrescribas raw ni inventes un nombre para pasar NOT NULL.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad30-calidad/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **4 filas; 2 sin nombre; 1 precio no numérico. Reglas por id: ACEPTADO, PRECIO_NO_POSITIVO, NOMBRE_VACIO, NOMBRE_VACIO.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Calcula porcentaje de filas con nombre vacío y explica si el denominador son filas o valores no nulos.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 29: Backup y restauración](../unidad29-backup/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 31: Taller integrador de SQL](../unidad31-taller/README.md)

