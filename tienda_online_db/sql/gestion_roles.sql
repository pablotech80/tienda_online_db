-- Creación de Roles --

-- Creo el rol administrador con contraseña
CREATE ROLE admin_tienda LOGIN PASSWORD 'admin123';

-- Creo el rol cliente con contraseña
CREATE ROLE cliente LOGIN PASSWORD 'cliente123';

-- Ahora paso a generar los permisos para cada rol

-- ADMINISTRADOR--
-- Da acceso completo a todas las tablas
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_tienda;

-- Da acceso a secuencias
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_tienda;

-- CLIENTE--
-- Solo puede ver productos
GRANT SELECT ON producto TO cliente;

-- Solo puede hacer pedidos
GRANT INSERT ON pedido, detallepedido TO cliente;

-- Creación de un cliente de prueba para probar el rol de cliente
CREATE USER cliente_demo WITH PASSWORD 'demo123';
GRANT cliente TO cliente_demo;


