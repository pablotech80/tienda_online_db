
# Tienda Online – Proyecto de Gestión de Base de Datos

Este proyecto forma parte del Curso de Gestión de Bases de Datos de Tokio School, impartido por el profesor David Morán. Su objetivo es diseñar, implementar y documentar un sistema de gestión completo para una tienda online, utilizando PostgreSQL y Python.

## Descripción General

Este proyecto abarca:

- Modelado entidad-relación (E/R)
- Normalización hasta 3FN
- Creación del esquema relacional
- Inserción de datos orgánicos y sintéticos
- Consultas SQL avanzadas
- Automatización con Triggers
- Seguridad con roles y privilegios
- Programación con funciones PL/pgSQL
- Integración con Python (psycopg2)
- Documentación técnica completa

## Requisitos

- PostgreSQL 15 o superior
- Python 3.10+
- Biblioteca psycopg2
- DBeaver (opcional para visualización)

## Estructura del Proyecto

```
tienda_online/
│
├── sql/
│   ├── crear_base.sql
│   ├── insertar_datos.sql
│   ├── consultas_avanzadas.sql
│   ├── triggers.sql
│   ├── funciones.sql
│   └── roles.sql
│
├── tienda_online_db/
│   ├── tienda_online.py
│   └── config.py
│
├── docs/
│   ├── diagrama_er.png
│   ├── capturas/
│   └── documentación.rst
│
└── README.md
```

## Fases del Proyecto

1. **Modelado E/R y normalización**
2. **Creación de tablas SQL**
3. **Carga de datos sintéticos con Mockaroo**
4. **Consultas SQL (JOIN, agregaciones, subconsultas)**
5. **Triggers para actualización automática de stock**
6. **Seguridad (roles: `admin_tienda`, `cliente`)**
7. **Funciones PL/pgSQL: registrar pedido, total por cliente, actualizar estado**
8. **Integración con Python: CRUD y consultas vía psycopg2**
9. **Documentación para entrega y uso académico/profesional**

## Instalación

1. Clona el repositorio:

```bash
git clone https://github.com/usuario/tienda_online.git
cd tienda_online
```

2. Ejecuta el script de creación de base:

```bash
psql -U postgres -f sql/crear_base.sql
```

3. Inserta los datos:

```bash
psql -U postgres -d tienda_online -f sql/insertar_datos.sql
```

4. Ejecuta el script Python (ajustar `config.py` si es necesario):

```bash
python tienda_online_db/tienda_online.py
```

## Ejemplos de Consultas Avanzadas

- Productos sin vender en el último año
- Clientes con mayor número de pedidos
- Pedidos pendientes por cliente y fecha
- Stock por debajo del umbral definido (con trigger)

## Créditos

Desarrollado por Pablo Techera como parte del curso de Tokio School.

Profesor: David Morán  
Tecnologías: PostgreSQL, Python, SQL, PL/pgSQL  
Año: 2025
