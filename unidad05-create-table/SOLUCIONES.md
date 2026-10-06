# Soluciones razonadas: Unidad 05

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Cuaderno, 12.35, true, CU-01. numeric(12,2) redondea al almacenar dos decimales.

**Interpretación:** DEFAULT actúa cuando se omite la columna o se usa DEFAULT; no reemplaza un NULL explícito. CHECK admite TRUE o UNKNOWN, de modo que precio necesita también NOT NULL. IDENTITY genera valores, pero no reemplaza una PK. ALTER TABLE puede bloquear y validar filas existentes; aquí se practica en una tabla temporal.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Crea una tabla temporal de reservas con inicio y fin date obligatorios, CHECK(fin > inicio), y carga una reserva de dos noches.

```sql
CREATE TEMP TABLE reserva_lab (id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,inicio date NOT NULL,fin date NOT NULL,CHECK(fin>inicio)); INSERT INTO reserva_lab(inicio,fin) VALUES ('2026-02-01','2026-02-03'); SELECT fin-inicio AS noches FROM reserva_lab;
```

**Resultado o evidencia:** 2 noches. La comparación es entre columnas de la misma fila.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: DEFAULT actúa cuando se omite la columna o se usa DEFAULT; no reemplaza un NULL explícito. CHECK admite TRUE o UNKNOWN, de modo que precio necesita también NOT NULL. IDENTITY genera valores, pero no reemplaza una PK. ALTER TABLE puede bloquear y validar filas existentes; aquí se practica en una tabla temporal.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
