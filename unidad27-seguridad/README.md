# Unidad 27 — Usuarios, roles y privilegios

## Qué aprenderás
Comprender autenticación/autorización a nivel de base, crear roles y aplicar mínimo privilegio.

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
