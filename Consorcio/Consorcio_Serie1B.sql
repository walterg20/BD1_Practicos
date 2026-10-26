USE base_consorcio_2025
GO

--1)

SELECT  persona_id, apellido_nombre, fecha_nacimiento FROM persona
WHERE Month(fecha_nacimiento)%2 = 0

--2)
SELECT edificio_id, nombre, direccion FROM edificio
WHERE direccion LIKE '[0-9]%'

--3)

SELECT  persona_id, apellido_nombre, fecha_nacimiento FROM persona
WHERE MONTH(fecha_nacimiento) = MONTH(GETDATE())

--4)

SELECT  persona_id, apellido_nombre, telefono, LEN(apellido_nombre) as long_ayn FROM persona
WHERE LEN(apellido_nombre) BETWEEN 20 AND 25
ORDER BY long_ayn DESC;

--5) 
SELECT * FROM gasto
WHERE importe >= 50000

--6)
SELECT administrador_id, 
Condicion = CASE WHEN vive_ahi = 'S' THEN 'RESIDENTE'
				WHEN vive_ahi = 'N'  THEN 'NO RESIDENTE'
				ELSE 'NO TIENE CONDICION'
			END
	
FROM administrador

--7)
SELECT persona_id, apellido_nombre FROM persona
WHERE apellido_nombre LIKE '%LL%' OR apellido_nombre LIKE '%RR%'

--8)
SELECT gasto_id, periodo, fecha_pago, importe , 
	Dia = CASE WHEN   DATEPART(WEEKDAY, fecha_pago) = 1 THEN 'LUNES'
			   WHEN   DATEPART(WEEKDAY, fecha_pago) = 2 THEN 'MARTES'
			   WHEN   DATEPART(WEEKDAY, fecha_pago) = 3 THEN 'MIERCOLES'
			   WHEN   DATEPART(WEEKDAY, fecha_pago) = 4 THEN 'JUEVES'
			   WHEN   DATEPART(WEEKDAY, fecha_pago) = 5 THEN 'VIERNES'
		  END

FROM gasto
WHERE (importe > 20000) AND (MONTH(fecha_pago) BETWEEN 1 AND 2) AND  DATEPART(WEEKDAY, fecha_pago) < 6

--10) EL EJEMPLO CON PERSONA QUE VA A CUMPLIR 32 AÑOS EXACTO
SELECT  persona_id, apellido_nombre, fecha_nacimiento, DATEDIFF(YEAR,fecha_nacimiento,GETDATE()) AS edad FROM persona
WHERE DATEDIFF(YEAR,fecha_nacimiento,GETDATE())= 31 
AND ((MONTH(fecha_nacimiento) = MONTH(GETDATE()) AND DAY(fecha_nacimiento) > DAY(GETDATE())) 
OR MONTH(fecha_nacimiento) > MONTH(GETDATE()))

--11)
SELECT persona_id,LOWER(RTRIM(apellido_nombre)) AS nombre_minuscula ,apellido_nombre FROM persona

--12) 
SELECT nombre, SUBSTRING(nombre, 1,4) AS prefijo, SUBSTRING(direccion,1, 10) AS Direcion_corta FROM edificio

--13)
SELECT  persona_id, apellido_nombre, telefono FROM persona
WHERE NOT (LEFT(telefono,2) = 37)

--14)
SELECT nombre, CONCAT(UPPER(SUBSTRING(nombre,1,1)), LOWER(SUBSTRING(nombre,2,LEN(nombre)))) AS nombre_formateado FROM zona;

--15)
SELECT gasto_id, importe, ROUND(importe * 1.125, 2) AS importe_ajuste FROM gasto

--16)
SELECT gasto_id, ROUND(ABS(importe),1) FROM gasto
WHERE importe < 0;

--17)
SELECT YEAR(fecha_pago) AS Anio,  MONTH(fecha_pago) AS Mes,importe FROM gasto
ORDER BY Anio DESC, Mes DESC

--18)
SELECT persona_id, apellido_nombre, DATEDIFF(YEAR,fecha_nacimiento, GETDATE()) AS Edad FROM persona

--19)

SELECT gasto_id,fecha_pago, FORMAT(CONVERT(DATE,fecha_pago, 102), 'dd/MM/yyyy') AS fecha_pago_formateado FROM gasto

--20)

SELECT CONCAT(periodo, ' - ', importe) AS descripcion_formateada FROM gasto

--21)
SELECT tipo_gasto_id, COUNT(*) AS cantidad, SUM(importe) AS total_importe FROM gasto
GROUP BY tipo_gasto_id

--22)

SELECT tipo_gasto_id, COUNT(*) AS cantidad, MIN(importe) AS minimo, MAX(importe) AS maximo, AVG(importe) AS Promedop, SUM(importe) AS total_importe FROM gasto
GROUP BY tipo_gasto_id

--23)
SELECT periodo, SUM(IMPORTE) AS total_periodo, AVG(importe) AS promedio_periodo FROM gasto
GROUP BY periodo

--24)
SELECT periodo, tipo_gasto_id, COUNT(importe) AS promedio_periodo, SUM(IMPORTE) AS total FROM gasto
GROUP BY periodo, tipo_gasto_id

--25)
SELECT periodo, SUM(IMPORTE) AS total_perido FROM gasto
GROUP BY periodo
HAVING SUM(IMPORTE) > 5000000

--26)
SELECT periodo, AVG(importe) AS promedio_perido FROM gasto
where importe > 4000
GROUP BY periodo
HAVING AVG(importe) > 25000

--27)
SELECT YEAR(fecha_pago) AS anio_pago, SUM(importe) AS total_anual FROM gasto
GROUP BY  YEAR(fecha_pago)

--28)
SELECT YEAR(fecha_pago) AS anio_pago, MONTH(fecha_pago) AS mes_pago, SUM(importe) AS total_anual, AVG(importe) AS promedio_anual FROM gasto
GROUP BY  YEAR(fecha_pago), MONTH(fecha_pago)

--29)
SELECT YEAR(fecha_pago) AS anio_pago, SUM(importe) AS total_anual FROM gasto
GROUP BY  YEAR(fecha_pago)
HAVING  SUM(importe) <15000000

--30)
SELECT tipo_gasto_id , ROUND(AVG(importe), 1) AS promedio_redondeado FROM gasto
GROUP BY  tipo_gasto_id

--31)
SELECT YEAR(fecha_pago) AS anio_pago,MONTH(fecha_pago) AS mes_pago, ROUND(AVG(importe), 1) AS promedio_redondeado FROM gasto
GROUP BY YEAR(fecha_pago), MONTH(fecha_pago)
ORDER BY YEAR(fecha_pago), MONTH(fecha_pago) 

--32)
SELECT periodo, COUNT(importe) AS cantidad, SUM(importe),AVG(importe) AS promedio, MIN(importe) as minimo, MAX(importe) as maximo FROM gasto
GROUP BY periodo

--33)
SELECT tipo_gasto_id, COUNT(importe) AS cantidad, AVG(importe) AS promedio FROM gasto
GROUP BY tipo_gasto_id
HAVING AVG(importe) > 5000 AND  COUNT(importe) < 1600

--34)
SELECT rango_importe = CASE 
						WHEN  importe < 2000 THEN 'BAJO'
						WHEN importe >= 2000 AND importe <= 10000 THEN 'MEDIO'
						WHEN  importe > 10000 THEN 'ALTO'
					   END,
	COUNT(*) AS cantidad, AVG(importe) AS promedio FROM gasto
GROUP BY  
 CASE
	WHEN  importe < 2000 THEN 'BAJO'
	WHEN importe >= 2000 AND importe <= 10000 THEN 'MEDIO'
	WHEN  importe > 10000 THEN 'ALTO'
END 
ORDER BY rango_importe ASC

--35)
SELECT YEAR(fecha_pago) AS anio_pago, AVG(importe) AS promedio_anual FROM gasto
--WHERE AVG(importe) BETWEEN 11000 AND 13000
GROUP BY YEAR(fecha_pago)
HAVING AVG(importe) BETWEEN 11000 AND 13000
ORDER BY anio_pago, promedio_anual DESC