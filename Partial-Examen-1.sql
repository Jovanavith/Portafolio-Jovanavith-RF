--1.- Crea una base de datos para una libreria (1 pts)
CREATE DATABASE Libreria
USE Libreria





--2.- Crea una tabla donde se puedan registrar los libros, debe tener al menos el titulo del libro, el autor, la editorial y tambien interesa saber cuando una persona
-- hace un registro y edita y quien lo hace (La llave primaria debe ser autoincrementable) (3 pts)
CREATE TABLE Libros(
IdLibro INT PRIMARY KEY NOT NULL IDENTITY (1,1),
NombreLibro VARCHAR(150) NOT NULL,
AutorLibro VARcHAR(150) NOT NULL,
Editorial VARCHAR (150) NOT NULL,
FechaRegistro DATETIME NOT NULL,
NombreRegistro VARCHAR (100) NOT NULL,
EdicionRegistro VARCHAR (100) NOT NULL,
) 
SELECT * FROM Libros


--3.- Crea una tabla donde se puedan registrar generos de los libros, debe tener el nombre del genero y la fecha de registro
--(la llave primaria debe ser autoincrementable) (3 pts)
CREATE TABLE Generos (
IdGenero INT PRIMARY KEY NOT NULL IDENTITY (1,1),
NombreGenero VARCHAR (100) NOT NULL,
FechaRegistro DATETIME NOT NULL
)
SELECT * FROM Generos
INSERT INTO Generos	VALUES ('Comedia', GETDATE())
INSERT INTO Generos VALUES ('Terror', GETDATE())
INSERT INTO Generos VALUES ('Drama', GETDATE())
INSERT INTO Generos VALUES ('Sci-Fi', GETDATE())
INSERT INTO Generos VALUES ('Suspenso', GETDATE())
INSERT INTO Generos VALUES ('Accion', GETDATE())
INSERT INTO Generos VALUES ('Romance', GETDATE())







--4.- Registra el Libro "El Alquimista" de Paulo Coelho de la Editorial "Editoria Planeta", El libro "El Gato que amaba los libros" de Sosuke Natsukawa de la Editorial
-- "Grijalbo" y "La Biblioteca de la Medianoche" de Matt Haig de la editorial "Alianza de Novela" (3 pts)
INSERT INTO Libros VALUES ('El Alquimista', 'Paulo Coelho', 'Editoria Planeta', GETDATE(), 'Jova Felix', 'Jova Felix')
INSERT INTO Libros VALUES ('El Gato que amaba los libros', 'Sosuke Natsukawa', 'Grijalbo', GETDATE(), 'Jova Felix', 'Jova Felix')
INSERT INTO Libros VALUES ('La Biblioteca de la Medianoche', 'Matt Haig', 'Alianza de Novela', GETDATE(), 'Jova Felix', 'Jova Felix')
SELECT * FROM Libros






--5.- Borra el libro de la Biblioteca de la Medianoche e inserta libro "Dialogos" de Platon de la Editorial Gredos (Este registro debe tener el ID 3) (3 pts)
TRUNCATE TABLE Libros
INSERT INTO Libros VALUES ('El Alquimista', 'Paulo Coelho', 'Editoria Planeta', GETDATE(), 'Jova Felix', 'Jova Felix')
INSERT INTO Libros VALUES ('El Gato que amaba los libros', 'Sosuke Natsukawa', 'Grijalbo', GETDATE(), 'Jova Felix', 'Jova Felix')
INSERT INTO Libros VALUES ('Dialogos', 'Platon', 'Editorial Gredos', GETDATE(), 'Jova Felix', 'Jova Felix')
SELECT * FROM Libros

--6.- Borra todos los registros de la tabla de Generos y que a su vez se reinicie la propiedad de autoincremento (3 pts)
TRUNCATE TABLE Libros
SELECT * FROM Libros




--7.- Borra la tabla de Libros y Borra la base de datos de la libreria (2 pts)
DROP TABLE Libros
USE master
DROP DATABASE Libreria
USE Libreria --Y ya no existe yeeeh :D

---------Northwind---------------


--8.- Te solicitan la lista de empleados que trabajan en Nortwind (2 pts)
USE Northwind
SELECT * FROM Employees


--9.- Te solicitan revisar si tienes una categoria de producto llamada "Vegetables" (2 pts)
SELECT * 
FROM [Products by Category]
WHERE CategoryName LIKE '%VEGETABLES%';
--No tiene Vegetables


--10.- Te solicitan una lista proveedores que sean de Londres y Tokyo (2 pts)
SELECT *
FROM Suppliers
WHERE City IN ('Londres', 'Tokyo');

--11.- Te solicitan cuantos territorios hay por region (5 pts)
SELECT ShipCountry, ShipCity,*
FROM Orders o
ORDER BY o.ShipCountry, o.ShipCity;

--12.- Te solicitan cambiar el Codigo Postal de "Die Wandernde Kuh" a 89526 (2 pts)
SELECT *
From Customers
WHERE CompanyName LIKE 'Die Wandernde Kuh'
UPDATE Customers SET PostalCode = '89526' WHERE CompanyName = 'Die Wandernde Kuh'
SELECT *
From Customers

--13.- Te solicitan cuantas ordenes hay por transportista(Compañia que envia) y ordenado de mayor a menor cantidad de ordenes (5 pts)
SELECT 
    Shippers.CompanyName AS Transportista,
    COUNT(Orders.OrderID) AS CantidadOrdenes
FROM 
    Orders
JOIN 
    Shippers ON Orders.ShipVia = Shippers.ShipperID
GROUP BY 
    Shippers.CompanyName
ORDER BY 
    CantidadOrdenes DESC;



--14.- Te solicitan la lista de Ordenes diferentes que tenga descuento (5 pts)
SELECT DISTINCT OrderID
FROM [Order Details]
WHERE Discount > 0;



--15.- Te solicitan agregar una nueva region llamada "Central" (3 pts)
SELECT *
From Region
INSERT INTO Region (RegionID, RegionDescription)
VALUES (5, 'Central');




--16.- Te solicitan una lista de empleados ordenados por edad que tenga sus datos de contacto y su direccion (4 pts)
SELECT FirstName, LastName, Title, BirthDate,Address,City, Region, PostalCode, Country, HomePhone, Extension 
FROM Employees
ORDER BY BirthDate ASC;
SELECT * FROM Employees



--17.- Agregar un empleado que se llame Abraham Johnson y sea Representante de ventas, nacio el 20/04/1997 ( no tenemos mas datos) (2 pts)
INSERT INTO Employees (LastName,FirstName,Title,BirthDate,HireDate,Address,City,Region,PostalCode,Country,HomePhone,Extension,Notes,ReportsTo)
VALUES ('Johnson','Abraham','Sales Representative','1997-04-20',GETDATE(),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);


--18.- Te solicitan el total de ordenes (2 pts)
SELECT COUNT(*) AS Total_Ordenes
FROM Orders


--19.- Te solicitan la lista de ordenes que sean Venezuela y Brasil (3 pts)
SELECT *
FROM Orders
WHERE ShipCountry IN('Venezuela', 'Brasil');


--20.- Lista de productos que tengan menos productos en Stock y solo los 3 con menos stock y que sean de las categorias (2,4,5) y del proveedor (1,2,3,4) (5 pts)
SELECT TOP 3 
ProductID,ProductName,UnitsInStock,CategoryID,SupplierID
FROM Products
WHERE CategoryID IN (2, 4, 5)
  AND SupplierID IN (1, 2, 3, 4)
ORDER BY UnitsInStock ASC;







