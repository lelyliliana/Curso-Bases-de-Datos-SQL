# Versión 2.0

## Contenido

33 unidades en el orden original, con objetivos, explicación, ejemplos, práctica y soluciones razonadas. Unidades 00–03 desarrollan modelos conceptuales sin exigir instalar el gestor. Unidades 04–31 incluyen 28 laboratorios SQL; 04–30 tienen además 27 soluciones SQL. La Unidad 16 amplía CTE recursivas y funciones de ventana.

La tienda contiene datos reproducibles, precios históricos, NULL, empates, categorías/clientes sin hijos y pedido vacío. El taller integra 16 problemas. La biblioteca final aporta ocho scripts de reconstrucción, consulta, operación, permisos y pruebas.

## Entorno y comprobación

Referencia PostgreSQL 18, compatibilidad comprobada también en 17. Instrucciones separadas para Ubuntu, Windows y macOS; SQL compartido. Verificador con resultados esperados, restricciones, rollback/savepoint, CSV, permisos, conexiones simultáneas y respaldo/restauración real. GitHub Actions configura cinco combinaciones de sistema y versión (ver docs/VERIFICACION.md).

## Límites de las evidencias

Las comprobaciones automáticas verifican escenarios y resultados definidos, no todas las reglas de cualquier negocio. Planes y tiempos dependen del entorno. El backup de práctica adapta propietario y ACL, y la política de acceso se reaplica y prueba por separado. Las ampliaciones requieren definir nuevas reglas antes de agregar tablas o funciones.

[Índice](README.md) · [Verificación](docs/VERIFICACION.md)
