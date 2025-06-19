
========================================
AUTOMATIZACIÓN CON TRIGGERS
========================================

En esta sección se documenta el uso de **triggers** para automatizar el comportamiento de la base de datos en el proyecto `tienda_online`.

Se implementaron dos mecanismos principales:

1. Actualización automática del stock cuando se registra un pedido.
2. Alerta cuando el stock cae por debajo de un umbral definido.

1. Trigger: Actualizar stock al registrar un pedido
----------------------------------------------------

Objetivo: Restar automáticamente del stock cada vez que se inserta una línea en `detallepedido`.

Código:

.. code-block:: postgresql

    CREATE OR REPLACE FUNCTION actualizar_stock()
    RETURNS TRIGGER AS $$
    BEGIN
        UPDATE producto
        SET stock = stock - NEW.cantidad
        WHERE id_producto = NEW.id_producto;
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER trg_actualizar_stock
    AFTER INSERT ON detallepedido
    FOR EACH ROW
    EXECUTE FUNCTION actualizar_stock();

Actualización automática del stock al registrar un pedido
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Esta imagen muestra cómo el trigger `actualizar_stock` reduce automáticamente el stock del producto cuando se inserta una línea de pedido en `detallepedido`.

.. image:: img/trigger_actualiza_stock_correcto.png
   :width: 800px
   :align: center
   :alt: Disminución del stock al realizar un pedido


Explicación:
~~~~~~~~~~~~
Cada vez que se inserta una fila en `detallepedido`, se activa el trigger que actualiza el campo `stock` del producto correspondiente, restando la cantidad pedida.

2. Trigger: Alerta por stock bajo
----------------------------------

Objetivo: Emitir un aviso cuando el stock resultante de un producto cae por debajo de un umbral (por ejemplo, 5 unidades).

Código:

.. code-block:: postgresql

    CREATE OR REPLACE FUNCTION alerta_stock_bajo()
    RETURNS TRIGGER AS $$
    DECLARE
        stock_actual INTEGER;
    BEGIN
        SELECT stock INTO stock_actual
        FROM producto
        WHERE id_producto = NEW.id_producto;

        IF stock_actual < 5 THEN
            RAISE NOTICE 'Atención: el stock del producto % ha bajado a % unidades.', NEW.id_producto, stock_actual;
        END IF;

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER trg_alerta_stock_bajo
    AFTER INSERT ON detallepedido
    FOR EACH ROW
    EXECUTE FUNCTION alerta_stock_bajo();

Resultado del trigger `alerta_stock_bajo`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La tabla `alerta_stock` almacena automáticamente registros cuando el stock de un producto baja del umbral crítico.

.. image:: img/resultado_trigger_alerta_stock_bajo.png
   :width: 800px
   :align: center
   :alt: Registros generados automáticamente por el trigger alerta_stock_bajo


Explicación:
~~~~~~~~~~~~
Después de cada inserción en `detallepedido`, se verifica el stock del producto y, si es inferior al umbral, se lanza un aviso en consola. Este sistema puede evolucionar para registrar alertas en una tabla o enviar notificaciones externas.

Consideraciones técnicas
------------------------

- Ambos triggers se ejecutan tras la inserción (`AFTER INSERT`), asegurando que el pedido ha sido registrado.
- La lógica está separada en funciones reutilizables escritas en PL/pgSQL.
- Es posible complementar estos mecanismos con auditoría, logs o alertas externas en sistemas de producción.

Estos triggers contribuyen a mantener la integridad operativa del inventario en tiempo real.
