CREATE DATABASE WorkingGreen
USE WorkingGreen
SELECT*FROM Clientes
SELECT*FROM CursoImpartido
SELECT*FROM Cursos
SELECT*FROM Empleados
SELECT*FROM Modalidad
SELECT*FROM Orden
SELECT*FROM OrderDetails
SELECT*FROM Pagos
SELECT*FROM Servicios
SELECT*FROM TipoPago


--Buena suerte leyendo esto 
DROP TABLE Servicios 

CREATE TABLE Modalidad(
    IDModalidad INT PRIMARY KEY IDENTITY (1,1),
    NombreModalidad VARCHAR(15) NOT NULL
);

CREATE TABLE Empleados (
    IDEmpleado INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Puesto VARCHAR(50) NULL,
    FechaNacimiento DATE NULL,
    FechaContrato DATE NULL,
    Direccion VARCHAR(200) NULL,
    Ciudad VARCHAR(100) NULL,
    Pais VARCHAR(100) NULL,
    CodigoPostal VARCHAR(20) NULL,
    Telefono VARCHAR(30) NULL,
    AQuienReporta INT NULL, -- self-referential FK
    PersonaRegistra VARCHAR(100) NULL,
    FechaRegistro DATE NULL,
    PersonaEdita VARCHAR(100) NULL,
    FechaEdita DATE NULL,
    CONSTRAINT FK_Empleados_AQuienReporta FOREIGN KEY (AQuienReporta) REFERENCES Empleados(IDEmpleado)
);

CREATE TABLE Clientes(
    IDCliente INT PRIMARY KEY IDENTITY(1,1),
    NombreCliente VARCHAR(100) NULL,
    Direccion VARCHAR(200) NULL,
    Ciudad VARCHAR(100) NULL,
    Pais VARCHAR(100) NULL,
    CodigoPostal VARCHAR(20) NULL,
    Telefono VARCHAR(30) NULL,
    PersonaRegistra VARCHAR(100) NULL,
    FechaRegistro DATE NULL,
    PersonaEdita VARCHAR(100) NULL,
    FechaEdita DATE NULL
);

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
);

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

CREATE TABLE CursoImpartido(
    IDCursoImpartido INT PRIMARY KEY IDENTITY(1,1),
    IDCurso INT NOT NULL,
    IDEmpleado INT NOT NULL,
    FechaInicioCurso DATE NOT NULL,
    FechaFinCurso DATE NOT NULL,
    LugarImparticion VARCHAR(200) NULL,
    TipoLugar VARCHAR(50) NULL,
    PersonaRegistra VARCHAR(100) NULL,
    FechaRegistro DATE NULL,
    PersonaEdita VARCHAR(100) NULL,
    FechaEdita DATE NULL,
    CONSTRAINT FK_CursoImpartido_Curso FOREIGN KEY (IDCurso) REFERENCES Cursos(IDCurso),
    CONSTRAINT FK_CursoImpartido_Empleado FOREIGN KEY (IDEmpleado) REFERENCES Empleados(IDEmpleado)
);

--INSERTS 

INSERT INTO Modalidad (NombreModalidad) VALUES
('En linea'), ('Presencial'), ('Mixta');

INSERT INTO Empleados (Nombre, Apellido, Puesto, FechaNacimiento, FechaContrato, Direccion, Ciudad, Pais, CodigoPostal, Telefono, AQuienReporta, PersonaRegistra, FechaRegistro)
VALUES
('Estuardo', 'Uribe', 'Socio fundador', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Ricardo', GETDATE()),
('Alejandra Guadalupe', 'Bustillos Carballo', 'Socio Consultor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'Ricardo', GETDATE()),
('Marco Antonio', 'Guzman Moctezuma', 'Socio Consultor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'Ricardo', GETDATE());

INSERT INTO Clientes (NombreCliente,  Direccion, Ciudad, Pais, CodigoPostal, Telefono, PersonaRegistra, FechaRegistro)
VALUES
('Quantum Energia', NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Iberdrola',  NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Marina', NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Cosiproci', NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Grupo Ibarra',  NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Training Consultors',  NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Marhnos',  NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Favma Construccion',  NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Sumimsa', NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Suministros Merob',  NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Isolux Corsan',  NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Prince', NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Naturgy',  NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Kinich Energy', NULL, NULL, NULL, NULL, NULL, 'Ullises', GETDATE()),
('ITCM', NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('UNE', NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Madisa',  NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Tecoatl', NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Gasra', NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Kranno', NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Administracion del sistema portuario nacional', NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE()),
('Telecom', NULL, NULL, NULL, NULL, NULL, 'Ulises', GETDATE());

INSERT INTO Cursos (NombreCurso, Modalidad, IDServicio, DescripcionCurso, PersonaRegistra, FechaRegistro)
VALUES
('Formación de Supervisores de Calidad', 2, 1, 'Herramientas prácticas para supervisar procesos y cumplir estándares de calidad ISO.', 'Jovanavith', GETDATE()),
('Formación de Supervisores de Seguridad', 2, 1, 'Capacitación para identificar riesgos, prevenir incidentes y fortalecer la seguridad industrial.', 'Jovanavith', GETDATE()),
('Formación de Supervisores Ambientales', 2, 1, 'Aplicación de normatividad ambiental y fundamentos de gestión ISO 14001.', 'Jovanavith', GETDATE()),
('Entrenamiento Norma ISO 9001:2015', 2, 1, 'Interpretación y aplicación de los requisitos ISO 9001.', 'Jovanavith', GETDATE()),
('Entrenamiento Norma ISO 14001:2015', 2, 1, 'Comprender y aplicar los requisitos de la norma ISO 14001.', 'Jovanavith', GETDATE()),
('Entrenamiento Norma ISO 45001:2018', 2, 1, 'Sistema de gestión de seguridad y salud en el trabajo.', 'Jovanavith', GETDATE()),
('Gestión de Sustancias Químicas y Residuos Peligrosos', 2, 1, 'Manejo, clasificación y control ambiental.', 'Jovanavith', GETDATE()),
('Investigación de Accidentes', 2, 1, 'Análisis de incidentes y causa raíz.', 'Jovanavith', GETDATE()),
('Formación en Auditoría Ambiental', 2, 1, 'Evaluación de desempeño ambiental.', 'Jovanavith', GETDATE()),
('Legislación Ambiental', 2, 1, 'Normatividad aplicable y cumplimiento legal.', 'Jovanavith', GETDATE()),
('Desarrollo de Habilidades Gerenciales', 2, 1, 'Liderazgo, comunicación y negociación.', 'Jovanavith', GETDATE()),
('Elaboración de Manuales y Procedimientos', 2, 1, 'Documentación de procesos y políticas.', 'Jovanavith', GETDATE()),
('Inspección Visual de Soldadura', 2, 1, 'Identificación de discontinuidades en soldaduras.', 'Jovanavith', GETDATE());

INSERT INTO Orden (IDCliente, FechaDeOrden, PersonaRegistra, FechaRegistro)
VALUES
(1, GETDATE(), 'Ricardo', GETDATE()),
(2, GETDATE(), 'Ricardo', GETDATE());

INSERT INTO OrderDetails (IDOrden, IDCurso, Precio, Descuento, PersonaRegistra, FechaRegistro)
VALUES
(1, 1,  1500.00, 0.00, 'Ricardo', GETDATE()),
(1, 2,  2400.00, 0.00, 'Ricardo', GETDATE()),
(2, 3,  1800.00, 0.00, 'Ricardo', GETDATE());

INSERT INTO TipoPago (NombreTipo, Descripcion) VALUES
('TarjetaCredito', 'Pago con tarjeta de crédito'),
('TarjetaDebito', 'Pago con tarjeta de débito'),
('Transferencia', 'Paypal');

INSERT INTO Pagos (IDOrderDetail, IDTipoPago, FechaPago, MontoPagado, ReferenciaPago, PersonaRegistra, FechaRegistro)
VALUES
(1, 3, GETDATE(), 1500.00, 'TRX-0001', 'Ricardo', GETDATE()),
(2, 1, GETDATE(), 2400.00, 'CC-1234', 'Ricardo', GETDATE()),
(3, 2, GETDATE(), 3600.00, 'DB-9876', 'Ricardo', GETDATE());

INSERT INTO CursoImpartido (IDCurso, IDEmpleado, FechaInicioCurso, FechaFinCurso, LugarImparticion, TipoLugar, PersonaRegistra, FechaRegistro)
VALUES
(1, 1, DATEADD(day, -30, GETDATE()), DATEADD(day, -28, GETDATE()), 'Sala A - Oficina Central', 'Presencial', 'Ricardo', GETDATE()),
(2, 2, DATEADD(day, -15, GETDATE()), DATEADD(day, -14, GETDATE()), 'Planta B', 'Presencial', 'Ricardo', GETDATE()),
(3, 3, DATEADD(day, 5, GETDATE()), DATEADD(day, 7, GETDATE()), 'Online - Zoom', 'En linea', 'Ricardo', GETDATE());




--EXEC dbo.spInsertClienteOrden 'Jova',NULL,'Tampico','Tampico',NULL,NULL,2,1000,1,'XXX-XXX' 