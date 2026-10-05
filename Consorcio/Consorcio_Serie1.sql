--1)
SELECT * FROM persona --220

--2)
SELECT apellido_nombre, fecha_nacimiento FROM persona;-220

--3)
SELECT 4+5*3/2-1  --10

SELECT (4+5)*3/2-1 --12

--4)
SELECT e.nombre, SUM(g.importe) as total, Round( SUM(g.importe), 1) as 'Redondeado a un digito',  round( SUM(g.importe), 0,1) as 'Truncado a un digito'
FROM edificio AS e INNER JOIN gasto as g  ON g.provincia_id = e.provincia_id AND g.localidad_id = e.localidad_id AND g.edificio_id = e.edificio_id
GROUP BY e.edificio_id,e.nombre

--5)
SELECT nombre, poblacion
FROM provincia; --24

--6)
SELECT DISTINCT e.provincia_id, p.nombre
FROM edificio AS e INNER JOIN provincia AS p oN p.provincia_id = e.provincia_id;