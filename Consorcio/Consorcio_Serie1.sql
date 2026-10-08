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
