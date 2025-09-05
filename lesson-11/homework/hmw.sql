
-- LESSON 11 HOMEWORK TASKS SOLUTIONS (SQL Server)


-
-- 🟢 EASY LEVEL TASKS (7)


-- 1. Show all orders placed after 2022 along with the names of the customers who placed them.
SELECT 
    O.OrderID,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    O.OrderDate
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) > 2022;


-- 2. Display the names of employees who work in either the Sales or Marketing department.
SELECT 
    E.Name AS EmployeeName,
    D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName IN ('Sales', 'Marketing');


-- 3. Show the highest salary for each department.
SELECT 
    D.DepartmentName,
    MAX(E.Salary) AS MaxSalary
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName;


-- 4. List all customers from the USA who placed orders in the year 2023.
SELECT 
    C.FirstName + ' ' + C.LastName AS CustomerName,
    O.OrderID,
    O.OrderDate
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE C.Country = 'USA' 
  AND YEAR(O.OrderDate) = 2023;


-- 5. Show how many orders each customer has placed.
SELECT 
    C.FirstName + ' ' + C.LastName AS CustomerName,
    COUNT(O.OrderID) AS TotalOrders
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName;


-- 6. Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
SELECT 
    P.ProductName,
    S.SupplierName
FROM Products P
JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE S.SupplierName IN ('Gadget Supplies', 'Clothing Mart');


-- 7. For each customer, show their most recent order. Include customers who haven't placed any orders.
SELECT 
    C.FirstName + ' ' + C.LastName AS CustomerName,
    MAX(O.OrderDate) AS MostRecentOrderDate
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName;



-- 🟡 MEDIUM LEVEL TASKS (6)


-- 8. List all employees along with the names of their managers (self-join).
SELECT 
    E.Name AS EmployeeName,
    M.Name AS ManagerName
FROM Employees E
LEFT JOIN Employees M ON E.ManagerID = M.EmployeeID;


-- 9. Show the total sales amount for each customer.
SELECT 
    C.FirstName + ' ' + C.LastName AS CustomerName,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalSales
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY C.FirstName, C.LastName;


-- 10. Display the average salary of employees in each department, only for departments with more than 2 employees.
SELECT 
    D.DepartmentName,
    AVG(E.Salary) AS AvgSalary
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName
HAVING COUNT(E.EmployeeID) > 2;


-- 11. Find the top 3 customers who placed the highest number of orders.
SELECT TOP 3
    C.FirstName + ' ' + C.LastName AS CustomerName,
    COUNT(O.OrderID) AS TotalOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName
ORDER BY COUNT(O.OrderID) DESC;


-- 12. Show the products that have never been ordered.
SELECT 
    P.ProductName
FROM Products P
LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
WHERE OD.ProductID IS NULL;


-- 13. List all employees who earn more than the average salary of their department.
SELECT 
    E.Name AS EmployeeName,
    D.DepartmentName,
    E.Salary
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE E.Salary > (
    SELECT AVG(E2.Salary)
    FROM Employees E2
    WHERE E2.DepartmentID = E.DepartmentID
);


-- 🔴 HARD LEVEL TASKS (4)


-- 14. Find customers who have placed orders for products supplied by more than one supplier.
SELECT 
    C.FirstName + ' ' + C.LastName AS CustomerName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Suppliers S ON P.SupplierID = S.SupplierID
GROUP BY C.FirstName, C.LastName
HAVING COUNT(DISTINCT S.SupplierID) > 1;


-- 15. Show the second highest salary among all employees.
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employees
WHERE Salary < (SELECT MAX(Salary) FROM Employees);


-- 16. Find the departments where all employees earn more than 40000.
SELECT 
    D.DepartmentName
FROM Departments D
JOIN Employees E ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentName
HAVING MIN(E.Salary) > 40000;


-- 17. List the products that were ordered in every order (if any).
SELECT 
    P.ProductName
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName
HAVING COUNT(DISTINCT OD.OrderID) = (SELECT COUNT(*) FROM Orders);
