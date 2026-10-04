```sql
Use BD_serie3
---Ejercicio 2
CREATE TABLE Producto (
codigo_id INT Not Null Identity(1,1),
descripcion VARCHAR(100) NOT NULL,
precio DECIMAL(9,2) NOT NULL,
estado CHAR(10) NOT NULL DEFAULT 'ACTIVO'
);

INSERT INTO Producto (descripcion, precio)
VALUES('YERBA', 2135), ('AZUCAR', 1526), ('ACEITE', 3520),('ARROZ', 1100),('FIDEO', 750);

SELECT * FROM Producto;

ALTER TABLE Producto 
ADD CONSTRAINT precio CHECK(Precio > 0);

INSERT INTO Producto (descripcion, precio)
VALUES('ATUN', 0);

UPDATE Producto SET precio = 0
WHERE codigo_id = 3;

SELECT * FROM Cliente;

ALTER TABLE Cliente 
DROP CONSTRAINT DF_Cliente_fecha_alta;

ALTER TABLE Cliente 
ADD CONSTRAINT DF_Cliente_fecha_alta DEFAULT GETDATE() FOR fecha_alta;

INSERT INTO Cliente (nombre, apellido, correo)
VALUES('ALMA1', 'NORIEGA1', 'alma1@correo.com');

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

UPDATE Empleado SET dni='12345679'
WHERE codigo_id = 1;

--Ejerccio 4
CREATE TABLE Pedido(
 id_pedido INT IDENTITY(1,1) NOT NULL,
 fecha DATE NOT NULL DEFAULT GETDATE(),
 importe DECIMAL(10,2) NOT NULL,
 id_cliente INT NOT NULL,
 CONSTRAINT pk_pedido PRIMARY KEY(id_pedido) 
);

--Insertar pedido
INSERT INTO Pedido (importe,id_cliente)
VALUES(1500, 1), (2500,2), (5000,3);

--Agregar foreig key al pedido de cliente
ALTER TABLE Pedido ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY(id_cliente) 
REFERENCES Cliente(id);

--El error es por que tengo en la id_cliente un id (3) que no esta en cliente
--Msg 547, Level 16, State 0, Line 72
--The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "fk_pedido_cliente". The conflict occurred in database "BD_serie3", table "dbo.Cliente", column 'id'.

--DEspues de agregar el FOREIGN KEY, probre con un insertar  pedido con un clientes no existentes
--Msg 547, Level 16, State 0, Line 68
--The INSERT statement conflicted with the FOREIGN KEY constraint "fk_pedido_cliente". The conflict occurred in database "BD_serie3", table "dbo.Cliente", column 'id'.

--Ejerccio 5 - elinacion de pedidos
SELECT * FROM Cliente WHERE id = 3;

DELETE FROM Cliente WHERE id = 3;

--Dio error por integridad referencial, que dice que el cliente esta en un pedido y no se puede borrar
--Msg 547, Level 16, State 0, Line 86
--The DELETE statement conflicted with the REFERENCE constraint "fk_pedido_cliente". The conflict occurred in database "BD_serie3", table "dbo.Pedido", column 'id_cliente'.

DELETE FROM Cliente WHERE id = 15;
--Se pudo borrar al no tener pedido
--(1 row affected)

--Ejerccio 6

ALTER TABLE Pedido ADD fecha_entrega DATE NULL;

UPDATE Pedido SET fecha_entrega = '01/10/2026' WHERE id_pedido=3;

SELECT * FROM Pedido WHERE fecha_entrega IS NULL;--obtiene correctemente lo registro null

SELECT * FROM Pedido WHERE fecha_entrega = NULL;--no trae nada 

--La direncia que is null trae correctamente los registro con fecha_entrega=null y 
--la otra consulta no trae ningun registro


```