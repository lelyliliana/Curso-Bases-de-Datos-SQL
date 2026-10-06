# Práctica de la Unidad 23

## Preparación

Lee la unidad y carga el [caso tienda](../docs/CASO_TIENDA.md) siguiendo el [entorno](../docs/ENTORNO.md). Ejecuta desde la raíz del repositorio. Trabaja en una base ficticia; la carga de referencia no debe contener modificaciones de ejercicios anteriores.

## A. Predecir y observar

**Pregunta:** ¿Cómo recuperar una parte fallida sin confirmar una operación incompleta?

1. Escribe qué representa una fila del resultado y qué tablas o valores participan.
2. Predice columnas, cantidad de filas y al menos un valor antes de ejecutar.
3. Abre [LABORATORIO.sql](LABORATORIO.sql), lee todas sus sentencias y ejecútalo con psql.
4. Compara con la referencia: Inicial 80; después de recuperar el savepoint queda 85 dentro de la transacción; tras rollback final vuelve a 80.
5. Explica cualquier diferencia verificando base, datos y zona horaria antes de cambiar la consulta.

## B. Resolver sin copiar

Diseña una transferencia de dos cuentas temporales. Bloquea y valida existencia y saldo; demuestra que la suma se conserva al confirmar y al revertir.

Entrega la pregunta en tus palabras, SQL (o modelo cuando corresponda), resultado observado y una explicación. No basta con una captura sin consulta. Especifica población y orden cuando el resultado sea tabular.

## C. Comprobar un límite

Modifica una condición o el dato **dentro de una transacción de práctica**: un extremo, una ausencia o una coincidencia adicional. Escribe primero qué debería cambiar y qué debería mantenerse. Revierte al terminar y comprueba que el caso tienda conserva los conteos iniciales.

## Criterios de logro

- [ ] Puedo justificar la herramienta utilizada para esta pregunta.
- [ ] Distingo el resultado de la consulta del estado guardado en tablas.
- [ ] Identifico al menos un límite o supuesto del ejemplo.
- [ ] Interpreto el resultado sin añadir DISTINCT, COALESCE o un índice por costumbre.
- [ ] Puedo repetir el laboratorio sin acumular filas o dejar transacciones abiertas.

[Soluciones razonadas](SOLUCIONES.md) · [Volver a la unidad](README.md)
