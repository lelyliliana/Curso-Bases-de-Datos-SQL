# Soluciones razonadas: Unidad 21

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Dos detalles antes, cero después de borrar pedido 1. Borrar cliente 2 provoca 23503. El rollback restaura todo.

**Interpretación:** El bloque interno captura solo la violación esperada y revierte ese intento. El script no se interrumpe ni oculta otros errores. NO ACTION puede diferirse si una FK es DEFERRABLE; RESTRICT no permite diferir esa comprobación. SET NULL requiere columnas que admitan NULL y un dominio compatible. CASCADE no sustituye una política de conservación de ventas.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Comprueba que no puedes insertar un pedido para un cliente inexistente. Predice el SQLSTATE.

```sql
DO $$ BEGIN BEGIN INSERT INTO pedido(cliente_id,estado) VALUES (999999,'CREADO'); RAISE EXCEPTION 'Faltó validar FK'; EXCEPTION WHEN foreign_key_violation THEN RAISE NOTICE '23503 esperado'; END; END $$;
```

**Resultado o evidencia:** 23503 (foreign_key_violation), sin pedido huérfano.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: El bloque interno captura solo la violación esperada y revierte ese intento. El script no se interrumpe ni oculta otros errores. NO ACTION puede diferirse si una FK es DEFERRABLE; RESTRICT no permite diferir esa comprobación. SET NULL requiere columnas que admitan NULL y un dominio compatible. CASCADE no sustituye una política de conservación de ventas.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
