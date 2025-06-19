========================================
CONSULTAS SQL AVANZADAS
========================================

Esta sección contiene ejemplos reales de consultas SQL complejas realizadas sobre la base de datos `tienda_online`.
Se aplican operaciones de JOIN, funciones de agregación, filtros con WHERE, cláusulas GROUP BY y subconsultas.

1. Listar productos con sus categorías
--------------------------------------

Objetivo: Obtener todos los productos, su nombre, precio y la categoría a la que pertenecen.

.. code-block:: postgresql

    SELECT p.nombre, p.precio_unitario, c.nombre_categoria
    FROM producto p
    JOIN categoria c ON p.id_categoria = c.id_categoria;

Consulta: Listar productos con sus categorías
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Se utiliza una cláusula `JOIN` entre las tablas `producto` y `categoria` para obtener una lista detallada con sus respectivas categorías.

.. image:: img/consulta_productos_categorias.png
   :width: 800px
   :align: center
   :alt: Resultado de la consulta JOIN entre producto y categoría

Explicación:
~~~~~~~~~~~~
Se realiza un JOIN entre las tablas `producto` y `categoria`, utilizando la clave foránea `id_categoria` para traer el nombre de la categoría asociada.

2. Pedidos por cliente específico
----------------------------------

Objetivo: Mostrar todos los pedidos realizados por un cliente dado, identificándolo por su email.

.. code-block:: postgresql

    SELECT p.id_pedido, p.fecha_pedido
    FROM pedido p
    JOIN cliente c ON p.id_cliente = c.id_cliente
    WHERE c.email = 'cliente@example.com';

Consulta: Pedido por cliente
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. image:: img/consulta_pedidos_cliente.png
   :width: 800px
   :align: center
   :alt: Consulta de pedidos por cliente específico


Explicación:
~~~~~~~~~~~~
La relación entre `pedido` y `cliente` se establece mediante `id_cliente`. Al aplicar un filtro por email, se recuperan únicamente los pedidos asociados a ese cliente.

3. Pedidos con estado pendiente
-------------------------------

Objetivo: Mostrar todos los pedidos con estado "Pendiente", junto con el nombre del cliente que los realizó.

.. code-block:: postgresql

    SELECT
        p.id_pedido,
        cl.nombre,
        cl.apellido,
        ep.nombre_estado,
        p.fecha_pedido
    FROM
        pedido p
    JOIN
        cliente cl ON p.id_cliente = cl.id_cliente
    JOIN
        estadopedido ep ON p.id_estado = ep.id_estado
    WHERE
        ep.nombre_estado = 'Pendiente';

Consulta: Pedidos pendientes con información del cliente
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Esta consulta realiza tres `JOIN` para obtener una visión completa de los pedidos pendientes:
- Con la tabla `cliente` para traer nombre y apellido del cliente.
- Con la tabla `estadopedido` para comprobar si el estado es `"Pendiente"`.

.. image:: img/consulta_pedidos_pendientes.png
   :width: 800px
   :align: center
   :alt: Resultado de consulta de pedidos pendientes

4. Clientes con más de 3 pedidos en el último mes
--------------------------------------------------

Objetivo: Obtener los clientes que realizaron más de tres pedidos durante los últimos 30 días.

.. code-block:: postgresql

    SELECT c.id_cliente, c.nombre, c.apellido, COUNT(p.id_pedido) AS total_pedidos
    FROM cliente c
    JOIN pedido p ON c.id_cliente = p.id_cliente
    WHERE p.fecha_pedido >= CURRENT_DATE - INTERVAL '1 month'
    GROUP BY c.id_cliente, c.nombre, c.apellido
    HAVING COUNT(p.id_pedido) > 3;

Explicación:
~~~~~~~~~~~~
La consulta realiza un `JOIN` entre `cliente` y `pedido`, agrupa por cliente y cuenta los pedidos en el intervalo de tiempo definido. Se utiliza `HAVING` para filtrar solo aquellos con más de 3 pedidos.

.. image:: img/consulta_clientes_pedidos_mes.png
   :width: 800px
   :align: center
   :alt: Clientes con más de 3 pedidos


5. Productos no vendidos en el último año
------------------------------------------

Objetivo: Identificar los productos que no han sido vendidos en los últimos 12 meses.

.. code-block:: postgresql

    SELECT pr.id_producto, pr.nombre, pr.precio_unitario
    FROM producto pr
    WHERE pr.id_producto NOT IN (
        SELECT DISTINCT dp.id_producto
        FROM detallepedido dp
        JOIN pedido p ON dp.id_pedido = p.id_pedido
        WHERE p.fecha_pedido >= CURRENT_DATE - INTERVAL '1 year'
    );

Explicación:
~~~~~~~~~~~~
Se utiliza una subconsulta con `NOT IN` para excluir aquellos productos que aparecen en pedidos realizados en el último año. Esto permite detectar productos sin rotación reciente.

.. image:: img/consulta_productos_no_vendidos.png
   :width: 800px
   :align: center
   :alt: Resultado de la consulta de productos no vendidos


Notas finales
~~~~~~~~~~~~~

Todas estas consultas han sido validadas contra el conjunto de datos orgánico y sintético, y pueden adaptarse fácilmente a otros escenarios como informes, dashboards o procesos de análisis más complejos.
