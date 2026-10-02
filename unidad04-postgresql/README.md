# Unidad 04 — PostgreSQL y entorno

## Qué aprenderás
- distinguir PostgreSQL servidor, base, esquema y cliente;
- conectarte;
- ejecutar SQL;
- utilizar comandos básicos de psql;
- reconocer errores de conexión frente a errores SQL.

## Antes de empezar
Ya debes comprender modelo relacional y claves. Todavía no necesitas saber SQL.

# 1. ¿Qué es PostgreSQL?

PostgreSQL es un sistema gestor de bases de datos relacional y objeto-relacional de código abierto.

En este curso es nuestro **motor de referencia**.

```text
tu cliente
   │
   │ conexión
   ↓
PostgreSQL Server
   ├── base A
   └── base B
```

# 2. Servidor, base y esquema

**Servidor/instancia:** proceso que administra bases.

**Base de datos:** contenedor lógico al que te conectas.

**Esquema:** espacio de nombres dentro de una base; `public` suele existir inicialmente.

**Tabla:** objeto dentro de un esquema.

Ejemplo:
```text
servidor
└── curso_sql
    └── public
        ├── producto
        └── cliente
```

# 3. Cliente

Puedes utilizar:
- `psql`;
- pgAdmin;
- DBeaver;
- otro cliente compatible.

El curso mostrará SQL que funciona directamente en PostgreSQL; algunas prácticas de terminal utilizan psql.

# 4. Primera conexión con psql

Un comando típico:
```bash
psql -U usuario -d nombre_base
```

Host/puerto pueden ser necesarios según instalación.

Una vez dentro:
```sql
SELECT current_database();
```

Salida conceptual:
```text
 current_database
------------------
 curso_sql
```

# 5. SQL vs comandos de psql

Esto es SQL:
```sql
SELECT version();
```

Esto es un comando del cliente:
```text
\dt
```

No son lo mismo.

Comandos útiles:
```text
\l          listar bases
\c nombre   conectar
\dt         listar tablas
\d tabla    describir
\q          salir
```

# 6. Práctica guiada

## Paso 1
Conéctate a una base de práctica.

## Paso 2
Ejecuta:
```sql
SELECT version();
SELECT current_database();
SELECT current_user;
```

## Paso 3
Desde psql:
```text
\dt
```

Si aún no hay tablas, el resultado puede indicarlo. Eso no es un error.

# 7. Leer errores

### Connection refused
El servidor podría no estar disponible o host/puerto ser incorrecto.

### password authentication failed
La conexión llegó al servidor, pero las credenciales no fueron aceptadas.

### syntax error at or near...
Ya estás ejecutando SQL, pero la sentencia tiene un problema sintáctico.

Distinguir capas evita reinstalar PostgreSQL por un punto y coma mal escrito.

# 8. Seguridad

No publiques contraseñas reales en repositorios ni capturas.

Para las guías:
```text
usuario: TU_USUARIO
password: TU_CLAVE
```

# 9. Ejercicios

1. Obtén versión.
2. Obtén usuario actual.
3. Lista bases.
4. Conéctate a otra base de práctica.
5. Distingue tres errores de conexión/sintaxis.

# 10. Reto

Crea una base de práctica llamada según tu convención y documenta:
- cómo te conectas;
- qué cliente utilizas;
- versión de PostgreSQL;
- base actual;
- usuario actual.

No publiques contraseña.

# 11. Autoevaluación

1. ¿PostgreSQL es SQL?
2. ¿Qué diferencia hay entre servidor y base?
3. ¿Qué es un esquema?
4. ¿psql es el servidor?
5. ¿Qué diferencia existe entre `\dt` y `SELECT`?
6. ¿Por qué es importante distinguir error de conexión y error SQL?

# 12. Checklist
- [ ] Puedo explicar PostgreSQL/psql.
- [ ] Puedo conectarme.
- [ ] Puedo ejecutar SELECT.
- [ ] Puedo listar tablas.
- [ ] Sé leer la categoría básica de un error.

Ahora estás listo para escribir tu primera tabla en **Unidad 05**.
