SET TIME ZONE 'UTC';
-- P1: ejemplares activos sin préstamo abierto (1 y 3).
SELECT e.id,e.codigo,l.titulo FROM biblioteca.ejemplar e JOIN biblioteca.libro l ON l.id=e.libro_id
WHERE e.activo AND NOT EXISTS(SELECT 1 FROM biblioteca.prestamo p WHERE p.ejemplar_id=e.id AND p.devuelto_en IS NULL) ORDER BY e.id;
-- P2: préstamos por socio incluyendo personas sin historial (Ana 2, Luis 1, Sara 0).
SELECT s.id,s.nombre,COUNT(p.id) AS prestamos FROM biblioteca.socio s LEFT JOIN biblioteca.prestamo p ON p.socio_id=s.id
GROUP BY s.id,s.nombre ORDER BY s.id;
-- P3: libros sin ejemplares (Redes).
SELECT l.id,l.titulo FROM biblioteca.libro l WHERE NOT EXISTS(SELECT 1 FROM biblioteca.ejemplar e WHERE e.libro_id=l.id) ORDER BY l.id;
-- P4: socios con más de un préstamo histórico (Ana).
SELECT socio_id,COUNT(*) FROM biblioteca.prestamo GROUP BY socio_id HAVING COUNT(*)>1 ORDER BY socio_id;
-- P5: atrasos a una fecha de corte explícita (préstamo 2, cinco días a esa hora).
SELECT id,socio_id,extract(epoch FROM (timestamptz '2026-01-25 10:00+00'-vence_en))/86400 AS dias_transcurridos
FROM biblioteca.prestamo WHERE devuelto_en IS NULL AND vence_en<timestamptz '2026-01-25 10:00+00' ORDER BY id;
-- P6: métricas por libro, primero una fila por ejemplar para no multiplicar conteos.
WITH por_ejemplar AS (
 SELECT e.id,e.libro_id,COUNT(p.id) AS prestamos FROM biblioteca.ejemplar e LEFT JOIN biblioteca.prestamo p ON p.ejemplar_id=e.id GROUP BY e.id
)
SELECT l.id,l.titulo,COUNT(e.id) AS ejemplares,COALESCE(SUM(e.prestamos),0) AS prestamos
FROM biblioteca.libro l LEFT JOIN por_ejemplar e ON e.libro_id=l.id GROUP BY l.id,l.titulo ORDER BY l.id;
