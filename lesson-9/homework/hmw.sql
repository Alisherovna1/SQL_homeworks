
   🟢 EASY LEVEL TASKS
 

-- 1. Products × Suppliers (Cartesian product)
SELECT P.ProductName, S.SupplierName
FROM Products P
CROSS JOIN Suppliers S;

-- 2. Departments × Employees (Cartesian product)
SELECT D.DepartmentName, E.Name
FROM Departments D
CROSS JOIN Employees E;

-- 3. Supplier supplies product
SELECT S.SupplierName, P.ProductName
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- 4. Customers and their Orders
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID;

-- 5. Students × Courses
SELECT S.Name AS StudentName, C.CourseName
FROM Students S
CROSS JOIN Courses C;

-- 6. Products and Orders (by ProductID)
SELECT P.ProductName, O.OrderID
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID;

-- 7. Employees with matching Department
SELECT E.Name, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 8. Students and their Enrollments
SELECT S.Name, E.CourseID
FROM Students S
INNER JOIN Enrollments E ON S.StudentID = E.StudentID;

-- 9. Orders with Payments
SELECT O.OrderID, P.PaymentID, P.Amount
FROM Orders O
INNER JOIN Payments P ON O.OrderID = P.OrderID;

-- 10. Orders where product price > 100
SELECT O.OrderID, P.ProductName, P.Price
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID
WHERE P.Price > 100;



   🟡 MEDIUM LEVEL TASKS


-- 1. Employee names with departments where IDs are NOT equal
SELECT E.Name, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID <> D.DepartmentID;

-- 2. Orders where Quantity > Stock
SELECT O.OrderID, P.ProductName, O.Quantity, P.StockQuantity
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID
WHERE O.Quantity > P.StockQuantity;

-- 3. Customers and ProductIDs where SaleAmount >= 500
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, S.ProductID, S.SaleAmount
FROM Sales S
INNER JOIN Customers C ON S.CustomerID = C.CustomerID
WHERE S.SaleAmount >= 500;

-- 4. Students and Courses they’re enrolled in
SELECT S.Name, C.CourseName
FROM Enrollments E
INNER JOIN Students S ON E.StudentID = S.StudentID
INNER JOIN Courses C ON E.CourseID = C.CourseID;

-- 5. Products and Suppliers where Supplier contains "Tech"
SELECT P.ProductName, S.SupplierName
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE S.SupplierName LIKE '%Tech%';

-- 6. Orders where Payment < Total
SELECT O.OrderID, O.TotalAmount, P.Amount
FROM Orders O
INNER JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.Amount < O.TotalAmount;

-- 7. Employees and Department Name
SELECT E.Name, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 8. Products in Electronics or Furniture
SELECT P.ProductName, C.CategoryName
FROM Products P
INNER JOIN Categories C ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics', 'Furniture');

-- 9. Sales from USA Customers
SELECT S.SaleID, C.FirstName + ' ' + C.LastName AS CustomerName, S.SaleAmount
FROM Sales S
INNER JOIN Customers C ON S.CustomerID = C.CustomerID
WHERE C.Country = 'USA';

-- 10. Orders from Germany with Total > 100
SELECT O.OrderID, O.TotalAmount, C.FirstName + ' ' + C.LastName AS CustomerName
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.Country = 'Germany' AND O.TotalAmount > 100;



   🔴 HARD LEVEL TASKS


-- 1. Employee pairs from different departments
SELECT E1.Name AS Employee1, E2.Name AS Employee2
FROM Employees E1
INNER JOIN Employees E2 ON E1.EmployeeID < E2.EmployeeID
WHERE E1.DepartmentID <> E2.DepartmentID;

-- 2. Payments not equal to (Quantity × Price)
SELECT P.PaymentID, P.Amount, O.Quantity, Pr.Price,
       (O.Quantity * Pr.Price) AS ExpectedAmount
FROM Payments P
INNER JOIN Orders O ON P.OrderID = O.OrderID
INNER JOIN Products Pr ON O.ProductID = Pr.ProductID
WHERE P.Amount <> (O.Quantity * Pr.Price);

-- 3. Students not enrolled in any course
SELECT S.Name
FROM Students S
LEFT JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE E.StudentID IS NULL;

-- 4. Managers earning less than/equal to their employee
SELECT M.Name AS ManagerName, E.Name AS EmployeeName, 
       M.Salary AS ManagerSalary, E.Salary AS EmployeeSalary
FROM Employees E
INNER JOIN Employees M ON E.ManagerID = M.EmployeeID
WHERE M.Salary <= E.Salary;

-- 5. Customers with Orders but no Payments
SELECT DISTINCT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.OrderID IS NULL;
