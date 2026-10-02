-- Ejecutar con una cuenta con privilegios suficientes en una base de práctica.
CREATE ROLE lector LOGIN PASSWORD 'CAMBIAR_EN_PRACTICA';
GRANT CONNECT ON DATABASE current_database() TO lector;
GRANT USAGE ON SCHEMA public TO lector;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO lector;

-- En un entorno real, no versionar contraseñas reales.
