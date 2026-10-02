# Unidad 29 — Backup y restauración

## Qué aprenderás
Comprender que una copia solo es confiable cuando puede restaurarse y realizar un ciclo básico con herramientas PostgreSQL.

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

# 6. RPO y RTO — introducción

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
