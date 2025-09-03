
-- 🟢 EASY LEVEL TASKS --


-- 1. Employees with salary > 50000 and their department names
SELECT E.Name AS EmployeeName, E.Salary, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE E.Salary > 50000;

-- 2. Customers and orders placed in 2023
SELECT C.FirstName, C.LastName, O.OrderDate
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE YEAR(O.OrderDate) = 2023;

-- 3. All employees and their departments (include employees with no dept)
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 4. All suppliers and products they supply (include suppliers with no products)
SELECT S.SupplierName, P.ProductName
FROM Suppliers S
LEFT JOIN Products P ON S.SupplierID = P.SupplierID;

-- 5. All orders and payments (include unmatched from both sides)
SELECT O.OrderID, O.OrderDate, P.PaymentDate, P.Amount
FROM Orders O
FULL OUTER JOIN Payments P ON O.OrderID = P.OrderID;

-- 6. Employee name with their manager name
SELECT E.Name AS EmployeeName, M.Name AS ManagerName
FROM Employees E
LEFT JOIN Employees M ON E.ManagerID = M.EmployeeID;

-- 7. Students enrolled in 'Math 101'
SELECT S.Name AS StudentName, C.CourseName
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
JOIN Courses C ON E.CourseID = C.CourseID
WHERE C.CourseName = 'Math 101';

-- 8. Customers who ordered more than 3 items
SELECT C.FirstName, C.LastName, O.Quantity
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.Quantity > 3;

-- 9. Employees in 'Human Resources' department
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Human Resources';



-- 🟠 MEDIUM LEVEL TASKS --


-- 1. Departments with more than 5 employees
SELECT D.DepartmentName, COUNT(E.EmployeeID) AS EmployeeCount
FROM Departments D
JOIN Employees E ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentName
HAVING COUNT(E.EmployeeID) > 5;

-- 2. Products never sold
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Sales S ON P.ProductID = S.ProductID
WHERE S.SaleID IS NULL;

-- 3. Customers who placed at least one order
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName;

-- 4. Employees with departments (no NULLs)
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 5. Pairs of employees with same manager
SELECT E1.Name AS Employee1, E2.Name AS Employee2, E1.ManagerID
FROM Employees E1
JOIN Employees E2 ON E1.ManagerID = E2.ManagerID
WHERE E1.EmployeeID < E2.EmployeeID;

-- 6. Orders in 2022 with customer name
SELECT O.OrderID, O.OrderDate, C.FirstName, C.LastName
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) = 2022;

-- 7. Sales dept employees with salary > 60000
SELECT E.Name AS EmployeeName, E.Salary, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sales' AND E.Salary > 60000;

-- 8. Orders that have payments
SELECT O.OrderID, O.OrderDate, P.PaymentDate, P.Amount
FROM Orders O
JOIN Payments P ON O.OrderID = P.OrderID;

-- 9. Products never ordered
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Orders O ON P.ProductID = O.ProductID
WHERE O.OrderID IS NULL;



-- 🔴 HARD LEVEL TASKS --


-- 1. Employees with salary > avg salary in their dept
SELECT E.Name AS EmployeeName, E.Salary
FROM Employees E
JOIN (
    SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
) A ON E.DepartmentID = A.DepartmentID
WHERE E.Salary > A.AvgSalary;

-- 2. Orders before 2020 with no payments
SELECT O.OrderID, O.OrderDate
FROM Orders O
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE O.OrderDate < '2020-01-01' AND P.OrderID IS NULL;

-- 3. Products without a matching category
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Categories C ON P.Category = C.CategoryID
WHERE C.CategoryID IS NULL;

-- 4. Employees with same manager and salary > 60000
SELECT E1.Name AS Employee1, E2.Name AS Employee2, E1.ManagerID, E1.Salary
FROM Employees E1
JOIN Employees E2 ON E1.ManagerID = E2.ManagerID
WHERE E1.EmployeeID < E2.EmployeeID AND E1.Salary > 60000 AND E2.Salary > 60000;

-- 5. Employees in departments starting with 'M'
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName LIKE 'M%';

-- 6. Sales with amount > 500 including product names
SELECT S.SaleID, P.ProductName, S.SaleAmount
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
WHERE S.SaleAmount > 500;

-- 7. Students not enrolled in 'Math 101'
SELECT S.StudentID, S.Name AS StudentName
FROM Students S
WHERE S.StudentID NOT IN (
    SELECT E.StudentID
    FROM Enrollments E
    JOIN Courses C ON E.CourseID = C.CourseID
    WHERE C.CourseName = 'Math 101'
);

-- 8. Orders missing payment details
SELECT O.OrderID, O.OrderDate, P.PaymentID
FROM Orders O
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL;

-- 9. Products in Electronics or Furniture categories
SELECT P.ProductID, P.ProductName, C.CategoryName
FROM Products P
JOIN Categories C ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics', 'Furniture');
