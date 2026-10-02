# Unidad 30 — Calidad y limpieza de datos

## Qué aprenderás
Perfilar datos antes de corregirlos, definir reglas de calidad y mantener trazabilidad de las transformaciones.

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
