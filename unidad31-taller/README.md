# Unidad 31 — Taller integrador de SQL

Esta unidad cambia la dinámica: ya no te indica qué cláusula usar. Debes identificar la herramienta.

## Cómo trabajar

Para cada problema:
1. escribe la pregunta en tus palabras;
2. identifica tablas;
3. predice una fila del resultado;
4. escribe SQL;
5. prueba casos límite;
6. explica el resultado;
7. compara una alternativa cuando exista.

Usa `PLANTILLA_SOLUCION.md`.

# Nivel 1 — Fundamentos

## Problema 1 — Catálogo
Lista productos activos con nombre, categoría y precio, ordenados alfabéticamente.

## Problema 2 — Inventario lógico
Encuentra categorías sin productos.

## Problema 3 — Clientes
Encuentra clientes que nunca han realizado pedidos.

# Nivel 2 — Agregación

## Problema 4 — Total de pedido
Calcula total por pedido.

## Problema 5 — Clientes
Calcula valor total pagado por cliente considerando únicamente pedidos PAGADO.

## Problema 6 — Categorías
Muestra categorías cuyo precio promedio supere un umbral.

# Nivel 3 — Consultas alternativas

## Problema 7
Resuelve “clientes con pedidos” usando EXISTS y JOIN. Compara.

## Problema 8
Reescribe un reporte complejo usando CTE.

# Nivel 4 — Diseño

## Problema 9
Recibes:
```text
pedido,cliente,correo,producto,categoria,cantidad
```
Detecta anomalías y normaliza.

## Problema 10
Diseña DER para proveedores y compras.

# Nivel 5 — Integridad y transacciones

## Problema 11
Define acciones FK para cliente/pedido y pedido/detalle.

## Problema 12
Diseña una operación todo-o-nada y demuéstrala con ROLLBACK.

# Nivel 6 — Rendimiento

## Problema 13
Elige una consulta, genera volumen suficiente, captura EXPLAIN, propone índice y vuelve a medir.

No se acepta “mejoró” sin evidencia.

# Nivel 7 — Operación

## Problema 14
Diseña rol de solo lectura.

## Problema 15
Importa un CSV imperfecto mediante staging.

## Problema 16
Crea backup, restaura en otra base y verifica.

# Autoevaluación final

Antes del proyecto debes poder:
- modelar sin empezar por SQL;
- crear esquema;
- cargar/consultar;
- combinar/agrupar;
- normalizar;
- proteger integridad;
- usar transacciones;
- razonar concurrencia;
- medir un índice;
- importar datos;
- restaurar backup.

Si algún punto todavía requiere copiar una solución sin comprenderla, vuelve a esa unidad antes del proyecto.
