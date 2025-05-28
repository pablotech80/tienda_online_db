-- ============================================
-- CREACIÓN DE BASE DE DATOS Y TABLAS  tienda_online
-- ============================================

CREATE DATABASE tienda_online;  -- Inicializo la creación de la base de datos.

-- CREACIÓN DE LAS TABLAS Y SUS ATRIBUTOS --


-- ESTADO PEDIDO --
CREATE TABLE estadopedido (
    id_estado     SERIAL PRIMARY KEY,
    nombre_estado VARCHAR(50) NOT NULL UNIQUE
);

-- CLIENTE --
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    fecha_registro DATE DEFAULT CURRENT_DATE
);

-- CATEGORIA --
CREATE TABLE categoria (
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL UNIQUE
);

-- PROVEEDOR --
CREATE TABLE proveedor (
    id_proveedor SERIAL PRIMARY KEY,
    nombre_empresa VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100) NOT NULL
);

-- PRODUCTO --
CREATE  TABLE producto
(
    id_producto     SERIAL PRIMARY KEY,
    nombre          VARCHAR(100)   NOT NULL,
    descripcion     TEXT,
    precio_unitario NUMERIC(10, 2) NOT NULL CHECK (precio_unitario >= 0),
    stock           INTEGER        NOT NULL DEFAULT 0,
    id_categoria    INTEGER REFERENCES categoria (id_categoria),
    id_proveedor    INTEGER REFERENCES proveedor (id_proveedor)
);

-- PEDIDO --
CREATE TABLE pedido (
    id_pedido  SERIAL PRIMARY KEY,
    id_cliente INTEGER REFERENCES cliente(id_cliente),
    id_estado INTEGER REFERENCES estadopedido(id_estado),
    fecha_pedido DATE NOT NULL DEFAULT CURRENT_DATE
);
-- DETALLE PEDIDO--
CREATE TABLE detallepedido (
    id_pedido INTEGER REFERENCES pedido(id_pedido) ON DELETE CASCADE,
    id_producto INTEGER REFERENCES producto(id_producto),
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC (10,2) NOT NULL CHECK ( precio_unitario >= 0),
    PRIMARY KEY (id_pedido, id_producto)
);
