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