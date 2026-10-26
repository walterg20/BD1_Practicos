CREATE DATABASE BD_serie3;
use BD_serie3;
CREATE TABLE Cliente(
	id INT NOT NULL IDENTITY(1,2),
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	correo   VARCHAR(30) NULL,
	fecha_alta DATE NOT NULL, 
	CONSTRAINT pk_cliente PRIMARY KEY(id)
);

ALTER TABLE Cliente 
ADD CONSTRAINT DF_Cliente_fecha_alta DEFAULT '2026/01/01' FOR fecha_alta;


ALTER TABLE Cliente ADD CONSTRAINT UQ_Cliente_correo UNIQUE(correo);

INSERT INTO Cliente(nombre, apellido, correo)
VALUES ('JUANCITO', 'Perez','jaun@correo.com'),
		('ROMAN', 'RIQUELME','roman@correo.com'),
		('Ariel', 'ORTEGA','ariel@correo.com');

INSERT INTO Cliente (nombre, apellido, correo)
VALUES ('IVANA', 'PONCE')

SELECT * FROM Cliente;


INSERT INTO Cliente(nombre, apellido, correo)
VALUES('JUANCITO', 'Perez','jaun@correo.com');