# Unidad 04: PostgreSQL y entorno

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
- distinguir PostgreSQL servidor, base, esquema y cliente;
- conectarte;
- ejecutar SQL;
- utilizar comandos básicos de psql;
- reconocer errores de conexión frente a errores SQL.

## Antes de empezar
Ya debes comprender modelo relacional y claves. Todavía no necesitas saber SQL.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿A qué servidor, base, usuario y esquema está conectada esta ventana?

El servidor ejecuta SQL, psql lo envía y muestra la respuesta. Cambiar de carpeta no cambia de base. El esquema organiza objetos dentro de una base. No confundas la versión del cliente con la del servidor.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad04-postgresql/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **La base es la elegida en la conexión. Aparecen categoria, cliente, detalle_pedido, pedido y producto (cinco tablas).**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Lista las columnas y tipos de tienda.producto en su orden de definición.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 03: Claves y restricciones](../unidad03-claves/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 05: CREATE TABLE y tipos de datos](../unidad05-create-table/README.md)

