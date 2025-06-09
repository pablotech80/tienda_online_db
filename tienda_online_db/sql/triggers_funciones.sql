--CREACIÓN DE TRIGGERS Y FUNCIONES PARA CUANDO SE REDUCE EL STOCK--


-- FUNCIÓN que descuenta stock al insertar un detallepedido

CREATE OR REPLACE FUNCTION descontar_stock()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE producto
  SET stock = stock - NEW.cantidad
  WHERE id_producto = NEW.id_producto;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_descontar_stock
AFTER INSERT ON detallepedido
FOR EACH ROW
EXECUTE FUNCTION descontar_stock();

--FUNCIÓN que alerta si el stock baja por menos de 5 unidades.
-- Primero voy a crear una nueva tabla llamada alerta_stock para registrar la alertas en vez de recibir RAISE NOTICE

CREATE TABLE alerta_stock (
  id_alerta SERIAL PRIMARY KEY,
  id_producto INTEGER REFERENCES producto(id_producto),
  mensaje TEXT,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Trigger--
CREATE OR REPLACE FUNCTION alerta_stock()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.stock < 5 THEN
    INSERT INTO alerta_stock (id_producto, mensaje)
    VALUES (NEW.id_producto, 'Stock bajo: solo quedan ' || NEW.stock || ' unidades');
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_alerta_stock ON producto;

CREATE TRIGGER trg_alerta_stock
AFTER UPDATE ON producto
FOR EACH ROW
WHEN (NEW.stock < OLD.stock)
EXECUTE FUNCTION alerta_stock();
