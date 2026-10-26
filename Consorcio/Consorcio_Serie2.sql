
-- 1. Realizar una copia de seguridad "Solo copia" de la base original
-- Esto evita romper cualquier cadena de backups que ya tengas configurada en producción.
BACKUP DATABASE [base_consorcio_2025]
TO DISK = 'E:\UNNE\Base de datos I\Practico-Laboratorio\Consorcio\consorcio_temp.bak' 
WITH COPY_ONLY, FORMAT, INIT, STATS = 10;
GO

USE consorcio_test_update
Go
--1) 
SELECT * FROM persona WHERE telefono = NULL --no Sale nada

--2) 
SELECT persona_id, apellido_nombre, telefono FROM persona WHERE telefono  IS NULL;

--3)
SELECT persona_id, apellido_nombre, telefono FROM persona WHERE NOT telefono  IS NULL;

--4)

SELECT persona_id, isnull(apellido_nombre, '(Sin Datos)'), ISNULL(telefono, '(Sin Datos)') FROM persona;

--5)
SELECT 
	CASE 
		WHEN COALESCE(nombre, capital, 'Desconocido')= 'Desconocido' THEN 'Desconocido'
		WHEN ISNULL(nombre, 'Desconocido') = 'Desconocido' THEN capital
		else nombre
	END as NombreCapital, capital 
FROM provincia

--6)
SELECT gasto_id, periodo, importe FROM gasto WHERE importe IS NULL

--7)
SELECT gasto_id, periodo, importe, importe*1.10 AS '+10%' FROM gasto --Queda en null

--8)
SELECT gasto_id, periodo, importe, ISNULL(importe,0)*1.10 AS '+10%' FROM gasto

--9)
SELECT AVG(importe) as promedio_sin_nulos, AVG(ISNULL(importe,0))  AS promedio_con_cero FROM gasto --AVG ya ignora los null

--10)
SELECT COUNT(*) as 'cant de gastos', COUNT(importe)  AS 'cant importe' FROM gasto --Count(*) cuebta todos lo registro no importa lo null y Count(Column) ignora los null

--11)
SELECT * FROM persona
ORDER BY telefono;
SELECT * FROM persona
ORDER BY telefono DESC;

--12)
SELECT persona_id, apellido_nombre, ISNULL(LEN(telefono), 0) AS 'longitud_telefono'  FROM persona

--13)
SELECT persona_id, apellido_nombre, fecha_nacimiento FROM persona WHERE fecha_nacimiento IS NULL; 

--14)
 SELECT persona_id, apellido_nombre, ISNULL(DATEDIFF(yyyy,fecha_nacimiento, GETDATE()),0) AS 
edad 
 FROM persona

 --15)
 SELECT apellido_nombre, telefono, estado_civil FROM persona WHERE telefono IS NULL OR estado_civil is NULL

 --16)
 SELECT P.apellido_nombre, A.vive_ahi FROM administrador as a
 INNER JOIN persona AS p ON P.persona_id = A.administrador_id 
