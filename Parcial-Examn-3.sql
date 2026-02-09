--1.- Crea una base de datos para un cafe (2 pts)
CREATE DATABASE CafeDB;
USE CafeDB;

/*2.- Crea una tabla donde se puedan registrar los proveedores, debe tener al menos el nombre del proveedor, 
el contacto (la persona con la que se tiene comunicacion)
,los datos de contacto del proveedor, direccion y tambien interesa saber cuando una persona
hace un registro y edita y quien lo hace (La llave primaria debe ser autoincrementable) (4 pts)*/
CREATE TABLE Proveedores (
    ProveedorID INT IDENTITY(1,1) PRIMARY KEY,
    NombreProveedor NVARCHAR(100) NOT NULL,
    Contacto NVARCHAR(100) NOT NULL,
    DatosContacto NVARCHAR(200),
    Direccion NVARCHAR(200),
    UsuarioRegistro NVARCHAR(50),
    FechaRegistro DATETIME DEFAULT GETDATE(),
    UsuarioEdicion NVARCHAR(50),
    FechaEdicion DATETIME
);

SELECT * 
FROM Proveedores
 
--3.- Crea una tabla donde se puedan registrar las bebidas/platillos del Menu, debe tener el platillo/bebida, el precio, si el producto esta activo o no
--la fecha de registro y usuario de registro
--(la llave primaria debe ser autoincrementable) (3 pts)
CREATE TABLE Menu (
    MenuID INT IDENTITY(1,1) PRIMARY KEY,
    Producto NVARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Activo BIT NOT NULL,
    FechaRegistro DATETIME DEFAULT GETDATE(),
    UsuarioRegistro NVARCHAR(50)
);
SELECT * 
FROM Menu

/*4.- Registra las bebidas/platillos del Menu, "Cafe Americano" con un precio de $50, "Te verde" con un precio de $35 y "Panini Español" con un precio de $80
"Cafe Capuccino" con un precio de $60  (3 pts)*/
INSERT INTO Menu (Producto, Precio, Activo, UsuarioRegistro)
VALUES
('Cafe Americano', 50, 1, 'admin'),
('Te verde', 35, 1, 'admin'),
('Panini Español', 80, 1, 'admin'),
('Cafe Capuccino', 60, 1, 'admin');
SELECT *
FROM Menu

--5.- Borra el registro de "Te verde" y agrega "Te negro" con un precio de $35 (Este registro debe tener el ID 2) (3 pts)
DELETE FROM Menu WHERE Producto = 'Te verde';
SET IDENTITY_INSERT Menu ON;
INSERT INTO Menu (MenuID, Producto, Precio, Activo, UsuarioRegistro)
VALUES (2, 'Te negro', 35, 1, 'admin');
SET IDENTITY_INSERT Menu OFF;

SELECT *
FROM Menu

--6.- Borra todos los registros de la tabla de Menu y que a su vez se reinicie la propiedad de autoincremento (3 pts)
TRUNCATE TABLE Menu;

SELECT * 
FROM Menu

--7.- Borra la tabla de proveedores y Borra la base de datos del cafe (2 pts)
DROP TABLE Proveedores;
USE master;
DROP DATABASE CafeDB;

---------Northwind---------------
Use Northwind

--8.- Te solicitan la lista de empleados que trabajan en Nortwind con su nombre empezado por nombre y luego apellido (2 pts)
SELECT FirstName + ' ' + LastName AS NombreCompleto
FROM Employees;

--9.- Te solicitan revisar si tienes una categoria de producto llamada "Condiments" (2 pts)

SELECT *
FROM Categories
WHERE CategoryName = 'Condiments';

--10.- Te solicitan una lista proveedores que sean de Japon y Estados Unidos (2 pts)
SELECT *
FROM Suppliers
WHERE Country IN ('Japan', 'USA');

--11.- Te solicitan cuantos productos hay por categoria (3 pts)

SELECT c.CategoryName, COUNT(p.ProductID) AS TotalProductos
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;

--12.- Te solicitan cambiar el numero de telefono de "The Big Cheese" a (503) 555-3613 (2 pts)
UPDATE Customers
SET Phone = '(503) 555-3613'
WHERE CompanyName = 'The Big Cheese';


--13. Obtén para cada empleado y transportista (shipper) la cantidad total de pedidos que gestionaron en 1996 
--y el total de unidades vendidas en esos pedidos y el total de la venta en esos pedidos.(7 pts)

SELECT e.FirstName + ' ' + e.LastName AS Empleado,
       s.CompanyName AS Shipper,
       COUNT(DISTINCT o.OrderID) AS TotalPedidos,
       SUM(od.Quantity) AS TotalUnidades,
       SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalVentas
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN Shippers s ON o.ShipVia = s.ShipperID
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1996
GROUP BY e.FirstName, e.LastName, s.CompanyName;


--14.- Te solicitan la lista de Ordenes diferentes que tenga descuento ordenadas por numero de orden de mayor a menor (3 pts)

SELECT DISTINCT 
    o.OrderID,
    p.ProductName,
    od.UnitPrice,
    od.Quantity,
    od.Discount
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE od.Discount > 0
ORDER BY o.OrderID DESC;

--15.- Te solicitan agregar una nuevo cliente llamado "El Datacamp Gourmet" con ID "EDTC", el contacto es Sebastian Lopez y es dueño, no hay direccion 
--y esta en Tampico, México,(3 pts) 
INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle, City, Country)
VALUES ('EDTC', 'El Datacamp Gourmet', 'Sebastian Lopez', 'Dueño', 'Tampico', 'Mexico');


--16. Obtener el nombre y la cantidad de envios compañia que menos envios ha realizado (3 pts)
SELECT TOP 1 s.CompanyName, COUNT(o.OrderID) AS TotalEnvios
FROM Orders o
JOIN Shippers s ON o.ShipVia = s.ShipperID
GROUP BY s.CompanyName
ORDER BY TotalEnvios ASC;


--17. Lista los clientes que han hecho más de 20 pedidos (2 pts)
SELECT 
    c.CustomerID,
    c.CompanyName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
HAVING COUNT(o.OrderID) > 20
ORDER BY TotalOrders DESC;

--18. Calcula el total de ingresos de ventas gestionados por la empresa de paqueteria "Federal Shipping".  (4 pts)

SELECT SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalIngresos
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Shippers s ON o.ShipVia = s.ShipperID
WHERE s.CompanyName = 'Federal Shipping';


--19. Muestra las categorías que tienen menos productos activos que la categoría 'Condiments'. (3 pts)

SELECT 
    c.CategoryName,
    COUNT(p.ProductID) AS ActiveProducts,
    cond.ActiveCondiments
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN (
    SELECT COUNT(ProductID) AS ActiveCondiments
    FROM Products p2
    JOIN Categories c2 ON p2.CategoryID = c2.CategoryID
    WHERE c2.CategoryName = 'Condiments' AND p2.Discontinued = 0
) cond ON 1=1
WHERE p.Discontinued = 0
GROUP BY c.CategoryName, cond.ActiveCondiments
HAVING COUNT(p.ProductID) < cond.ActiveCondiments;

--20. Muestra los empleados que han gestionado pedidos enviados a más de 5 países distintos y el pedido haya sido realizado en 1997 y 1998.(7 pts)

SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    COUNT(DISTINCT o.ShipCountry) AS CountriesCount
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE YEAR(o.OrderDate) IN (1997, 1998)
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(DISTINCT o.ShipCountry) > 5
ORDER BY CountriesCount DESC;

--21. Obtén el total de unidades compradas por cada cliente, desglosado por categoría de producto, para los pedidos realizados en 1997.(7 pts)
SELECT c.CustomerID, cat.CategoryName, SUM(od.Quantity) AS TotalUnidades
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY c.CustomerID, cat.CategoryName;


--22. Obtén los pedidos realizados por los clientes "LAMAI", "VICTE" y "ANTON" que incluyen productos pertenecientes a la categorías de
--Produce y Seafood. (6 pts)
SELECT 
    c.CustomerID,
    c.CompanyName AS NombreCliente,
    cat.CategoryName,
    COUNT(DISTINCT o.OrderID) AS TotalPedidos
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE c.CustomerID IN ('LAMAI', 'VICTE', 'ANTON')
  AND cat.CategoryName IN ('Seafood', 'Produce')
GROUP BY c.CustomerID, c.CompanyName, cat.CategoryName
ORDER BY c.CustomerID, cat.CategoryName;
--23. Obtener los productos activos con su proveedor y categoria que cuesten mas de $35, 
--queden entre 15 y 30 unidades en stock, y que no sean de las categorias Beverages y sean de Proveedores Italianos (6 pts)
SELECT 
    p.ProductName,
    p.UnitPrice,
    p.UnitsInStock,
    s.CompanyName AS Proveedor,
    c.CategoryName AS Categoria
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE p.Discontinued = 0
  AND p.UnitPrice > 35
  AND p.UnitsInStock BETWEEN 15 AND 30
  AND c.CategoryName <> 'Beverages'
  AND s.Country = 'Italy';
--24. Obtener los 10 clientes que han hecho menos pedidos. (2 pts)
SELECT TOP 10 CustomerID, COUNT(OrderID) AS TotalPedidos
FROM Orders
GROUP BY CustomerID
ORDER BY TotalPedidos ASC;


--25. Muestra el promedio de precio unitario de los productos por categoría, pero solo para las categorías que tienen al menos 5 productos activos. (3 pts)
SELECT c.CategoryName, AVG(p.UnitPrice) AS PromedioPrecio
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
WHERE p.Discontinued = 0
GROUP BY c.CategoryName
HAVING COUNT(p.ProductID) >= 5;


--26. Diferencia entre Join y Left Join (2 pts)
-- JOIN: devuelve solo los registros con coincidencias en ambas tablas.
-- LEFT JOIN: devuelve todos los registros de la tabla izquierda aunque no haya coincidencias en la derecha.

--27. Por que es importante usar el Begin tran y Rollback tran y para que lo usamos (3 pts)
--Ayuda a ejecutar un comando sin que este afecte las tablas reales, ayudandonos a dimensionar que tanto se modificara
--y como.

--28. En que parte del query podemos usar un subquery? (2 pts)
--Se pueden usar en SELECT, FROM, WHERE y HAVING.

--29. Cuales son los 4 campos que vimos en clase que se sugieren agregar en las tablas que creamos y por que los agregamos? (4 pts)
-- UsuarioRegistro, FechaRegistro, UsuarioEdicion, FechaEdicion.
-- Sirven para control de cambios

--30. Que significa que un campo de la tabla sea nuleable o no? (2 pts)
-- Nuleable: puede no tener valor (NULL).
-- No nuleable: requiere un valor en cada registro.

