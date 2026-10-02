# Práctica — Pensar en relaciones

Representa estudiantes, cursos y matrículas.

## Relaciones
```text
ESTUDIANTE(id, nombre)
CURSO(id, nombre)
MATRICULA(estudiante_id, curso_id, fecha)
```

MATRICULA resuelve una relación N:M.

## Preguntas
- ¿qué identifica cada tupla?
- ¿qué atributos dependen de cada clave?
- ¿qué duplicados son legítimos y cuáles no?

## Reto
Explica por qué guardar "curso1, curso2, curso3" dentro de ESTUDIANTE dificulta el modelo.
