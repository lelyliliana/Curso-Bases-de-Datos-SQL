# Unidad 21 — Integridad referencial

## Qué aprenderás
Comprender qué garantiza una FK y decidir conscientemente qué debe ocurrir al modificar/eliminar filas relacionadas.

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
