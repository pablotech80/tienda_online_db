-- INSERCIÓN DE DATOS PARA LA BASE tienda_online --
-- ================================================
-- Este script carga los datos de prueba en la base de datos tienda_online.
-- Incluye dos tipos de datos:
--
-- 1. Datos SINTÉTICOS: generados automáticamente con la herramienta Mockaroo.
--    Se utilizan para poblar las tablas con volumen y simular un entorno real.
--    Archivos involucrados: estadopedido.sql, categoria.sql, proveedor.sql, cliente.sql,
--    producto.sql, pedido.sql, detallepedido.sql.
--
-- 2. Datos ORGÁNICOS: insertados manualmente para pruebas controladas.
--    Son datos representativos con nombres conocidos que se utilizarán en capturas de pantalla,
--    pruebas de consultas y documentación.
--    Se recomienda añadir estos datos manuales tras cargar los sintéticos, o mediante scripts separados.

-- Inserción ordenada respetando las claves foráneas --

-- Tabla: estadopedido
insert into estadopedido (id_estado, nombre_estado) values (1, 'Enviado');
insert into estadopedido (id_estado, nombre_estado) values (2, 'Entregado');
insert into estadopedido (id_estado, nombre_estado) values (3, 'Pendiente');

-- Tabla: categoria
insert into categoria (id_categoria, nombre_categoria) values (1, 'Electronica');
insert into categoria (id_categoria, nombre_categoria) values (2, 'Moda');
insert into categoria (id_categoria, nombre_categoria) values (3, 'Deportes');
insert into categoria (id_categoria, nombre_categoria) values (4, 'Libros');
insert into categoria (id_categoria, nombre_categoria) values (5, 'Hogar');

-- Tabla: proveedor
insert into proveedor (id_proveedor, nombre_empresa, telefono, email) values (1, 'Twinder', '(883) 1952649', 'bcurl0@soup.io');
insert into proveedor (id_proveedor, nombre_empresa, telefono, email) values (2, 'Skinder', '(218) 8387451', 'lwaterfall1@live.com');
insert into proveedor (id_proveedor, nombre_empresa, telefono, email) values (3, 'Browsebug', '(211) 6458455', 'jhedley2@myspace.com');
insert into proveedor (id_proveedor, nombre_empresa, telefono, email) values (4, 'Myworks', '(274) 7149991', 'zdenerley3@pbs.org');
insert into proveedor (id_proveedor, nombre_empresa, telefono, email) values (5, 'Realmix', '(920) 2212388', 'zhedau4@dailymail.co.uk');

-- Tabla: cliente
insert into cliente (id_cliente, nombre, apellido, email, fecha_registro) values (1, 'Lesli', 'Byforth', 'lbyforth0@last.fm', '2024-07-21 13:12:47');
insert into cliente (id_cliente, nombre, apellido, email, fecha_registro) values (2, 'Ignatius', 'Domenichelli', 'idomenichelli1@fema.gov', '2024-07-02 08:34:58');
insert into cliente (id_cliente, nombre, apellido, email, fecha_registro) values (3, 'Demetris', 'Cogzell', 'dcogzell2@who.int', '2024-08-17 11:39:17');

-- Tabla: producto
insert into producto (id_producto, nombre, descripcion, precio_unitario, stock, id_categoria, id_proveedor) values (1, 'Smartphone Car Mount with Wireless Charging', 'Phone Accessories', 39.99, 52, 5, 5);
insert into producto (id_producto, nombre, descripcion, precio_unitario, stock, id_categoria, id_proveedor) values (2, 'Breezy Off-The-Shoulder Top', 'Women''s Tops', 34.99, 75, 4, 1);
insert into producto (id_producto, nombre, descripcion, precio_unitario, stock, id_categoria, id_proveedor) values (3, 'Fruit and Nut Medley', 'Nuts and Trail Mix', 5.99, 92, 3, 5);

-- Tabla: pedido
insert into pedido (id_pedido, id_cliente, id_estado, fecha_pedido) values (1, 11, 1, '2024-04-17 13:41:46');
insert into pedido (id_pedido, id_cliente, id_estado, fecha_pedido) values (2, 36, 1, '2024-11-24 03:33:53');
insert into pedido (id_pedido, id_cliente, id_estado, fecha_pedido) values (3, 13, 2, '2024-12-23 15:07:28');

-- Tabla: detallepedido
insert into detallepedido (id_pedido, id_producto, cantidad, precio_unitario) values (23, 20, 2, 22.99);
insert into detallepedido (id_pedido, id_producto, cantidad, precio_unitario) values (24, 17, 3, 39.99);
insert into detallepedido (id_pedido, id_producto, cantidad, precio_unitario) values (12, 26, 5, 15.99);

-- Actualización de precios en detallepedido para reflejar el precio actual de cada producto
UPDATE detallepedido dp
SET precio_unitario = p.precio_unitario
FROM producto p
WHERE dp.id_producto = p.id_producto;

