# Producto
CREATE TABLE Producto (
codigo_id INT Not Null Identity(1,1),
descripcion VARCHAR(100) NOT NULL,
precio DECIMAL(9,2) NOT NULL,
estado CHAR(10) NOT NULL DEFAULT 'ACTIVO'
);
## ingresar 5 productos 
INSERT INTO Producto (descripcion, precio)
VALUES('YERBA', 2135), ('AZUCAR', 1526), ('ACEITE', 3520),('ARROZ', 1100),('FIDEO', 750);
## mostrar todos lo insertados
SELECT * FROM Producto;

##Alterar agregando un CONSTRAINT
ALTER TABLE Producto 
ADD CONSTRAINT precio CHECK(Precio > 0);
##Probar la nueva Resticcion
INSERT INTO Producto (descripcion, precio)
VALUES('ATUN', 0);

**Msg 547, Level 16, State 0, Line 16
**The INSERT statement conflicted with the CHECK constraint "precio". The conflict occurred in database "BD_serie3", table "dbo.Producto", column 'precio'.

codigo_id	descripcion	precio	estado
1	YERBA	2135.00	ACTIVO    
2	AZUCAR	1526.00	ACTIVO    
***3	ACEITE	3520.00	ACTIVO    
4	ARROZ	1100.00	ACTIVO    
5	FIDEO	750.00	ACTIVO    
##Actualizar un precio del producto 3
UPDATE Producto SET precio = 4500
WHERE codigo_id = 3;
codigo_id	descripcion	precio	estado
1	YERBA	2135.00	ACTIVO    
2	AZUCAR	1526.00	ACTIVO    
***3	ACEITE	4500.00	ACTIVO    
4	ARROZ	1100.00	ACTIVO    
5	FIDEO	750.00	ACTIVO    

##Rta:
****Al intentar de actulizar o insertar un registro de Producto con el precio en cero, se lanza la Resticcio, declarada en precio donde hace un checueo si cumple la condicion, sino cumple lanza un mensaje de error el motor de base de datos,

--Ejercicio 3
CREATE TABLE Empleado (
	codigo_id INT NOT NULL IDENTITY(1,1),
	apellido VARCHAR(100) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	dni CHAR(8) NOT NULL,
	fecha_ingreso DATE DEFAULT GETDATE()
)

INSERT INTO Empleado (apellido,nombre,dni)
VALUES('JUAN','PERZE', '12345678'),('PEDRO','PERZE', '12345679'),('MILTON','PERZE', '12345610'),('THIAGO','PERZE', '12345611');

SELECT * FROM Empleado;

ALTER TABLE Empleado
ADD CONSTRAINT UQ_Empleado_DNI UNIQUE(dni);

INSERT INTO Empleado (apellido,nombre,dni)
VALUES('JUAN','PERZE', '12345678');

Msg 2627, Level 14, State 1, Line 50
Violation of UNIQUE KEY constraint 'UQ_Empleado_DNI'. Cannot insert duplicate key in object 'dbo.Empleado'. The duplicate key value is (12345678).
The statement has been terminated.

Completion time: 2026-09-28T09:46:30.9613390-03:00

UPDATE Empleado SET dni='12345679'
WHERE codigo_id = 1;
Msg 2627, Level 14, State 1, Line 53
Violation of UNIQUE KEY constraint 'UQ_Empleado_DNI'. Cannot insert duplicate key in object 'dbo.Empleado'. The duplicate key value is (12345679).
The statement has been terminated.

Completion time: 2026-09-28T09:46:49.6413198-03:00