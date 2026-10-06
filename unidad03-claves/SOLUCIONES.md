# Soluciones razonadas: Unidad 03

## Caso guiado

Clave candidata (estudiante_id,curso_id,periodo). Es mínima bajo la regla: quitar cualquiera permitiría ambigüedad. Una superclave puede agregar fecha y seguir identificando, pero ya no es mínima. Puedes elegir PK compuesta o id técnico con UNIQUE(estudiante_id,curso_id,periodo) y NOT NULL en sus componentes. Nota puede ser NULL antes de calificar; CHECK(nota BETWEEN 0 AND 5) limita valores presentes, no obliga a calificar.

En PostgreSQL, UNIQUE permite normalmente varios NULL: NULL no se considera igual a otro NULL para esa restricción. UNIQUE NULLS NOT DISTINCT cambia esa política. Una PK combina unicidad con no nulidad, y solo hay una PK por tabla. IDENTITY sin PK o UNIQUE no garantiza unicidad de la tabla.

Un CHECK se satisface con TRUE o UNKNOWN; por ello CHECK(precio>0) debe acompañarse de NOT NULL si el precio es obligatorio. No valida otras filas ni la existencia de un padre: usa FK para eso. Una FK nullable permite ausencia del padre; FK más NOT NULL exige una referencia válida. No evalúa que un padre tenga hijos.

## Aplicación independiente

Bajo una sola reserva vigente por asiento: UNIQUE(vuelo_id,numero_asiento) con ambos NOT NULL, FK al vuelo y reserva. Si se conserva historial de canceladas, una unicidad global bloquearía reservas nuevas; necesita distinguir estado vigente, por ejemplo índice único parcial, y documentar la política. El ID técnico no resuelve ese conflicto.

## Comprobar el razonamiento

Cambiar un supuesto puede producir otra solución válida. Explica el supuesto, prueba dos escenarios y revisa que el modelo no acepte un caso prohibido ni rechace uno permitido. Los datos de prueba ayudan a encontrar contradicciones; no sustituyen reglas del dominio.

[Práctica](PRACTICA.md) · [Unidad](README.md)
