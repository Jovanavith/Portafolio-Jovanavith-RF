USE Northwind
--1. Lista los clientes que han hecho más de 15 pedidos (2 pts)
SELECT *
FROM Customers

SELECT *
FROM Orders

SELECT 
    C.CustomerID,
    C.CompanyName AS 'NombreCliente',
    COUNT(O.OrderID) AS 'TotalPedidos'
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName
HAVING COUNT(O.OrderID) > 15
ORDER BY TotalPedidos DESC;

--2. Calcula el total de ingresos por ventas a clientes de México.  (3 pts)
SELECT *
FROM Products
SELECT *
FROM [Order Details]
SELECT *
FROM Customers

SELECT 
    SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS 'TotalIngresosMexico'
FROM [Order Details] OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.Country = 'Mexico';
--Precio redondeado jeje
SELECT 
    ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)), 2) AS 'TotalIngresosMexico'
FROM [Order Details] OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.Country = 'Mexico';

--3. Obtener el nombre y la cantidad de envios compañia que mas envios ha realizado (3 pts)
SELECT *
FROM Shippers
SELECT *
FROM Orders

SELECT TOP 1 
    S.CompanyName AS 'CompañiaEnvios',
    COUNT(O.OrderID) AS 'TotalEnvios'
FROM Orders O
JOIN Shippers S ON O.ShipVia = S.ShipperID
GROUP BY S.CompanyName
ORDER BY TotalEnvios DESC;

--4. Obtener la lista de Territorios por empleado y por region (3 pts)
SELECT *
FROM Employees

SELECT 
    R.RegionDescription AS 'Región',
    T.TerritoryDescription AS 'Territorio',
    CONCAT(E.FirstName, ' ', E.LastName) AS 'Empleado'
FROM Territories T
JOIN Region R ON T.RegionID = R.RegionID
JOIN EmployeeTerritories ET ON T.TerritoryID = ET.TerritoryID
JOIN Employees E ON ET.EmployeeID = E.EmployeeID
ORDER BY Región, Empleado;


--5. Muestra el promedio de precio unitario de los productos por categoría, pero solo para las categorías que tienen al menos 3 productos. (2 pts)
SELECT *
FROM [Order Details]
SELECT *
FROM Orders
SELECT *
FROM Products

SELECT 
    C.CategoryName AS 'Categoría',
    COUNT(P.ProductID) AS 'TotalProductos',
    AVG(P.UnitPrice) AS 'PrecioUnitarioPromedio'
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName
HAVING COUNT(P.ProductID) >= 3
ORDER BY PrecioUnitarioPromedio DESC;

--6. Muestra las categorías que tienen más productos activos que la categoría 'Beverages'. (5 pts)
SELECT *
FROM Categories
SELECT *
FROM Products

SELECT 
    C.CategoryName AS 'Categoría',
    COUNT(P.ProductID) AS 'TotalProductosActivos'
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE P.Discontinued = 0
GROUP BY C.CategoryName
HAVING COUNT(P.ProductID) > (
    SELECT COUNT(P2.ProductID)
    FROM Products P2
    JOIN Categories C2 ON P2.CategoryID = C2.CategoryID
    WHERE P2.Discontinued = 0 AND C2.CategoryName = 'Beverages'
)
ORDER BY TotalProductosActivos DESC;

--7. Mostrar las categorías que tienen más de 15 productos activos. (4 pts)
SELECT *
FROM Categories
SELECT *
FROM Products

SELECT c.CategoryName, COUNT(p.ProductID) AS 'ConteoProductosActivos'
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
WHERE p.Discontinued = 0  
GROUP BY c.CategoryName
HAVING COUNT(p.ProductID) > 15
ORDER BY ConteoProductosActivos DESC; --No hay categorias con más de 15 productos activos al parecer D:

SELECT c.CategoryName, COUNT(p.ProductID) AS 'ConteoProductosActivos'
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
WHERE p.Discontinued = 0
GROUP BY c.CategoryName
ORDER BY ConteoProductosActivos DESC;
--Aqui se puede apreciar que el mayor tiene 13 productos activos


--8. Obtener los 5 clientes que han hecho más pedidos. (3 pts)
SELECT *
FROM Customers
SELECT *
FROM Orders
SELECT *
FROM [Order Details]

SELECT TOP 5 c.CustomerID, c.CompanyName, COUNT(o.OrderID) AS 'NumOrdenes'
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY NumOrdenes DESC;

--9. Obtener los productos descontinuados con su proveedor y categoria que cuesten mas de $20, 
--queden entre 20 y 40 unidades en stock, y esten descontinuadas y que no sean de las categorias Meat/Poultry y Produce (4 pts)
SELECT *
FROM Products
SELECT *
FROM Categories

SELECT p.ProductID, p.ProductName, s.CompanyName AS Supplier, c.CategoryName, p.UnitPrice, p.UnitsInStock
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE p.Discontinued = 1
  AND p.UnitPrice > 20
  AND p.UnitsInStock BETWEEN 20 AND 40
  AND c.CategoryName NOT IN ('Meat/Poultry', 'Produce'); --Parece que tampoco ningun producto descontinuado cumple estas condiciones o.o

--10. Obtén los pedidos realizados por los clientes "DRACD" y "SAVEA" que incluyen productos pertenecientes a la categoría 8. (5 pts)
SELECT *
FROM Customers
SELECT *
FROM Products
SELECT *
FROM Categories

SELECT DISTINCT o.OrderID, o.OrderDate, c.CustomerID, c.CompanyName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE c.CustomerID IN ('DRACD', 'SAVEA')
  AND p.CategoryID = 8;

--11. Muestra los empleados que han gestionado pedidos enviados a más de 5 países distintos.(5 pts)
SELECT *
FROM Employees
SELECT *
FROM Orders

SELECT e.EmployeeID, e.FirstName, e.LastName, COUNT(DISTINCT o.ShipCountry) AS 'ConteoPaises'
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(DISTINCT o.ShipCountry) > 5;

--12. Obtener los productos que han vendido más de 1000 unidades en total y cuantos pedidos se han hecho que contengan esos productos. (5 pts)
SELECT *
FROM Products
SELECT *
FROM Orders

SELECT p.ProductID, p.ProductName, SUM(od.Quantity) AS TotalUnitsSold, COUNT(DISTINCT od.OrderID) AS 'NumOrdenes'
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
HAVING SUM(od.Quantity) > 1000;

--13. Obtén para cada empleado y transportista (shipper) la cantidad total de pedidos que gestionaron en 1997 y el total de unidades vendidas en esos pedidos.(6 pts)
SELECT *
FROM Employees
SELECT *
FROM Shippers
SELECT *
FROM Orders
SELECT *
FROM [Product Sales for 1997]
SELECT *
FROM [Category Sales for 1997]

SELECT e.EmployeeID, e.FirstName, e.LastName,
       s.ShipperID, s.CompanyName AS 'Transportista',
       COUNT(DISTINCT o.OrderID) AS 'OrdenesTotales',
       SUM(od.Quantity) AS 'TotalUnidadesVendidas'
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN Shippers s ON o.ShipVia = s.ShipperID
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY e.EmployeeID, e.FirstName, e.LastName, s.ShipperID, s.CompanyName
ORDER BY e.EmployeeID, s.ShipperID;

--14. Obtén el total de unidades compradas por cada cliente, desglosado por categoría de producto, para los pedidos realizados en 1998.(5 pts)
SELECT *
FROM Customers
SELECT *
FROM Categories
SELECT *
FROM Orders

SELECT c.CustomerID, c.CompanyName, cat.CategoryName, SUM(od.Quantity) AS TotalUnitsPurchased
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE YEAR(o.OrderDate) = 1998
GROUP BY c.CustomerID, c.CompanyName, cat.CategoryName
ORDER BY c.CustomerID, cat.CategoryName;

--15. Diferencia entre Join y Left Join (1 pts)
--Join no acepta nulos
--Left Join acepta nulos

--16. Diferencia entre Having y Where (1 pts)
--Having puede usar funciones de agregados
--Where no puede usar funciones de agregado

--17. En que parte del query podemos usar un subquery? (1 pts)
--Para calcular un valor adicional en cada fila, para filtrar, como tablas derivadas, etc.

--18. Cuando usamos el Group by?(1 pts)
--Agrupa las filas con mismos valores y puede usar funciones de agregado

--19. En un Join solamente podemos hacer la union entre llaves primarias? (1 pts)
--No, puede usar varios tipos de llave

--20.¿Que te llevas de la clase? Da una retroalimentacion para el profesor (1 pts extra)
--La vdd estuvo bien agusto la clase, no crei entenderle en un inicio pero al final con la tarea (Amenaza y toma de rehenes...) de hacer datacamp ayudo bastante a aprender como colocar de manera
--correcta las consultas, espero el siguiente cuatri aprenderle mas a SQL porque esta divertido (sin contar las chilladas porque no dan los querys)

--(Chisme) Ola profe vengo a contarle el chisme de k al sebas chan le gusta la dani chan y como ahora estan muy misteriosamente muy juntos, lit se van solillos a jugar y "estudiar" en llamadas de dc y ni nos pelan luego
--todo comenzo cuando al sebas le empezo a gustar la dani en segundo cuatri y me conto y yo como buena persona decidir juntarlos a la fuerza JAJAJAJAJA 
--no se crea profe no fue tan asi, yo namas movia hilos para que "casualmente" coincidieran en la uni y equipos jeje 
--pero el che sebas nomas no se le quitaba lo chiveado, paso el segundo cuatri entonces el sebas se animo a contarle a los demas y boom que explota todo
--el alan y luis empezaron a invitar a la dani todo el rato a jugar con nosotros para que hablaran mas, hasta hace apenas 3 semanas ni hablabam nada pero
--ahora juegan juntos todo el rato omgggg y nombre luego resulta que sebas se parece a un ex de la dani por lo k mi muchacho tiene oportunidad
--o al menos eso espero porque si anda bien enamorado pero no quiere apurar las cosas y ps ta bien pero k le heche ganas
--Richard le contara el resto del chisme pork el vivio esa parte cuando fue al heb con licha y sofi. Pero nombre luego el sebas y la dani ni parece que disimulan
--luego ahi andan pasando juntos siempre a participar con todos los profes, son la pareja del momento de ISCE

