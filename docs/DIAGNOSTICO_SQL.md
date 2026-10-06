# Investigar un resultado inesperado

1. **Conexión:** comprueba current_database(), current_user, versión y search_path. Una tabla ausente puede estar en otra base o esquema.
2. **Población:** ejecuta una consulta simple de las filas participantes. Compara con la carga de referencia, no con datos que modificaste antes.
3. **Lógica:** revisa NULL, paréntesis y extremos. WHERE conserva TRUE; UNKNOWN no pasa.
4. **Cardinalidad:** define qué representa una fila antes de unir. Un pedido con varias líneas se repite legítimamente; dos asociaciones 1:N unidas sin agregar pueden multiplicar medidas.
5. **Integridad:** relaciona SQLSTATE con la restricción. 23505 unicidad, 23502 no nulidad, 23514 CHECK, 23503 FK. No desactives restricciones para ocultar el error.
6. **Transacción:** revisa BEGIN/COMMIT/ROLLBACK, savepoints y bloqueos. 25P02 indica que sigue abortada; 55P03 una espera limitada; 40001 y 40P01 pueden requerir reintentar la operación completa.
7. **Rendimiento:** compara plan, estadísticas, filas estimadas/reales y buffers con volumen suficiente. Un índice no cambia la respuesta lógica.

Entrega consulta exacta, datos ficticios que reproducen el problema, resultado esperado y observado, versión y error completo sin credenciales. «Está mala» no identifica una causa; estas comprobaciones ayudan a localizarla.

[Entorno](ENTORNO.md) · [Caso tienda](CASO_TIENDA.md) · [Índice](../README.md)
