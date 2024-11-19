/*Utiliza la tabla Production.Product para crear una consulta que muestre los nombres de los productos y los ID’s 
de productos que hayan sido ordenados. Utiliza una subconsulta para filtrar los productos ordenados en la tabla 
Sales.SalesOrderDetail. Ordena el resultado por nombre de manera ascendente.*/

SELECT p.Name,
       p.ProductID
FROM Production.Product p
WHERE p.ProductID IN (SELECT sod.ProductID
                       FROM sales.SalesOrderDetail sod)
ORDER BY Name

/*2.Utiliza las tablas HumanResources.Employee, HumanResources.EmployeeDepartmentHistory, HumanResources.Department 
y Person.Person para crear una consulta que muestre un listado de todos los empleados y el nombre de su departamento actual. 
Los campos a mostrar serán: BusinessEntityID, FirstName + ' ' + LastName como Nombre del Empleado, y Name como Nombre 
del Departamento.*/

SELECT e.BusinessEntityID,
       p.FirstName +' '+ p.LastName AS NombreDelEmpleado,
	   hrd.Name AS NombreDelDEpartamento
FROM HumanResources.Employee e
INNER JOIN Person.Person p
     ON e.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory edh
     ON e.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Department hrd 
     ON edh.DepartmentID = hrd.DepartmentID
ORDER BY BusinessEntityID 

/*3.Utiliza las tablas HumanResources.Employee, HumanResources.EmployeeDepartmentHistory y HumanResources.Department
para crear una consulta que muestre el mismo resultado que en el ejercicio 2, pero utilizando un CTE. 
Los campos a mostrar serán: BusinessEntityID, FirstName + ' ' + LastName como Nombre del Empleado, 
y Name como Nombre del Departamento.*/
	
WITH EmployeeDep AS (
SELECT e.BusinessEntityID,
       p.FirstName +' '+ p.LastName AS NombreDelEmpleado,
	   hrd.Name AS NombreDelDEpartamento
FROM HumanResources.Employee e
INNER JOIN Person.Person p
     ON e.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory edh
     ON e.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Department hrd 
     ON edh.DepartmentID = hrd.DepartmentID
)
SELECT BusinessEntityID, 
       NombreDelEmpleado,
	   NombreDelDEpartamento
FROM EmployeeDep
ORDER BY BusinessEntityID

/*4.Crea una tabla temporal local y otra global para almacenar los productos ordenados. 
Utiliza la tabla Production.Product para insertar los datos en ambas tablas temporales. 
Los campos a incluir serán: ProductID y Name. Inserta los datos en la tabla temporal local.*/

CREATE TABLE #TempLocal(
ProductID INT,
Name Varchar(255)
);

CREATE TABLE ##TempGlobal(
ProductID INT,
Name VARCHAR (255)
);

-- Insertar datos en tabla temporal local
INSERT INTO #TempLocal(ProductID, Name)
SELECT ProductID,
       Name
FROM #TempLocal

-- Insertar datos en tabla temporal Global

INSERT INTO ##TempGlobal(ProductID, Name)

SELECT ProductID,
       Name
FROM ##TempGlobal

/*5.Utiliza la tabla Sales.SalesOrderHeader para crear una consulta que muestre 
los números de orden y números de compra solo para el año 2011.*/

SELECT SalesOrderNumber,
       PurchaseOrderNumber
FROM SALES.SalesOrderHeader
WHERE OrderDate >= 2011

/*6.Utiliza la tabla Sales.SalesOrderHeader para crear una consulta que muestre 
los números de orden y números de compra sin los 2 primeros caracteres y nombra los campos resultantes 
como NewSalesOrderNumber y NewPurchaseOrderNumber.*/

SELECT SUBSTRING(SalesOrderNumber, 3, LEN(SalesOrderNumber)) AS NewSalesOrderNumber,
       SUBSTRING(PurchaseOrderNumber, 3, LEN(PurchaseOrderNumber)) AS NewPurchaseOrderNumber
FROM SALES.SalesOrderHeader;