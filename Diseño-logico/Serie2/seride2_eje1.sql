
USE BD_Serie2
go 

CREATE TABLE Articulo (
    cod_articulo VARCHAR(10),
    nombre_articulo VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Articulo PRIMARY KEY (cod_articulo)
);

CREATE TABLE Cliente (
    cod_cliente VARCHAR(10),
    nombre_cliente VARCHAR(100) NOT NULL,
    domicilio_entrega VARCHAR(150) NULL,
    localidad VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Cliente PRIMARY KEY (cod_cliente)
);

CREATE TABLE Orden (
    nro_orden INT,
    fecha_orden DATE NOT NULL,
    cod_cliente VARCHAR(10) NOT NULL,
    CONSTRAINT PK_Orden PRIMARY KEY (nro_orden),
    CONSTRAINT FK_Orden_Cliente FOREIGN KEY (cod_cliente) 
        REFERENCES Cliente(cod_cliente)
);

CREATE TABLE Detalle_Orden (
    nro_orden INT NOT NULL,
    cod_articulo VARCHAR(10) NOT NULL,
    cantidad_enviada INT NOT NULL,
    CONSTRAINT PK_Detalle_Orden PRIMARY KEY (nro_orden, cod_articulo),
    CONSTRAINT FK_Detalle_Orden FOREIGN KEY (nro_orden) 
        REFERENCES Orden(nro_orden),
    CONSTRAINT FK_Detalle_Articulo FOREIGN KEY (cod_articulo) 
        REFERENCES Articulo(cod_articulo)
);
--Poblado de datos
--Efectivamente, como los códigos contienen letras (`C001`, `A101`, etc.), deben definirse como tipos alfanuméricos (`VARCHAR` o `CHAR`) y no numéricos.

--A continuación tienes la definición de tablas con los tipos de datos adecuados y las sentencias `INSERT` en el orden correcto de integridad referencial (respetando las claves foráneas):

```sql
-- ==========================================================
-- 1. CREACIÓN DE TABLAS (con tipos alfanuméricos adecuados)
-- ==========================================================

CREATE TABLE Articulo (
    cod_articulo VARCHAR(10) PRIMARY KEY,
    nombre_articulo VARCHAR(100) NOT NULL
);

CREATE TABLE Cliente (
    cod_cliente VARCHAR(10) PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL,
    domicilio_entrega VARCHAR(150) NULL,
    localidad VARCHAR(100) NOT NULL
);

CREATE TABLE Orden (
    nro_orden INT PRIMARY KEY,
    fecha_orden DATE NOT NULL,
    cod_cliente VARCHAR(10) NOT NULL,
    FOREIGN KEY (cod_cliente) REFERENCES Cliente(cod_cliente)
);

CREATE TABLE Detalle_Orden (
    nro_orden INT NOT NULL,
    cod_articulo VARCHAR(10) NOT NULL,
    cantidad_enviada INT NOT NULL,
    PRIMARY KEY (nro_orden, cod_articulo),
    FOREIGN KEY (nro_orden) REFERENCES Orden(nro_orden),
    FOREIGN KEY (cod_articulo) REFERENCES Articulo(cod_articulo)
);

--  POBLADO DE DATOS (INSERT)

INSERT INTO Articulo (cod_articulo, nombre_articulo) VALUES
('A101', 'Teclado inalámbrico'),
('A205', 'Mouse óptico'),
('A310', 'Pad mouse'),
('A450', 'Webcam HD'),
('A520', 'Auriculares'),
('A610', 'Parlantes USB');


INSERT INTO Cliente (cod_cliente, nombre_cliente, domicilio_entrega, localidad) VALUES
('C001', 'Juan Pérez', 'Av. 3 de Abril 1250', 'Corrientes'),
('C002', 'María Gómez', 'San Martín 845', 'Resistencia'),
('C003', 'Pedro López', 'Rivadavia 560', 'Goya'),
('C004', 'Ana Martínez', NULL, 'Corrientes');


INSERT INTO Orden (nro_orden, fecha_orden, cod_cliente) VALUES
(1001, '2026-09-05', 'C001'),
(1002, '2026-09-06', 'C002'),
(1003, '2026-09-06', 'C001'),
(1004, '2026-09-07', 'C003'),
(1005, '2026-09-08', 'C004');

INSERT INTO Detalle_Orden (nro_orden, cod_articulo, cantidad_enviada) VALUES
(1001, 'A101', 1),
(1001, 'A205', 2),
(1001, 'A310', 1),
(1002, 'A101', 1),
(1002, 'A450', 1),
(1003, 'A205', 1),
(1004, 'A520', 1),
(1004, 'A610', 2),
(1005, 'A101', 1);

--respondiento al ejercicio

-- Eliminar la restricción de Clave Primaria compuesta actual.
-- Los datos existentes en la tabla se mantienen intactos.
ALTER TABLE detalle_orden 
DROP CONSTRAINT pk_detalle_orden;

-- Agregar una nueva columna que actuará como PK simple autoincremental.

ALTER TABLE detalle_orden 
ADD id_detalle INT IDENTITY(1,1);

-- Establecer la nueva columna como la Clave Primaria de la tabla.
ALTER TABLE detalle_orden 
ADD CONSTRAINT pk_detalle_orden PRIMARY KEY (id_detalle);

--  Crear la restricción UNIQUE sobre las dos columnas anteriores.

ALTER TABLE detalle_orden 
ADD CONSTRAINT uq_orden_articulo UNIQUE (nro_orden, cod_articulo);

--Parte 2
CREATE TABLE Cliente_Domicilio (
    id_domicilio INT,
    cod_cliente VARCHAR(10) NOT NULL,
    domicilio_entrega VARCHAR(150) NOT NULL,
    localidad VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Cliente_Domicilio PRIMARY KEY (id_domicilio),
    CONSTRAINT FK_Domicilio_Cliente FOREIGN KEY (cod_cliente) 
        REFERENCES Cliente(cod_cliente)
);

--Alterar orden
 -- Agregar la columna id_domicilio admitiendo nulos en Orden
ALTER TABLE Orden
ADD id_domicilio INT NULL;

-- Crear la restricción de clave foránea hacia Cliente_Domicilio
ALTER TABLE Orden
ADD CONSTRAINT FK_Orden_Domicilio 
    FOREIGN KEY (id_domicilio) 
    REFERENCES Cliente_Domicilio(id_domicilio);

-- Eliminar las columnas de domicilio y localidad en Cliente
ALTER TABLE Cliente 
DROP COLUMN domicilio_entrega; 
ALTER TABLE Cliente 
DROP COLUMN localidad;