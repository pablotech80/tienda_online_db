Introducción
============

Este proyecto ha sido desarrollado como parte del **Curso de Gestión de Bases de Datos (GBD)** impartido por **Tokio School** bajo la dirección del profesor **David Morán**.

El objetivo principal es diseñar e implementar un sistema completo de base de datos relacional para una tienda online. A lo largo del proyecto, se aplican los fundamentos teóricos y prácticos adquiridos en el curso, cubriendo desde el modelado inicial hasta su implementación y automatización en PostgreSQL.

Objetivos del proyecto
----------------------

- Diseñar un modelo entidad-relación (E/R) realista.
- Normalizar el modelo hasta alcanzar la tercera forma normal (3FN).
- Traducir el modelo lógico al modelo físico en SQL.
- Crear un esquema robusto con claves primarias y foráneas.
- Insertar datos orgánicos y sintéticos mediante Mockaroo.
- Ejecutar consultas SQL de complejidad progresiva.
- Automatizar operaciones con triggers.
- Implementar funciones y procedimientos almacenados en PL/pgSQL.
- Controlar el acceso con roles y privilegios adecuados.
- Conectar la base de datos con una aplicación en Python para realizar operaciones CRUD.
- Documentar todo el proceso con claridad para evaluación académica y reutilización profesional.

Tecnologías utilizadas
----------------------

- PostgreSQL 15+
- Python 3.10+
- Psycopg2 para conexión Python–PostgreSQL
- Sphinx para documentación técnica
- DBeaver (opcional) para administración visual de la base de datos
- Mockaroo para generación de datos sintéticos

Estructura general de la documentación
--------------------------------------

Esta documentación está organizada en módulos, reflejando cada una de las fases del desarrollo:

1. Creación del esquema y base de datos
2. Inserción de datos orgánicos y sintéticos
3. Consultas avanzadas
4. Automatización con triggers
5. Seguridad y gestión de usuarios
6. Funciones PL/pgSQL
7. Integración con Python
8. Conclusiones y aprendizajes

