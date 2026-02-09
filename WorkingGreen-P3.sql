CREATE DATABASE WorkingGreen
GO
USE WorkingGreen
Go


-- 1. TABLAS CATÁLOGO DE UBICACIÓN (NUEVO)
CREATE TABLE Paises (
    IDPais INT PRIMARY KEY IDENTITY(1,1),
    NombrePais VARCHAR(100) NOT NULL
);

CREATE TABLE Estados (
    IDEstado INT PRIMARY KEY IDENTITY(1,1),
    NombreEstado VARCHAR(100) NOT NULL,
    IDPais INT NOT NULL,
    CONSTRAINT FK_Estados_Pais FOREIGN KEY (IDPais) REFERENCES Paises(IDPais)
);

CREATE TABLE Ciudades (
    IDCiudad INT PRIMARY KEY IDENTITY(1,1),
    NombreCiudad VARCHAR(100) NOT NULL,
    IDEstado INT NOT NULL,
    CONSTRAINT FK_Ciudades_Estado FOREIGN KEY (IDEstado) REFERENCES Estados(IDEstado)
);

-- 2. TABLA PUESTOS (NUEVO)
CREATE TABLE Puestos (
    IDPuesto INT PRIMARY KEY IDENTITY(1,1),
    NombrePuesto VARCHAR(50) NOT NULL
);

-- 3. OTRAS TABLAS BASICAS
CREATE TABLE Servicios (
    IDServicio INT PRIMARY KEY IDENTITY(1,1),
    NombreServicio VARCHAR(100) NOT NULL
);

CREATE TABLE Modalidad(
    IDModalidad INT PRIMARY KEY IDENTITY (1,1),
    NombreModalidad VARCHAR(15) NOT NULL
);

-- 4. EMPLEADOS (MODIFICADO)
CREATE TABLE Empleados (
    IDEmpleado INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    ApellidoPaterno VARCHAR(50) NOT NULL, -- Separado
    ApellidoMaterno VARCHAR(50) NULL,     -- Separado
    IDPuesto INT NULL,                    -- Cambiado a ID
    FechaNacimiento DATE NULL,
    FechaContratacion DATE NULL,          -- Renombrado
    Calle VARCHAR(100) NULL,             -- Dirección Partida
    Numero VARCHAR(20) NULL,             -- Dirección Partida
    Colonia VARCHAR(100) NULL,           -- Dirección Partida
    IDCiudad INT NULL,                   -- ID en lugar de texto
    CodigoPostal VARCHAR(20) NULL,
    Telefono1 VARCHAR(30) NULL,
    Telefono2 VARCHAR(30) NULL,           -- Nuevo espacio
    Correo1 VARCHAR(100) NULL,            -- Nuevo espacio
    Correo2 VARCHAR(100) NULL,            -- Nuevo espacio
    AQuienReporta INT NULL,
    PersonaRegistra VARCHAR(100) NULL,
    FechaRegistro DATE NULL,
    PersonaEdita VARCHAR(100) NULL,
    FechaEdita DATE NULL,
    CONSTRAINT FK_Empleados_Puesto FOREIGN KEY (IDPuesto) REFERENCES Puestos(IDPuesto),
    CONSTRAINT FK_Empleados_Ciudad FOREIGN KEY (IDCiudad) REFERENCES Ciudades(IDCiudad),
    CONSTRAINT FK_Empleados_AQuienReporta FOREIGN KEY (AQuienReporta) REFERENCES Empleados(IDEmpleado)
);

-- 5. CLIENTES (MODIFICADO)
CREATE TABLE Clientes(
    IDCliente INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NULL,            -- Partido
    ApellidoPaterno VARCHAR(50) NOT NULL, -- Separado
    ApellidoMaterno VARCHAR(50) NULL,     -- Separado
    Calle VARCHAR(100) NULL,             -- Dirección Partida
    Numero VARCHAR(20) NULL,             -- Dirección Partida
    Colonia VARCHAR(100) NULL,           -- Dirección Partida
    IDCiudad INT NULL,                   -- ID en lugar de texto
    CodigoPostal VARCHAR(20) NULL,
    Telefono1 VARCHAR(30) NULL,
    Telefono2 VARCHAR(30) NULL,          -- Nuevo espacio
    Correo1 VARCHAR(100) NULL,           -- Nuevo espacio
    Correo2 VARCHAR(100) NULL,           -- Nuevo espacio
    PersonaRegistra VARCHAR(100) NULL,
    FechaRegistro DATE NULL,
    PersonaEdita VARCHAR(100) NULL,
    FechaEdita DATE NULL,
    CONSTRAINT FK_Clientes_Ciudad FOREIGN KEY (IDCiudad) REFERENCES Ciudades(IDCiudad)
);

-- 6. CURSOS (SIN CAMBIOS MAYORES)
CREATE TABLE Cursos(
    IDCurso INT PRIMARY KEY IDENTITY(1,1),
    NombreCurso VARCHAR(200) NOT NULL,
    Modalidad INT NOT NULL,
    IDServicio INT NOT NULL,
    DescripcionCurso VARCHAR(1000) NULL,
    PersonaRegistra VARCHAR(100) NULL,
    FechaRegistro DATE NULL,
    PersonaEdita VARCHAR(100) NULL,
    FechaEdita DATE NULL,
    CONSTRAINT FK_Cursos_Modalidad FOREIGN KEY (Modalidad) REFERENCES Modalidad(IDModalidad),
    CONSTRAINT FK_Cursos_Servicios FOREIGN KEY (IDServicio) REFERENCES Servicios(IDServicio)
);

-- 7. ORDEN
CREATE TABLE Orden(
    IDOrden INT PRIMARY KEY IDENTITY(1,1),
    IDCliente INT NOT NULL,
    FechaDeOrden DATE NOT NULL,
    PersonaRegistra VARCHAR(100) NULL,
    FechaRegistro DATE NULL,
    PersonaEdita VARCHAR(100) NULL,
    FechaEdita DATE NULL,
    CONSTRAINT FK_Orden_Cliente FOREIGN KEY (IDCliente) REFERENCES Clientes(IDCliente)
);

-- 8. ORDER DETAILS
CREATE TABLE OrderDetails(
    IDOrderDetail INT PRIMARY KEY IDENTITY(1,1),
    IDOrden INT NOT NULL,
    IDCurso INT NOT NULL,
    Precio DECIMAL(12,2) NOT NULL,
    Descuento DECIMAL(5,2) NULL,
    PersonaRegistra VARCHAR(100) NULL,
    FechaRegistro DATE NULL,
    PersonaEdita VARCHAR(100) NULL,
    FechaEdita DATE NULL,
    CONSTRAINT FK_OrderDetails_Orden FOREIGN KEY (IDOrden) REFERENCES Orden(IDOrden),
    CONSTRAINT FK_OrderDetails_Curso FOREIGN KEY (IDCurso) REFERENCES Cursos(IDCurso)
);

-- 9. PAGOS
CREATE TABLE TipoPago(
    IDTipoPago INT PRIMARY KEY IDENTITY(1,1),
    NombreTipo VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(200) NULL
);

CREATE TABLE Pagos(
    IDPagos INT PRIMARY KEY IDENTITY(1,1),
    IDOrderDetail INT NOT NULL,
    IDTipoPago INT NOT NULL,
    FechaPago DATE NOT NULL,
    MontoPagado DECIMAL(12,2) NOT NULL,
    ReferenciaPago VARCHAR(200) NULL,
    PersonaRegistra VARCHAR(100) NULL,
    FechaRegistro DATE NULL,
    PersonaEdita VARCHAR(100) NULL,
    FechaEdita DATE NULL,
    CONSTRAINT FK_Pagos_OrderDetail FOREIGN KEY (IDOrderDetail) REFERENCES OrderDetails(IDOrderDetail),
    CONSTRAINT FK_Pagos_TipoPago FOREIGN KEY (IDTipoPago) REFERENCES TipoPago(IDTipoPago)
);

-- 10. CURSO IMPARTIDO (MODIFICADO)
CREATE TABLE CursoImpartido(
    IDCursoImpartido INT PRIMARY KEY IDENTITY(1,1),
    IDCurso INT NOT NULL,
    IDEmpleado INT NOT NULL,
    FechaInicioCurso DATE NOT NULL,
    FechaFinCurso DATE NOT NULL,
    Direccion VARCHAR(255) NULL, -- Simplificado, se eliminó TipoLugar y LugarImparticion
    PersonaRegistra VARCHAR(100) NULL,
    FechaRegistro DATE NULL,
    PersonaEdita VARCHAR(100) NULL,
    FechaEdita DATE NULL,
    CONSTRAINT FK_CursoImpartido_Curso FOREIGN KEY (IDCurso) REFERENCES Cursos(IDCurso),
    CONSTRAINT FK_CursoImpartido_Empleado FOREIGN KEY (IDEmpleado) REFERENCES Empleados(IDEmpleado)
);

-- =============================================
-- INSERTS (ACTUALIZADOS A LA NUEVA ESTRUCTURA)
-- =============================================

-- Geografía
INSERT INTO Paises (NombrePais) VALUES ('Mexico');

INSERT INTO Estados (NombreEstado, IDPais)
VALUES ('Tamaulipas', 1),
       ('Nuevo León', 1),
       ('Veracruz', 1),
       ('Jalisco', 1),
       ('CDMX', 1);

INSERT INTO Ciudades (NombreCiudad, IDEstado)
VALUES 
('Tampico', 1),
('Ciudad Madero', 1),
('Altamira', 1),
('Reynosa', 1),
('Nuevo Laredo', 1),
('Monterrey', 2),
('Guadalupe', 2),
('Xalapa', 3),
('Veracruz', 3),
('Guadalajara', 4),
('Tlaquepaque', 4),
('Coyoacán', 5),
('Iztapalapa', 5);

-- Puestos
INSERT INTO Puestos (NombrePuesto)
VALUES ('Socio fundador'),
       ('Socio Consultor');
-- Catalogos Varios
INSERT INTO Modalidad (NombreModalidad)
VALUES ('En linea'),
       ('Presencial'),
       ('Mixta');

INSERT INTO Servicios (NombreServicio)
VALUES ('Cursos'),
       ('Capacitacion'),
       ('Soluciones ambientales');

INSERT INTO TipoPago (NombreTipo, Descripcion)
VALUES ('TarjetaCredito', 'Pago con tarjeta de crédito'),
       ('TarjetaDebito', 'Pago con tarjeta de débito'),
       ('Transferencia', 'Transferencia electrónica');

-- Empleados (Con IDs de Puesto y Ciudad, y apellidos separados)
INSERT INTO Empleados
(Nombre, ApellidoPaterno, ApellidoMaterno, IDPuesto, FechaNacimiento,
 FechaContratacion, Calle, Numero, Colonia, IDCiudad, CodigoPostal,
 Telefono1, Telefono2, Correo1, Correo2, AQuienReporta,
 PersonaRegistra, FechaRegistro)
VALUES
('Estuardo', 'Uribe', NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL,
 NULL, NULL, NULL, NULL, NULL, 'Ricardo', GETDATE()),

('Alejandra', 'Bustillos', 'Carballo', 2, NULL, NULL, NULL, NULL, NULL, 2, NULL,
 NULL, NULL, NULL, NULL, 1, 'Ricardo', GETDATE()),

('Marco', 'Guzman', 'Moctezuma', 2, NULL, NULL, NULL, NULL, NULL, 1, NULL,
 NULL, NULL, NULL, NULL, 1, 'Ricardo', GETDATE());

-- Actualizar referencia circular (AQuienReporta)
UPDATE Empleados SET AQuienReporta = 1 WHERE IDEmpleado IN (2,3);

-- CLIENTES (CORREGIDOS A LA ESTRUCTURA REAL)
INSERT INTO Clientes
(Nombre, ApellidoPaterno, ApellidoMaterno, Calle, Numero, Colonia,
 IDCiudad, CodigoPostal, Telefono1, Telefono2, Correo1, Correo2,
 PersonaRegistra, FechaRegistro)
VALUES
('Quantum', 'Energia', NULL, 'Av. Hidalgo', '100', 'Centro', 1, NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Iberdrola', 'Mexico', NULL, 'Calle 10', '200', 'Puerto Industrial', 3, NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Marina', 'S.A.', NULL, 'Blvd. Costero', 'S/N', 'Miramar', 2, NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Cosiproci', 'Inc', NULL, 'Calle Falsa', '123', 'Petrolera', 1, NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Grupo', 'Ibarra', NULL, 'Av. Universidad', '45', 'Lindavista', 1, NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Training', 'Consultors', NULL, 'Calle 5 de Mayo', '88', 'Zona Centro', 1, NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Marhnos', 'Constructora', NULL, 'Libramiento', '900', 'Industrial', 3, NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Favma', 'Construccion', NULL, 'Calle Real', '11', 'Unidad Nacional', 2, NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Sumimsa', 'S.A. de C.V.', NULL, 'Carretera Tampico', 'Km 5', 'Laguna', 3, NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Suministros', 'Merob', NULL, 'Av. Ejercito', '33', 'Altavista', 1, NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE());

-- Cursos (Sin cambios en inserts, solo estructura se mantiene)
INSERT INTO Cursos (NombreCurso, Modalidad, IDServicio, DescripcionCurso, PersonaRegistra, FechaRegistro)
VALUES
('Formación de Supervisores de Calidad', 2, 1, 'ISO Calidad.', 'Jovanavith', GETDATE()),
('Formación de Supervisores de Seguridad', 2, 1, 'Seguridad industrial.', 'Jovanavith', GETDATE()),
('Formación de Supervisores Ambientales', 2, 1, 'ISO 14001.', 'Jovanavith', GETDATE()),
('Entrenamiento Norma ISO 9001:2015', 2, 1, 'Requisitos ISO 9001.', 'Jovanavith', GETDATE()),
('Entrenamiento Norma ISO 14001:2015', 2, 1, 'Requisitos ISO 14001.', 'Jovanavith', GETDATE()),
('Entrenamiento Norma ISO 45001:2018', 2, 1, 'Seguridad y Salud.', 'Jovanavith', GETDATE()),
('Gestión de Sustancias Químicas', 2, 1, 'Manejo ambiental.', 'Jovanavith', GETDATE()),
('Investigación de Accidentes', 2, 1, 'Causa raíz.', 'Jovanavith', GETDATE()),
('Formación en Auditoría Ambiental', 2, 1, 'Auditoría.', 'Jovanavith', GETDATE()),
('Legislación Ambiental', 2, 1, 'Cumplimiento legal.', 'Jovanavith', GETDATE()),
('Desarrollo de Habilidades Gerenciales', 2, 1, 'Liderazgo.', 'Jovanavith', GETDATE()),
('Elaboración de Manuales', 2, 1, 'Documentación.', 'Jovanavith', GETDATE()),
('Inspección Visual de Soldadura', 2, 1, 'Discontinuidades.', 'Jovanavith', GETDATE());

-- Orden
INSERT INTO Orden (IDCliente, FechaDeOrden, PersonaRegistra, FechaRegistro)
VALUES
(1, GETDATE(), 'Ricardo', GETDATE()),
(2, GETDATE(), 'Ricardo', GETDATE());

-- OrderDetails
INSERT INTO OrderDetails
(IDOrden, IDCurso, Precio, Descuento, PersonaRegistra, FechaRegistro)
VALUES
(1, 1, 1500.00, 0.00, 'Ricardo', GETDATE()),
(1, 2, 2400.00, 0.00, 'Ricardo', GETDATE()),
(2, 3, 1800.00, 0.00, 'Ricardo', GETDATE());

-- Pagos
INSERT INTO Pagos
(IDOrderDetail, IDTipoPago, FechaPago, MontoPagado, ReferenciaPago,
 PersonaRegistra, FechaRegistro)
VALUES
(1, 3, GETDATE(), 1500.00, 'TRX-0001', 'Ricardo', GETDATE()),
(2, 1, GETDATE(), 2400.00, 'CC-1234', 'Ricardo', GETDATE()),
(3, 2, GETDATE(), 3600.00, 'DB-9876', 'Ricardo', GETDATE());

-- CursoImpartido (Con campo Direccion simplificado)
INSERT INTO CursoImpartido
(IDCurso, IDEmpleado, FechaInicioCurso, FechaFinCurso, Direccion,
 PersonaRegistra, FechaRegistro)
VALUES
(1, 1, DATEADD(day, -30, GETDATE()), DATEADD(day, -28, GETDATE()), 'Sala A - Oficina Central', 'Ricardo', GETDATE()),
(2, 2, DATEADD(day, -15, GETDATE()), DATEADD(day, -14, GETDATE()), 'Planta B - Zona Industrial', 'Ricardo', GETDATE()),
(3, 3, DATEADD(day, 5, GETDATE()), DATEADD(day, 7, GETDATE()), 'Zoom Meeting ID: 12345', 'Ricardo', GETDATE());