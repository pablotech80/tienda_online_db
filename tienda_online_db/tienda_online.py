import psycopg2

# Función que conecta la base de datos
def conectar():
    return psycopg2.connect(
        dbname="tienda_online",
        user="admin_tienda",
        password="admin123",
        host="localhost",
        port="5432",
    )


# agregando un nuevo producto
def agregar_producto(nombre, descripcion, precio_unitario, stock, id_categoria, id_proveedor):
    with conectar() as conn:
        with conn.cursor() as cur:
            cur.execute("""
                INSERT INTO producto(nombre, descripcion, precio_unitario, stock, id_categoria, id_proveedor)
                VALUES (%s, %s, %s, %s, %s, %s)
                RETURNING id_producto
            """, (nombre, descripcion, precio_unitario, stock, id_categoria, id_proveedor))
            id_producto = cur.fetchone()[0]
            conn.commit()
            print(f"Producto agregado exitosamente con ID: {id_producto}")
            return id_producto


# 2. Registrar un nuevo cliente
def registrar_cliente(nombre, apellido, email):
    with conectar() as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                INSERT INTO cliente (nombre, apellido, email)
                VALUES (%s, %s, %s)
            """,
                (nombre, apellido, email),
            )
            conn.commit()
            print("Cliente registrado correctamente.")


# 3. Realizar un pedido (solo un producto por pedido)
def realizar_pedido(id_cliente, id_producto, cantidad, id_estado=1):
    with conectar() as conn:
        with conn.cursor() as cur:
            cur.execute(
                "SELECT precio_unitario FROM producto WHERE id_producto = %s",
                (id_producto,),
            )
            resultado = cur.fetchone()
            if not resultado:
                print("Producto no encontrado.")
                return
            precio_unitario = resultado[0]
            total = precio_unitario * cantidad

            # Insertar pedido
            cur.execute(
                """
                INSERT INTO pedido (id_cliente, fecha_pedido, id_estado)
                VALUES (%s, CURRENT_DATE, %s) RETURNING id_pedido
            """,
                (id_cliente, id_estado),
            )
            id_pedido = cur.fetchone()[0]

            # Insertar detalle del pedido
            cur.execute(
                """
                INSERT INTO detallepedido (id_pedido, id_producto, cantidad, precio_unitario)
                VALUES (%s, %s, %s, %s)
            """,
                (id_pedido, id_producto, cantidad, precio_unitario),
            )
            conn.commit()
            print(f" Pedido #{id_pedido} realizado. Total: {total:.2f}€.")


# 4. Consultar stock de un producto
def consultar_stock(id_producto):
    with conectar() as conn:
        with conn.cursor() as cur:
            cur.execute(
                "SELECT nombre, stock FROM producto WHERE id_producto = %s",
                (id_producto,),
            )
            resultado = cur.fetchone()
            if resultado:
                print(f" Producto: {resultado[0]} | Stock disponible: {resultado[1]}")
            else:
                print(" Producto no encontrado.")


# Script de prueba interactivo (opcional para la entrega)
if __name__ == "__main__":
    print("Módulo de pruebas")
    registrar_cliente("Piero", "Velazquez", "piero@example.com")
    id_producto = agregar_producto("Teclado Mecánico", "Switch rojo, retroiluminado", 49.99, 30, 1, 1)
    consultar_stock(id_producto)
    realizar_pedido(1, id_producto, 2)

# PRUEBA DE LOS SCRIPTS DE PYTHON - RESULTADO EN CONSOLA