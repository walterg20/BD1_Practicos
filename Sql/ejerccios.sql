CREATE DATABASE sql_ejercicios;
USE sql_ejercicios;

DROP TABLE PedidoLibreria;

-- Creación de tabla
CREATE TABLE PedidoLibreria (
    pedido_id       INT PRIMARY KEY,
    cliente         VARCHAR(100) NOT NULL,
    ciudad          VARCHAR(50) NOT NULL,
    libro           VARCHAR(100) NOT NULL,
    categoria       VARCHAR(50) NULL,
    cantidad        INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_pedido    DATE NOT NULL
);


-- Inserción de datos representativos
INSERT INTO PedidoLibreria VALUES
(1, 'Ana Torres',   'Corrientes', 'Bases de Datos I',    'Universitario', 2, 5500.00, '2025-03-01'),
(2, 'Luis Gómez',   'Resistencia','Algoritmos en C',     'Universitario', 1, 7200.00, '2025-03-02'),
(3, 'María López',  'Corrientes', 'Cien Años de Soledad','Novela',        3, 3500.00, '2025-03-03'),
(4, 'Ana Torres',   'Corrientes', 'El Principito',       'Infantil',      1, 2800.00, '2025-03-05'),
(5, 'Pedro Sánchez','Formosa',    'SQL Avanzado',        'Universitario', 2, 6100.00, '2025-03-06'),
(6, 'Laura Díaz',   'Corrientes', 'La Odisea',           'Clásico',       1, 4800.00, '2025-03-07'),
(7, 'Luis Gómez',   'Resistencia','El Principito',       'Infantil',      4, 2800.00, '2025-03-08'),
(8, 'María López',  'Corrientes', 'SQL Avanzado',        'Universitario', 1, 6100.00, '2025-03-09'),
(9, 'Carlos Ruiz',  'Formosa',    'Redes de Computadoras','Universitario',1, 8400.00, '2025-03-10'),
(10,'Pedro Sánchez','Formosa',    'Cálculo I',           'Universitario', 2, 6900.00, '2025-03-11'),
(11,'Pedro Ruiz','Formosa',    'Cálculo II',           NULL, 2, 6900.00, '2025-03-11');


-- Selección básica
SELECT cliente, libro, cantidad
FROM PedidoLibreria;

-- Selección con condición (WHERE)
SELECT cliente, libro, cantidad
FROM PedidoLibreria
WHERE ciudad = 'Corrientes';

-- Operadores aritméticos
SELECT cliente, libro, cantidad * precio_unitario AS total
FROM PedidoLibreria;

-- Eliminación de duplicados (DISTINCT)
SELECT DISTINCT ciudad
FROM PedidoLibreria;

-- Ordenamiento
SELECT cliente, libro, cantidad
FROM PedidoLibreria
ORDER BY cantidad DESC;

-- Agregados con GROUP BY
SELECT ciudad, COUNT(*) AS total_pedidos,
       SUM(cantidad*precio_unitario) AS monto_total
FROM PedidoLibreria
GROUP BY ciudad;


-- Agregados con HAVING
SELECT cliente, SUM(cantidad*precio_unitario) AS gasto_total
FROM PedidoLibreria
GROUP BY cliente
HAVING SUM(cantidad*precio_unitario) > 15000;


-- Funciones de fila
SELECT libro, LEN(libro) AS longitud
FROM PedidoLibreria;


-- Ejemplos en T-SQL (SQL Server)
-- TOP registros

SELECT TOP 5 *
FROM PedidoLibreria
ORDER BY fecha_pedido DESC;

SELECT TOP 1 WITH TIES *
FROM PedidoLibreria
ORDER BY fecha_pedido DESC

-- Uso de GETDATE()
SELECT cliente, DATEDIFF(DAY, fecha_pedido, GETDATE()) AS dias_transcurridos
FROM PedidoLibreria;

-- Expresión CASE
SELECT libro,
       CASE 
         WHEN precio_unitario < 3000 THEN 'Bajo'
         WHEN precio_unitario BETWEEN 3000 AND 6000 THEN 'Medio'
         ELSE 'Alto'
       END AS rango_precio
FROM PedidoLibreria;

-- Ejemplos ampliados
-- Subconsulta correlacionada
SELECT cliente, libro, cantidad
FROM PedidoLibreria p
WHERE cantidad > (
  SELECT AVG(cantidad)
  FROM PedidoLibreria
  WHERE ciudad = p.ciudad
);

-- Vista
CREATE VIEW vw_ventas_por_categoria AS
SELECT categoria, SUM(cantidad*precio_unitario) AS monto
FROM PedidoLibreria
GROUP BY categoria;

-- JOIN (auto-relación con alias)
SELECT p1.cliente, p1.libro, p2.libro
FROM PedidoLibreria p1
JOIN PedidoLibreria p2 ON p1.cliente = p2.cliente
WHERE p1.libro <> p2.libro;

-- -----------------------------------------------------------------
-- LIMITAR en FILAS en un SELECT 
-- -----------------------------------------------------------------

-- Obtener los primeros 5 pedidos
-- -----------------------------------

-- SQL Server – TOP
SELECT TOP (5) *
FROM PedidoLibreria;

SELECT TOP (5) *
FROM PedidoLibreria
ORDER BY fecha_pedido;

SELECT TOP (5) WITH TIES*
FROM PedidoLibreria
ORDER BY fecha_pedido;


-- SQL Server – OFFSET...FETCH
SELECT *
FROM PedidoLibreria
ORDER BY fecha_pedido
OFFSET 0 ROWS FETCH FIRST 5 ROWS ONLY;

SELECT *
FROM PedidoLibreria
ORDER BY fecha_pedido
OFFSET 0 ROWS
FETCH FIRST 3 ROWS WITH TIES; -- ver que pasa


/*
MySQL / PostgreSQL – LIMIT
SELECT *
FROM PedidoLibreria
LIMIT 5;

*/

-- Obtener los últimos 3 pedidos por fecha
-- ---------------------------------------
-- SQL Server – TOP
SELECT TOP (3) *
FROM PedidoLibreria
ORDER BY fecha_pedido DESC;

-- SQL Server – OFFSET...FETCH
SELECT *
FROM PedidoLibreria
ORDER BY fecha_pedido DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;




/*
MySQL / PostgreSQL – LIMIT

SELECT *
FROM PedidoLibreria
ORDER BY fecha_pedido DESC
LIMIT 3;
*/

-- Paginación → pedidos 6 al 10 (ordenados por fecha)
-- --------------------------------------------------
-- SQL Server
SELECT *
FROM PedidoLibreria
ORDER BY fecha_pedido
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

/*
-- MySQL / PostgreSQL
SELECT *
FROM PedidoLibreria
ORDER BY fecha_pedido
LIMIT 5 OFFSET 5;
*/

-- Los 5 pedidos más caros
-- ------------------------------
SELECT TOP (5) *
FROM PedidoLibreria
ORDER BY precio_unitario DESC;


-- SQL Server – OFFSET...FETCH
SELECT *
FROM PedidoLibreria
ORDER BY precio_unitario DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

/*
-- MySQL / PostgreSQL
SELECT *
FROM PedidoLibreria
ORDER BY precio_unitario DESC
LIMIT 5;
*/