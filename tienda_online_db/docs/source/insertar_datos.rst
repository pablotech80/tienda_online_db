
=========================================================
CARGA DE DATOS SINTÉTICOS Y ORGÁNICOS (Mockaroo + Manual)
=========================================================

Objetivo de esta fase:
--------------------------
Insertar datos en todas las tablas del modelo `tienda_online`, usando dos enfoques:

1. **Carga Sintética** con Mockaroo (datos generados artificialmente)
2. **Carga Orgánica** manual para pruebas controladas

---------------------------------------
1. CARGA DE DATOS SINTÉTICOS CON MOCKAROO
---------------------------------------

 Herramienta usada: https://www.mockaroo.com/

Tablas generadas:

- estadopedido.sql → 3 estados
- categoria.sql → 5 categorías
- proveedor.sql → 5 proveedores
- cliente.sql → 50 clientes
- producto.sql → 50 productos
- pedido.sql → 150 pedidos
- detallepedido.sql → 200 líneas de detalle

Consideraciones importantes:

- Se respetaron las claves foráneas (`FK`) ajustando rangos válidos en Mockaroo.
- Se usó formato SQL (PostgreSQL) para exportar todos los archivos.
- Se insertaron en el siguiente orden:

  1. estadopedido
  2. categoria
  3. proveedor
  4. cliente
  5. producto
  6. pedido
  7. detallepedido

Sincronización de precios:

Después de insertar, se actualizó `detallepedido.precio_unitario` con:

.. code-block:: sql

    UPDATE detallepedido dp
    SET precio_unitario = p.precio_unitario
    FROM producto p
    WHERE dp.id_producto = p.id_producto;

Esto garantiza coherencia entre productos y pedidos.

---------------------------------------
2. CARGA DE DATOS ORGÁNICOS (MANUAL)
---------------------------------------

Objetivo: tener registros que sirvan como referencia en capturas de pantalla y pruebas controladas.

Ejemplo insertado:

.. code-block:: sql

    INSERT INTO cliente (id_cliente, nombre, apellido, email, fecha_registro)
    VALUES (1001, 'Pablo', 'Techera', 'ptechera@ejemplo.com', CURRENT_DATE);

    INSERT INTO producto (id_producto, nombre, descripcion, precio_unitario, stock, id_categoria, id_proveedor)
    VALUES (1001, 'Laptop HP ProBook', 'Portátil para oficina con 16 GB RAM', 799.99, 15, 1, 2);

    INSERT INTO pedido (id_pedido, id_cliente, id_estado, fecha_pedido)
    VALUES (1001, 1001, 1, CURRENT_DATE);

    INSERT INTO detallepedido (id_pedido, id_producto, cantidad, precio_unitario)
    VALUES (1001, 1001, 1, 799.99
