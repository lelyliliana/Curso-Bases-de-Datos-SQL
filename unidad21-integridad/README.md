# Unidad 21: Integridad referencial

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Comprender qué garantiza una FK y decidir conscientemente qué debe ocurrir al modificar/eliminar filas relacionadas.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

# 1. Una referencia debe existir

```text
PEDIDO.cliente_id → CLIENTE.id
```

Si cliente 999 no existe, una FK puede impedir crear un pedido que lo referencia.

# 2. Crear FK

```sql
cliente_id bigint NOT NULL REFERENCES cliente(id)
```

# 3. ¿Qué ocurre al borrar el padre?

Depende del dominio.

## CASCADE
Borrar padre elimina hijos relacionados.

Puede tener sentido:

```text
PEDIDO → DETALLE_PEDIDO
```

Si el pedido deja de existir, sus líneas quizá no tengan significado independiente.

## RESTRICT / NO ACTION
Impide la operación cuando existen dependencias, con diferencias técnicas de momento de comprobación según configuración/motor.

Puede ser apropiado para proteger historial.

## SET NULL
La referencia se vuelve NULL, si la columna lo permite y el dominio acepta que el hijo sobreviva sin padre.

# 4. No existe una acción universal

Para CLIENTE→PEDIDO, borrar todos los pedidos automáticamente al borrar cliente podría destruir historial.

Quizá la política correcta sea no borrar físicamente al cliente.

La FK implementa una decisión del modelo; no decide el negocio por ti.

# 5. Práctica guiada

Compara:
```text
pedido → detalle
cliente → pedido
categoria → producto
```

Para cada una pregunta:
- ¿el hijo tiene sentido sin padre?
- ¿necesitamos historial?
- ¿se permite borrar el padre?

# 6. Integridad no es solo FK

También:
- PK;
- UNIQUE;
- NOT NULL;
- CHECK;
- tipos;
- transacciones.

La calidad se protege en varias capas.

# 7. Errores frecuentes
- Usar CASCADE en todas partes.
- Desactivar FK para poder borrar.
- Creer que FK valida toda regla del negocio.
- Permitir SET NULL donde NULL no tiene significado válido.

# 8. Ejercicios
Decide política para:
- pedido/detalle;
- autor/libro;
- cliente/pedido;
- curso/matrícula;
- categoría/producto.

# 9. Reto
Construye una matriz de FK del proyecto final con acción de borrado y justificación.

# 10. Autoevaluación
1. ¿Qué garantiza FK?
2. ¿Qué hace CASCADE?
3. ¿Cuándo SET NULL tiene sentido?
4. ¿Por qué no usar CASCADE por defecto?
5. ¿Qué otras restricciones protegen integridad?

# 11. Checklist
- [ ] Creo FK.
- [ ] Entiendo acciones.
- [ ] Decido según dominio.
- [ ] Protejo historial conscientemente.

Continúa con vistas.


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Qué cambia al borrar un padre protegido o un pedido con CASCADE?

El bloque interno captura solo la violación esperada y revierte ese intento. El script no se interrumpe ni oculta otros errores. NO ACTION puede diferirse si una FK es DEFERRABLE; RESTRICT no permite diferir esa comprobación. SET NULL requiere columnas que admitan NULL y un dominio compatible. CASCADE no sustituye una política de conservación de ventas.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad21-integridad/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Dos detalles antes, cero después de borrar pedido 1. Borrar cliente 2 provoca 23503. El rollback restaura todo.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Comprueba que no puedes insertar un pedido para un cliente inexistente. Predice el SQLSTATE.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 20: Normalización: 1FN, 2FN y 3FN](../unidad20-normalizacion/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 22: Vistas](../unidad22-vistas/README.md)

