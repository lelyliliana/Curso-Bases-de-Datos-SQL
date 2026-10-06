# Soluciones razonadas: Unidad 20

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Cinco filas de detalle, sin pérdida ni multiplicación accidental. Los precios de venta son 80,120,90,75,90.

**Interpretación:** 2FN exige 1FN y ausencia de dependencias parciales de atributos no primos respecto de cualquier clave candidata. Una PK artificial de una columna no arregla otra clave candidata compuesta con dependencias parciales. 3FN formal: para cada dependencia no trivial X→A, X es superclave o A es primo. La regla de eliminar transitivas es una guía para los casos simples del curso, no toda la definición.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Normaliza inscripción(persona_id,evento_id,persona_nombre,evento_nombre,organizador_id,organizador_nombre,fecha_inscripcion), suponiendo una inscripción por persona y evento.

```sql
SELECT COUNT(*) AS filas_reconstruidas FROM detalle_pedido d JOIN pedido p ON p.id=d.pedido_id JOIN producto pr ON pr.id=d.producto_id;
```

**Resultado o evidencia:** 5 filas en tienda. Para el reto conceptual consulta SOLUCIONES.md y justifica unión sin pérdida.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: 2FN exige 1FN y ausencia de dependencias parciales de atributos no primos respecto de cualquier clave candidata. Una PK artificial de una columna no arregla otra clave candidata compuesta con dependencias parciales. 3FN formal: para cada dependencia no trivial X→A, X es superclave o A es primo. La regla de eliminar transitivas es una guía para los casos simples del curso, no toda la definición.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)

## Inscripciones: separación paso a paso

Clave candidata (persona_id,evento_id), con una inscripción por pareja. persona_id→persona_nombre; evento_id→evento_nombre,organizador_id; organizador_id→organizador_nombre; pareja→fecha_inscripcion.

1. 1FN: una inscripción por fila, sin listas de eventos.
2. 2FN: PERSONA(persona_id,persona_nombre), EVENTO(evento_id,evento_nombre,organizador_id,organizador_nombre), INSCRIPCION(persona_id,evento_id,fecha_inscripcion). Se eliminan dependencias de parte de la clave.
3. 3FN: ORGANIZADOR(organizador_id,organizador_nombre), y EVENTO solo conserva organizador_id.

Las FK a claves únicas permiten reconstruir sin multiplicación. Si el evento admite organizadores conjuntos, cambia la dependencia y se necesita EVENTO_ORGANIZADOR; no aplicar la misma separación sin revisar la regla.
