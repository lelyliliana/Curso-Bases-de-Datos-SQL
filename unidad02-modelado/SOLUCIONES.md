# Soluciones razonadas: Unidad 02

## Caso guiado

ORGANIZADOR 1 a 0..N EVENTO; EVENTO 1 a 0..N INSCRIPCION; ASISTENTE 1 a 0..N INSCRIPCION. Cada inscripción tiene exactamente un evento y un asistente. Bajo el supuesto de inscripción única por evento: clave candidata (evento_id,asistente_id). Si hay varios intentos o entradas transferibles, distingue inscripción de entrada y vuelve a definir unicidad.

Fecha de inscripción pertenece a INSCRIPCION; capacidad a EVENTO. No pongas fecha de pago en ASISTENTE porque una persona puede pagar varias inscripciones. Si una inscripción admite abonos, PAGO es una entidad hija con importe y fecha. Capacidad no negativa se protege por fila, pero «inscritos no superan capacidad» requiere coordinación entre filas; una FK no resuelve esa regla.

Preguntas que cambian el modelo: ¿organizadores conjuntos?, ¿inscripción cancelada permite volver a inscribirse?, ¿evento gratuito admite pagos?, ¿una persona compra para otras?, ¿cómo se controla el cupo concurrentemente? Distingue reglas confirmadas de dudas. No confundas participación mínima cero con ausencia de una FK obligatoria del otro lado.

## Aplicación independiente

RESERVA(id,titular_id,inicio,fin), RESERVA_HABITACION(reserva_id,habitacion_id), HUESPED y RESERVA_HUESPED. Dos reservas no deben solapar una misma habitación según estado; requiere una restricción de exclusión sobre rangos o una operación que coordine conflictos, no UNIQUE(habitacion_id) para todos los tiempos.

## Comprobar el razonamiento

Cambiar un supuesto puede producir otra solución válida. Explica el supuesto, prueba dos escenarios y revisa que el modelo no acepte un caso prohibido ni rechace uno permitido. Los datos de prueba ayudan a encontrar contradicciones; no sustituyen reglas del dominio.

[Práctica](PRACTICA.md) · [Unidad](README.md)
