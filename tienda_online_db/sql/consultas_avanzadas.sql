--CONSULTAS SQL AVANZADAS --

--CONSULTA QUE SELECCIONA TODOS LOS PRODUCTOS Y SUS CATEGORIAS--
SELECT *
FROM producto
JOIN categoria ON producto.id_categoria = categoria.id_categoria;

--CONSULTA QUE ENCUENTRA UN PEDIDO DE UN CLIENTE ESPECIFICO--

SELECT
    p.id_pedido,
    p.fecha_pedido,
    c.nombre,
    c.apellido,
    pr.nombre AS nombre_producto,
    pr.precio_unitario,
    dp.cantidad
FROM
    pedido p
JOIN
    cliente c ON p.id_cliente = c.id_cliente
JOIN
    detallepedido dp ON p.id_pedido = dp.id_pedido
JOIN
    producto pr ON dp.id_producto = pr.id_producto

WHERE
    c.email = 'ptecherasosa@icloud.com';

--CONSULTA QUE LISTA LOS CLIENTES CON MÁS DE 3 PEDIDOS EN EL ÚLTIMO MES--
SELECT
    c.id_cliente,
    c.nombre,
    c.apellido,
    COUNT(p.id_pedido) AS total_pedidos
FROM
    cliente c
JOIN
    pedido p ON c.id_cliente = p.id_cliente
WHERE
    p.fecha_pedido >= CURRENT_DATE - INTERVAL '1 month'
GROUP BY
    c.id_cliente, c.nombre, c.apellido;

--CONSULTA QUE ENCUENTRA LOS PRODUCTOS QUE NO HAN SIDO VENDIDOS EN EL ÚLTIMO AÑO--
SELECT
    pr.id_producto,
    pr.nombre,
    pr.precio_unitario
FROM
    producto pr
WHERE
    pr.id_producto NOT IN (
        SELECT DISTINCT dp.id_producto
        FROM detallepedido dp
        JOIN pedido p ON dp.id_pedido = p.id_pedido
        WHERE p.fecha_pedido >= current_date - Interval '1 year'
        );
