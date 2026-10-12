# Unidad 27: Usuarios, roles y privilegios

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Comprender autenticación/autorización a nivel de base, crear roles y aplicar mínimo privilegio.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

# 1. El problema

Una aplicación web necesita consultar y modificar ciertas tablas.

¿Debería conectarse como superusuario?

No.

Si esa credencial se compromete, un atacante tendría privilegios innecesarios.

# 2. Rol

PostgreSQL utiliza roles para representar identidades y grupos de privilegios.

Un rol puede tener LOGIN o utilizarse como agrupador de permisos.

# 3. Crear rol de práctica

```sql
CREATE ROLE lector LOGIN PASSWORD 'CAMBIAR_EN_PRACTICA';
```

Ese texto es un placeholder. **Nunca publiques una contraseña real.**

# 4. GRANT

```sql
GRANT CONNECT ON DATABASE curso_sql TO lector;
GRANT USAGE ON SCHEMA public TO lector;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO lector;
```

Observa que conectarse a la base, utilizar un esquema y consultar tablas son permisos diferentes.

# 5. REVOKE

```sql
REVOKE SELECT ON producto FROM lector;
```

Retira un privilegio concedido según el modelo de permisos aplicable.

# 6. Mínimo privilegio

Pregunta:
> ¿qué operaciones necesita realmente esta identidad?

Un usuario de reportes puede necesitar SELECT, pero no DROP TABLE.

Una aplicación CRUD puede necesitar SELECT/INSERT/UPDATE y quizá DELETE según diseño, pero no necesariamente CREATE DATABASE.

# 7. Roles de grupo

Puedes diseñar:

```text
rol_lectura
rol_aplicacion
rol_administracion
```

y asignar membresía a identidades concretas.

Esto puede simplificar administración.

# 8. Objetos futuros

Otorgar permisos sobre tablas existentes no implica necesariamente que futuras tablas reciban los mismos privilegios.

PostgreSQL ofrece `ALTER DEFAULT PRIVILEGES` para políticas futuras en un contexto/propietario determinado.

# 9. Seguridad de credenciales

No guardes contraseñas reales:
- en Git;
- en README;
- dentro de scripts públicos;
- en capturas.

Una contraseña publicada debe considerarse comprometida y rotarse.

# 10. Práctica guiada

Crea un rol lector en una base de práctica.

Comprueba:
1. puede conectarse;
2. puede SELECT;
3. no puede INSERT;
4. no puede DROP.

No hagas esta práctica en una base importante.

# 11. Errores frecuentes
- Aplicación como superusuario.
- Compartir una misma cuenta humana entre todos.
- Conceder ALL por comodidad.
- Creer que ocultar la contraseña en código frontend la vuelve secreta.
- Olvidar objetos futuros.

# 12. Ejercicios
Diseña permisos para:
- analista;
- aplicación;
- operador de carga;
- administrador.

# 13. Reto
Construye una matriz:

| rol | SELECT | INSERT | UPDATE | DELETE | DDL |
|---|---|---|---|---|---|

Justifica cada celda.

# 14. Autoevaluación
1. ¿Qué es un rol?
2. ¿Qué hace GRANT?
3. ¿Qué es mínimo privilegio?
4. ¿Por qué una app no debe usar superusuario?
5. ¿Qué problema resuelven default privileges?
6. ¿Qué haces si una contraseña real llegó a Git?

# 15. Checklist
- [ ] Creo roles.
- [ ] Concedo/retiro permisos.
- [ ] Aplico mínimo privilegio.
- [ ] No versiono secretos.

Continúa con importación/exportación.


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿USAGE sobre un esquema implica permiso para modificar sus tablas?

Ejecuta con un administrador en la base de práctica. NOLOGIN sirve para agrupar privilegios; LOGIN habilita una identidad para conectarse. USAGE permite resolver objetos del esquema, SELECT permite leer la tabla y CONNECT permite conexión a la base. Un propietario puede alterar o borrar sus objetos; no verifiques mínimo privilegio con el mismo dueño. Los permisos son acumulativos por membresías y PUBLIC.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad27-seguridad/LABORATORIO.sql
```

Para esta unidad usa una identidad administrativa con CREATEROLE en lugar de estudiante. El rol de demostración es NOLOGIN y se revierte al terminar.

5. Compara con la referencia: **El lector consulta cuatro categorías y recibe 42501 al insertar. Rol y concesiones desaparecen con rollback.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Diseña permisos para un analista que lee tablas actuales y futuras de tienda, sin poder crear objetos. Especifica el propietario para default privileges.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 26: EXPLAIN y planes de ejecución](../unidad26-explain/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 28: Importación y exportación](../unidad28-import-export/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Unidad%2027%20%E2%80%94%20Usuarios%2C%20roles%20y%20privilegios%20del%20curso%20Bases%20de%20Datos%20y%20SQL%20desde%20cero%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2FCurso-Bases-de-Datos-SQL%2Ftree%2Fmain%2Funidad27-seguridad%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
