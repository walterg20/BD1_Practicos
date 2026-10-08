--1)
SELECT * FROM persona --220

--2)
SELECT apellido_nombre, fecha_nacimiento FROM persona;-220

--3)
SELECT 4+5*3/2-1  --10

SELECT (4+5)*3/2-1 --12

--4)
SELECT e.nombre, SUM(g.importe) as total, Round( SUM(g.importe)+( SUM(g.importe)*0.20), 1) as 'Redondeado a un digito',  round( SUM(g.importe)*1.2, 0,1) as 'Truncado a un digito'
FROM edificio AS e INNER JOIN gasto as g  ON g.provincia_id = e.provincia_id AND g.localidad_id = e.localidad_id AND g.edificio_id = e.edificio_id
GROUP BY e.edificio_id,e.nombre

--5)
SELECT nombre, poblacion
FROM provincia; --24

--6)
SELECT DISTINCT e.provincia_id, p.nombre
FROM edificio AS e INNER JOIN provincia AS p oN p.provincia_id = e.provincia_id;

--7)
SELECT TOP 4  apellido_nombre 
FROM persona
ORDER BY left(apellido_nombre, 7);

--select top 4 apellido_nombre FROM persona order by left(apellido_nombre, 7);

--select top 4 apellido_nombre FROM persona order by apellido_nombre;

--8)
SELECT TOP 4  WITH TIES apellido_nombre 
FROM persona
ORDER BY left(apellido_nombre, 7);

--9)
SELECT TOP 4  WITH TIES apellido_nombre 
FROM persona
ORDER BY left(apellido_nombre, 7) DESC;

--10)
SELECT p.nombre, e.nombre, e.direccion FROM edificio as e
INNER JOIN provincia as p ON p.provincia_id = e.provincia_id

WHERE p.provincia_id = 2

--11)
SELECT nombre, direccion FROM edificio

WHERE nombre LIKE 'EDIFICIO-3%'

--12) 
SELECT concat(apellido_nombre,'-' ,telefono, '-',fecha_nacimiento) as 'Datos Personales'
	FROM persona where sexo = 'F';

--13)
SELECT * FROM gasto
WHERE importe BETWEEN 10 AND 100;

--14)
SELECT * FROM persona
WHERE DATEPART(YYYY,fecha_nacimiento) BETWEEN 1960 and 1969
ORDER BY fecha_nacimiento DESC
-- fecha_nacimiento >= '19600101' AND fecha_nacimiento < '19610101' 
--fecha_nacimiento BETWEEN CONVERT(DATETIME,'1960-01-01 00:00:00 ',102) AND CONVERT(DATETIME,'1960-12-31 00:00:00',102)

--15)
SELECT * FROM localidad
WHERE	provincia_id = 1 OR provincia_id = 2

--16)
SELECT * FROM edificio
WHERE direccion LIKE '____N%'

--17)
SELECT TOP 237 *  FROM gasto
ORDER BY importe ASC

--18)
SELECT TOP 237  WITH TIES importe FROM gasto
ORDER BY importe ASC

--19) 
SELECT periodo,fecha_pago, importe, 'Importe Actualizado' = CASE
WHEN importe < 10000 THEN (importe * 1.15)
WHEN importe >= 10000 AND importe <= 20000 THEN (importe * 1.10)
ELSE (importe * 1.05)
END
FROM gasto
ORDER BY importe DESC

--20)
SELECT 
    SUM(CASE WHEN estado_civil = 'c' THEN 1 ELSE 0 END) AS Casado,
    SUM(CASE WHEN estado_civil = 'S' THEN 1 ELSE 0 END) AS Soltero
FROM persona;

--21)
SELECT SUM(importe) as Sumatoria, Count(*) as Cantidad, AVG(importe) as Promedio
FROM gasto