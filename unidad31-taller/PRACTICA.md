# Taller integrador: entrega y comprobación

Resuelve los 16 problemas de [la unidad](README.md) sin mirar el SQL de referencia. Usa [PLANTILLA_SOLUCION.md](PLANTILLA_SOLUCION.md) para cada respuesta. La carga inicial y los resultados están en [CASO_TIENDA.md](../docs/CASO_TIENDA.md).

## Ruta de trabajo

1. Problemas 1–8: escribe pregunta, población, SQL y resultado completo. El promedio del problema 6 usa umbral **90** y todos los productos para esta variante.
2. Problemas 9–10: entrega dependencias y DER, con claves y mínimos/máximos. No basta con separar columnas por intuición.
3. Problemas 11–12: explica FK y demuestra rollback; para una venta exige líneas antes de pagar mediante una operación controlada.
4. Problema 13: usa 100000 filas sintéticas y planes antes/después; no midas únicamente cinco productos.
5. Problemas 14–16: prueba un rol que lee pero no escribe, un lote CSV con rechazos trazables y una restauración en base nueva.

## Evidencia mínima

| Bloque | Evidencia |
|---|---|
| Consultas | SQL y resultados, con una fila límite |
| Diseño | DER, reglas y dependencias |
| Integridad | una aceptación y un rechazo explicado por SQLSTATE |
| Transacción | estado antes/durante/después |
| Rendimiento | datos, estadísticas y dos planes con conclusión |
| Operación | permiso permitido/denegado, conteos de carga y destino restaurado |

Revisa [SOLUCIONES.md](SOLUCIONES.md) después de intentar cada bloque. El laboratorio de consultas se revierte y puede repetirse. Los experimentos administrativos tienen instrucciones propias.
