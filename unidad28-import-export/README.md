# Unidad 28 — Importación y exportación

## Qué aprenderás
Mover datos tabulares hacia/desde PostgreSQL, distinguir COPY de \copy y utilizar staging para validar datos externos.

# 1. El problema

Recibes:

```text
clientes.csv
```

con 50 000 filas.

No queremos insertar manualmente una por una.

# 2. CSV no es “solo texto con comas”

Debes conocer:
- delimitador;
- encabezado;
- codificación;
- comillas;
- representación de NULL;
- formato de fechas/decimales.

Un archivo aparentemente sencillo puede fallar por cualquiera de estos aspectos.

# 3. COPY

`COPY` es una sentencia ejecutada por el servidor PostgreSQL y el acceso al archivo depende del contexto/permisos del servidor.

Ejemplo conceptual:

```sql
COPY staging_cliente
FROM '/ruta/servidor/clientes.csv'
WITH (FORMAT csv, HEADER true);
```

# 4. \copy en psql

```text
\copy staging_cliente FROM 'clientes.csv' WITH (FORMAT csv, HEADER true)
```

`\copy` es un comando de psql y maneja el archivo desde el lado cliente.

Esta diferencia explica muchos “archivo no encontrado”.

# 5. ¿Por qué staging?

Datos externos pueden contener:
- correos inválidos;
- IDs duplicados;
- fechas mal formadas;
- campos vacíos;
- categorías desconocidas.

Una tabla staging permite recibir, perfilar y transformar antes de afectar el modelo principal.

```text
CSV
 ↓
STAGING
 ↓ validar/transformar
MODELO FINAL
```

# 6. Ejemplo de flujo

1. crear staging;
2. importar;
3. contar filas;
4. buscar NULL/duplicados;
5. transformar;
6. insertar válidas;
7. registrar rechazadas.

# 7. Exportación

COPY/\copy también permiten exportar resultados.

Ejemplo psql:

```text
\copy (SELECT id,nombre FROM cliente ORDER BY id) TO 'clientes_salida.csv' WITH (FORMAT csv, HEADER true)
```

# 8. Práctica guiada

Crea CSV pequeño con una fila inválida.

Importa a staging usando columnas de texto si necesitas preservar el valor crudo.

Después identifica la fila inválida antes de insertar al destino.

# 9. Trazabilidad

Registra:
- archivo fuente;
- fecha;
- cantidad recibida;
- aceptadas;
- rechazadas;
- regla de rechazo.

No “limpies” silenciosamente.

# 10. Errores frecuentes
- Confundir COPY/\copy.
- Importar directamente a producción.
- No conocer codificación.
- Convertir errores en NULL sin registro.
- No comprobar conteos.

# 11. Ejercicios
1. Importa CSV válido.
2. Añade duplicado.
3. Añade fecha inválida.
4. Exporta consulta.
5. Compara conteos fuente/destino.

# 12. Reto
Diseña pipeline staging para clientes con reporte de calidad y rechazadas.

# 13. Autoevaluación
1. ¿COPY y \copy son iguales?
2. ¿Dónde se accede al archivo en cada caso?
3. ¿Para qué sirve staging?
4. ¿Qué debes conocer de un CSV?
5. ¿Por qué registrar rechazadas?

# 14. Checklist
- [ ] Importo/exporto.
- [ ] Distingo COPY/\copy.
- [ ] Uso staging.
- [ ] Conservo trazabilidad.

Continúa con backup.
