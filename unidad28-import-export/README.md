# Unidad 28: Importación y exportación

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Mover datos tabulares hacia/desde PostgreSQL, distinguir COPY de \copy y utilizar staging para validar datos externos.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Cómo cargar un CSV sin perder los valores crudos de filas rechazadas?

\copy lee desde el cliente y las rutas relativas parten de la carpeta de ejecución. La fila raw se conserva; la normalización del correo es una regla explícita de este lote ficticio, no una garantía universal. Se rechazan ambas filas duplicadas porque no sabemos cuál es correcta. HEADER omite el primer registro, no verifica que sus nombres coincidan con columnas. Esta clasificación usa ventanas, ampliadas en la unidad 16.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad28-import-export/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **6 recibidas: 2 aceptadas, 2 correo repetido, 1 correo vacío, 1 nombre vacío. Destino Ana y Luis.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Exporta las aceptadas a un archivo CSV y vuelve a importarlas en otra tabla temporal para comprobar el conteo.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 27: Usuarios, roles y privilegios](../unidad27-seguridad/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 29: Backup y restauración](../unidad29-backup/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Unidad%2028%20%E2%80%94%20Importaci%C3%B3n%20y%20exportaci%C3%B3n%20del%20curso%20Bases%20de%20Datos%20y%20SQL%20desde%20cero%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2FCurso-Bases-de-Datos-SQL%2Ftree%2Fmain%2Funidad28-import-export%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
