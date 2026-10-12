# Unidad 29: Backup y restauración

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Comprender que una copia solo es confiable cuando puede restaurarse y realizar un ciclo básico con herramientas PostgreSQL.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

# 1. Tener un archivo no basta

```text
backup.dump
```

no demuestra que puedas recuperar el sistema.

Un proceso de backup incluye al menos:
- creación;
- almacenamiento;
- retención;
- restauración probada.

# 2. pg_dump

Para una base de práctica:

```bash
pg_dump -Fc -d curso_sql -f curso_sql.dump
```

`-Fc` usa formato custom, apropiado para restaurar con pg_restore.

Host/usuario/puerto pueden requerir parámetros adicionales.

# 3. Restaurar en otra base

```bash
createdb curso_sql_restaurada
pg_restore -d curso_sql_restaurada curso_sql.dump
```

Hazlo en un entorno de práctica.

# 4. ¿Qué comprobar?

Después:
```sql
SELECT COUNT(*) FROM producto;
SELECT COUNT(*) FROM pedido;
```

Comprueba también:
- constraints;
- vistas;
- objetos esperados;
- consultas críticas.

# 5. Backup lógico

pg_dump genera un respaldo lógico. No es equivalente a copiar arbitrariamente archivos internos del directorio de datos.

PostgreSQL también tiene estrategias físicas/PITR para escenarios más avanzados, fuera del alcance básico de esta unidad.

# 6. RPO y RTO: introducción

**RPO:** cuánto dato podrías aceptar perder medido en tiempo.

**RTO:** cuánto tiempo puedes tardar en recuperar servicio.

Estos objetivos ayudan a decidir frecuencia/estrategia.

No existe “backup diario” universalmente correcto.

# 7. Práctica guiada

1. Cuenta filas.
2. pg_dump.
3. Crea base nueva.
4. pg_restore.
5. Compara conteos.
6. Ejecuta consultas del ejemplo tienda.
7. Documenta resultado.

# 8. Seguridad

Un backup puede contener datos sensibles.

Protege acceso, almacenamiento y transporte según el contexto.

No subas dumps con información privada a repositorios públicos.

# 9. Errores frecuentes
- Nunca probar restauración.
- Guardar copia en el mismo lugar que el único servidor.
- No documentar versión/herramientas.
- Exponer datos sensibles.
- Confundir backup con alta disponibilidad.

# 10. Ejercicios
- backup custom;
- restauración nueva;
- verificar objetos;
- documentar tiempo;
- definir RPO/RTO ficticios.

# 11. Reto
Escribe procedimiento de recuperación de la tienda que otra persona pueda seguir sin preguntarte.

# 12. Autoevaluación
1. ¿Cuándo consideras probado un backup?
2. ¿Qué hace pg_dump?
3. ¿Qué hace pg_restore?
4. ¿Qué es RPO?
5. ¿Qué es RTO?
6. ¿Backup y alta disponibilidad son iguales?

# 13. Checklist
- [ ] Creo respaldo.
- [ ] Restauro.
- [ ] Verifico.
- [ ] Documento.
- [ ] Protejo datos.

Continúa con calidad de datos.


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Qué inventario debes guardar antes de comprobar una restauración?

Un SELECT de conteos prepara evidencia, no crea un backup. pg_dump y pg_restore son ejecutables de terminal, no SQL. El formato custom se restaura con pg_restore; un archivo SQL de formato plain se ejecuta con psql. pg_dump respalda una base pero no los roles globales ni toda la configuración del servidor. Restaurar en otra base evita sobrescribir el origen.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad29-backup/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **categoria 4, cliente 4, detalle 5, pedido 5, producto 5; cuatro FK.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Realiza el ciclo custom en otra base vacía y compara objetos, valores y un rechazo de FK.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

### Ampliación y experimentos

[Procedimiento de respaldo y restauración](RESTAURACION.md).

## Continuar el curso

- **Unidad anterior:** [Unidad 28: Importación y exportación](../unidad28-import-export/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 30: Calidad y limpieza de datos](../unidad30-calidad/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Unidad%2029%20%E2%80%94%20Backup%20y%20restauraci%C3%B3n%20del%20curso%20Bases%20de%20Datos%20y%20SQL%20desde%20cero%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2FCurso-Bases-de-Datos-SQL%2Ftree%2Fmain%2Funidad29-backup%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
