# Proyecto final: referencia y revisión razonada

El proyecto admite varias soluciones. [Biblioteca](../proyecto-biblioteca/README.md) es una implementación completa, no el único dominio aceptado. Incluye ocho scripts, cuatro entidades, consulta de disponibilidad, vista, funciones transaccionales, permisos, datos límite y pruebas reproducibles.

## Comparar tu diseño

- **Modelo:** edición y copia se separan; un préstamo vincula socio y copia y guarda sus fechas. La persona puede no tener historial y un libro no tener ejemplares.
- **Normalización:** libro_id determina título; ejemplar_id determina su libro; socio_id determina datos actuales; préstamo determina referencias y fechas. Se explican claves alternativas, no solo ids.
- **Integridad:** FK protege referencias, CHECK compara fechas de una fila e índice parcial limita préstamos abiertos. «Copia inactiva no se presta» se valida en la operación autorizada.
- **Transacción:** la función pertenece a la transacción del llamador; bloquea ejemplar antes de verificar e insertar. Dos solicitudes reales dejan una ganadora, sin doble préstamo.
- **Idempotencia:** repetir devolución con la misma fecha conserva el estado; cambiarla se rechaza. Repetir prestar no es automáticamente idempotente y se rechaza mientras exista préstamo abierto.
- **Permisos:** un lector consulta una vista sin correo; un operador ejecuta funciones sin DML directo. El dueño puede administrar, pero no se usa para demostrar mínimo privilegio.
- **Pruebas:** caso válido, doble préstamo, socio inexistente, ejemplar inactivo, fechas inválidas y devolución repetida. Se conserva la carga inicial con rollback en demostraciones.
- **Operación:** el método de staging y restauración se adapta al dominio y declara límites de ACL y objetos globales. Conteos iguales sin valores coincidentes no bastan.

## Si tu solución difiere

Documenta la regla que explica la diferencia. Por ejemplo, reservar un ejemplar requiere una asociación nueva y estados; multas requieren una política de cálculo, moneda y pagos. No agregues tablas sin una pregunta o regla concreta.

Usa [RUBRICA.md](RUBRICA.md). Un proyecto aprobado debe ser reconstruible y verificable aunque sus consultas o diagrama no coincidan literalmente con el ejemplo.

[Unidad](README.md) · [Práctica](PRACTICA.md)
