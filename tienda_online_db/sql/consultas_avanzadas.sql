-- En este script haremos las funciones y procedimientos almacenados en PL/pgSQL --

-- REGISTRAR UN NUEVO PEDIDO --
CREATE OR REPLACE FUNCTION registrar_pedido(
    p_id_cliente INT,
    p_id_estado INT,
    p_productos INT[],      -- array de id_producto
    p_cantidades INT[],     -- array de cantidades
    p_precios NUMERIC[]     -- array de precios_unitario
) RETURNS VOID AS $$
DECLARE
    v_id_pedido INT;
    i INT;
BEGIN
    -- Inserción del pedido principal --
    INSERT INTO pedido(id_cliente, fecha_pedido, id_estado)
    VALUES (p_id_cliente, CURRENT_DATE, p_id_estado)
    RETURNING id_pedido INTO v_id_pedido;

    -- 2. Inserto los detalles (asumiendo arrays del mismo tamaño)
    FOR i IN 1..array_length(p_productos, 1) LOOP
        INSERT INTO detallepedido(id_pedido, id_producto, cantidad, precio_unitario)
        VALUES (v_id_pedido, p_productos[i], p_cantidades[i], p_precios[i]);

        -- 3. Actualizo el stock del producto
        UPDATE producto
        SET stock = stock - p_cantidades[i]
        WHERE id_producto = p_productos[i];
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- CALCULAR EL TOTAL DE PEDIDOS POR CLIENTE --

CREATE OR REPLACE FUNCTION total_por_cliente(p_id_cliente INT)
RETURNS NUMERIC AS $$
DECLARE
    v_total NUMERIC;
BEGIN
    SELECT SUM(dp.cantidad * dp.precio_unitario)
    INTO v_total
    FROM pedido p
    JOIN detallepedido dp ON p.id_pedido = dp.id_pedido
    WHERE p.id_cliente = p_id_cliente;

    RETURN COALESCE(v_total, 0);
END;
$$ LANGUAGE plpgsql;

-- ACTUALIZACIÓN DEL ESTADO DE UN PEDIDO --

CREATE OR REPLACE FUNCTION actualizar_estado_pedido(
    p_id_pedido INT,
    p_nuevo_estado INT
) RETURNS VOID AS $$
BEGIN
    UPDATE pedido
    SET id_estado = p_nuevo_estado
    WHERE id_pedido = p_id_pedido;
END;
$$ LANGUAGE plpgsql;
