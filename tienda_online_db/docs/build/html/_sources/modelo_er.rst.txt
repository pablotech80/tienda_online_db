Modelo Entidad-Relación de la Base de Datos
===========================================

Introducción
------------

Este modelo E/R representa el sistema de gestión de una tienda online. El diseño está orientado a capturar
las principales operaciones del negocio: gestión de productos, clientes, pedidos y proveedores.

Se utilizaron principios de normalización y buenas prácticas de modelado para asegurar integridad,
consistencia y escalabilidad del sistema.

.. image:: img/modelo_er.png
   :alt: Diagrama Entidad-Relación
   :align: center
   :width: 90%


Puedes descargar el archivo original `.drawio` desde el siguiente enlace:

🔗 `Abrir en Google Drive <https://drive.google.com/file/d/1dxkbbJW5Jy9t8baSyVqCOag7OqGZSifv/view?usp=share_link>`_

---

Entidades y atributos
---------------------

**CLIENTE**

- `id_cliente`: Identificador único (PK)
- `nombre`: Nombre del cliente
- `apellido`: Apellido del cliente
- `email`: Correo electrónico
- `fecha_registro`: Fecha de alta en la plataforma

**PEDIDO**

- `id_pedido`: Identificador del pedido (PK)
- `id_cliente`: FK que enlaza con CLIENTE
- `id_estado`: FK que enlaza con ESTADOPEDIDO
- `fecha_pedido`: Fecha del pedido

**ESTADOPEDIDO**

- `id_estado`: Identificador del estado (PK)
- `nombre_estado`: Descripción textual del estado (Pendiente, Enviado, etc.)

**PRODUCTO**

- `id_producto`: Identificador del producto (PK)
- `nombre`: Nombre del producto
- `descripcion`: Descripción del producto
- `precio_unitario`: Precio por unidad
- `stock`: Unidades disponibles
- `id_categoria`: FK hacia CATEGORIA
- `id_proveedor`: FK hacia PROVEEDOR

**DETALLEPEDIDO**

- `id_pedido`: Parte de la clave compuesta (FK)
- `id_producto`: Parte de la clave compuesta (FK)
- `cantidad`: Unidades compradas
- `precio_unitario`: Precio al momento del pedido

**CATEGORIA**

- `id_categoria`: Identificador (PK)
- `nombre_categoria`: Nombre de la categoría

**PROVEEDOR**

- `id_proveedor`: Identificador (PK)
- `nombre_empresa`: Nombre comercial
- `email`: Correo de contacto
- `telefono`: Teléfono

---

Relaciones y cardinalidades
----------------------------

- **CLIENTE 1:N PEDIDO**: un cliente puede hacer muchos pedidos.
- **PEDIDO 1:N DETALLEPEDIDO**: un pedido puede tener muchos productos.
- **PRODUCTO 1:N DETALLEPEDIDO**: un producto puede estar en muchos pedidos.
- **PRODUCTO N:1 CATEGORIA**: una categoría agrupa muchos productos.
- **PRODUCTO N:1 PROVEEDOR**: un proveedor puede suministrar muchos productos.
- **PEDIDO N:1 ESTADOPEDIDO**: muchos pedidos pueden compartir el mismo estado.

---

Normalización
-------------

El modelo fue normalizado hasta la **tercera forma normal (3FN)**:

**1FN**:
Todos los atributos son atómicos, sin repetición ni listas. Ejemplo: `stock` es un valor único por producto.

**2FN**:
En `detallepedido`, la clave es compuesta. Todos los atributos (`cantidad`, `precio_unitario`) dependen de la combinación completa (`id_pedido`, `id_producto`).

**3FN**:
No hay dependencias transitivas. Por ejemplo, el nombre del estado del pedido no está en la tabla `pedido`, sino referenciado por `id_estado`.

---

Conclusión
----------

Este modelo sirve como base sólida para un sistema de gestión ecommerce, adaptable y preparado para integraciones futuras con frontend, pasarelas de pago, o APIs REST. Toda la lógica del negocio está correctamente representada, manteniendo coherencia y escalabilidad desde la base de datos.

