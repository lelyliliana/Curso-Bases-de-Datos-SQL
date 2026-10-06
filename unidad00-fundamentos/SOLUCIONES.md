# Soluciones razonadas: Unidad 00

## Caso guiado

La fecha debe indicar si corresponde a atención, registro o modificación. El diagnóstico describe una consulta, no una mascota para siempre. Identifica PROPIETARIO, MASCOTA, VETERINARIO y CONSULTA. Suponiendo un responsable actual por mascota, cada mascota pertenece a uno; cada consulta corresponde a una mascota y a un veterinario. Cambiar ese supuesto (custodia compartida o varios veterinarios) cambia las asociaciones. No inventes una única regla universal.

Tres controles: referencias a mascotas existentes, validación de fechas/tipos y una actualización coherente del teléfono actual del propietario. Una transacción agrupa cambios, los permisos limitan quién modifica y un respaldo probado permite recuperar. Ninguno descubre por sí solo un teléfono que está equivocado pero tiene un formato válido. Una hoja pequeña de uso individual puede ser apropiada; un proceso compartido con historial y reglas requiere otras garantías.

## Aplicación independiente

Entrega una tabla de requisitos. Para ventas, evita varias copias desconectadas; la base compartida permite transacciones e integridad. Para la lista individual, una hoja puede bastar. La decisión se basa en necesidades, no en número de filas únicamente.

## Comprobar el razonamiento

Cambiar un supuesto puede producir otra solución válida. Explica el supuesto, prueba dos escenarios y revisa que el modelo no acepte un caso prohibido ni rechace uno permitido. Los datos de prueba ayudan a encontrar contradicciones; no sustituyen reglas del dominio.

[Práctica](PRACTICA.md) · [Unidad](README.md)
