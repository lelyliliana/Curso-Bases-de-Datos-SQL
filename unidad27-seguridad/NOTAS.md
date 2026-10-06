# Privilegios actuales, futuros y membresía

Prueba permisos con una identidad distinta del propietario. Los privilegios de PUBLIC y de membresías se acumulan: REVOKE de una concesión no cancela otra que permite la misma operación.

## Tablas actuales

Ejemplo administrativo en una base de práctica (crea los roles una vez):

```sql
CREATE ROLE lector NOLOGIN;
GRANT CONNECT ON DATABASE curso_sql TO lector;
GRANT USAGE ON SCHEMA tienda TO lector;
GRANT SELECT ON ALL TABLES IN SCHEMA tienda TO lector;
```

CONNECT puede estar concedido por defecto a PUBLIC. Revocarlo de un rol concreto no impide una conexión que PUBLIC sigue permitiendo. USAGE no concede SELECT ni CREATE. La membresía se asigna a identidades LOGIN individuales según la política del sistema; evita compartir una sola cuenta humana.

## Objetos futuros y propietario

Si estudiante creará las tablas futuras:

```sql
ALTER DEFAULT PRIVILEGES FOR ROLE estudiante IN SCHEMA tienda
GRANT SELECT ON TABLES TO lector;
```

La política aplica a objetos creados después por **ese propietario**, no a tablas existentes ni a todos los roles. Revisa quién crea los objetos, aunque tenga membresía en otros roles. Para secuencias y funciones se diseñan permisos específicos, no un GRANT ALL indiscriminado.

Las funciones suelen conceder EXECUTE a PUBLIC por defecto. Para funciones sensibles, revócalo en la misma transacción de creación. La biblioteca demuestra SECURITY DEFINER, search_path fijo y referencias cualificadas; estudia sus límites antes de copiar esa técnica.

## Matriz para razonar

| Rol | Lectura | Escritura | DDL |
|---|---|---|---|
| lector | tablas/vistas acordadas | no | no |
| operador | datos necesarios | funciones controladas o DML limitado según requisito | no |
| propietario | administración de sus objetos | sí | sí |

Verifica SELECT permitido, INSERT/DELETE denegados y EXECUTE según operación; no confíes solo en una tabla de permisos escrita.

[Unidad](README.md) · [Proyecto biblioteca](../proyecto-biblioteca/README.md)
