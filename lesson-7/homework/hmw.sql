
   Lesson 7 Homework Tasks
   Aggregate Functions, GROUP BY, HAVING
  
--EASY LEVEL (10) 

-- Task 1: Minimum product price
SELECT MIN(Price) AS MinPrice
FROM Products;

-- Task 2: Maximum salary
SELECT MAX(Salary) AS MaxSalary
FROM Employees;

-- Task 3: Count customers
SELECT COUNT(*) AS TotalCustomers
FROM Customers;

-- Task 4: Count unique product categories
SELECT COUNT(DISTINCT Category) AS UniqueCategories
FROM Products;

-- Task 5: Total sales amount for product id = 7
SELECT SUM(SaleAmount) AS TotalSales
FROM Sales
WHERE ProductID = 7;

-- Task 6: Average employee age
SELECT AVG(Age) AS AvgAge
FROM Employees;

-- Task 7: Employee count per department
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

-- Task 8: Min & Max product price per category
SELECT Category, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

-- Task 9: Total sales per customer
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

-- Task 10: Departments with more than 5 employees
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;


-- MEDIUM LEVEL (9) 

-- Task 1: Total & average sales per product category
SELECT p.Category, SUM(s.SaleAmount) AS TotalSales, AVG(s.SaleAmount) AS AvgSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category;

-- Task 2: Count employees in HR department
SELECT COUNT(*) AS HREmployees
FROM Employees
WHERE DepartmentName = 'HR';

-- Task 3: Highest & lowest salary by department
SELECT DepartmentName, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DepartmentName;

-- Task 4: Average salary per department
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName;

-- Task 5: Avg salary & employee count per department
SELECT DepartmentName, AVG(Salary) AS AvgSalary, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

-- Task 6: Product categories with avg price > 400
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

-- Task 7: Total sales per year
SELECT YEAR(SaleDate) AS SaleYear, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate);

-- Task 8: Customers with at least 3 orders
SELECT CustomerID, COUNT(*) AS OrdersCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

-- Task 9: Departments with avg salary > 60000
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000;


 --HARD LEVEL (6)
-- Task 1: Avg price per category > 150
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

-- Task 2: Total sales per customer > 1500
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

-- Task 3: Total & avg salary per department > 65000
SELECT DepartmentName, SUM(Salary) AS TotalSalary, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;

-- Task 4: Orders with Freight > 50 (TSQL2012 db example)
SELECT CustomerID, SUM(Freight) AS TotalFreight, MIN(Freight) AS LeastPurchase
FROM TSQL2012.Sales.Orders
WHERE Freight > 50
GROUP BY CustomerID;

-- Task 5: Total sales & unique products sold per month/year (>=2 products)
SELECT YEAR(OrderDate) AS SaleYear, MONTH(OrderDate) AS SaleMonth,
       SUM(TotalAmount) AS TotalSales,
       COUNT(DISTINCT ProductID) AS UniqueProducts
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2;

-- Task 6: Min & Max order quantity per year
SELECT YEAR(OrderDate) AS OrderYear,
       MIN(Quantity) AS MinQuantity,
       MAX(Quantity) AS MaxQuantity
FROM Orders
GROUP BY YEAR(OrderDate);






