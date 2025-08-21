-- 1. Top 5 employees (birinchi 5 nafar xodim)
SELECT TOP 5 *
FROM Employees;

-- 2. Unique Categories from Products (takrorlanmas kategoriyalarni chiqarish)
SELECT DISTINCT Category
FROM Products;

-- 3. Products with Price > 100 (narxi 100 dan katta mahsulotlar)
SELECT *
FROM Products
WHERE Price > 100;

-- 4. Customers whose FirstName starts with 'A' (ismi 'A' bilan boshlanadigan mijozlar)
SELECT *
FROM Customers
WHERE FirstName LIKE 'A%';

-- 5. Order Products by Price ASC (narx bo‘yicha o‘sish tartibida)
SELECT *
FROM Products
ORDER BY Price ASC;

-- 6. Employees with Salary >= 60000 AND Department = HR
-- (maoshi 60000 dan katta yoki teng bo‘lgan va bo‘limi HR bo‘lgan xodimlar)
SELECT *
FROM Employees
WHERE Salary >= 60000
  AND DepartmentName = 'HR';

-- 7. ISNULL: agar Email NULL bo‘lsa, "noemail@example.com" qo‘yiladi
SELECT EmployeeID, FirstName, LastName,
       ISNULL(Email, 'noemail@example.com') AS Email
FROM Employees;

-- 8. Products with Price BETWEEN 50 AND 100 (50 dan 100 gacha bo‘lgan narxdagi mahsulotlar)
SELECT *
FROM Products
WHERE Price BETWEEN 50 AND 100;

-- 9. DISTINCT Category + ProductName (takrorlanmas kategoriya va mahsulot nomlari)
SELECT DISTINCT Category, ProductName
FROM Products;

-- 10. DISTINCT Category + ProductName, natijani ProductName bo‘yicha kamayish tartibida chiqarish
SELECT DISTINCT Category, ProductName
FROM Products

ORDER BY ProductName DESC;

-- 1. Top 10 products by Price DESC (narxi eng qimmat 10 mahsulot)
SELECT TOP 10 *
FROM Products
ORDER BY Price DESC;

-- 2. COALESCE: birinchi NULL bo‘lmagan qiymatni chiqarish (FirstName yoki LastName)
SELECT EmployeeID,
       COALESCE(FirstName, LastName) AS Name
FROM Employees;

-- 3. DISTINCT Category + Price (takrorlanmas kategoriya va narxlar)
SELECT DISTINCT Category, Price
FROM Products;

-- 4. Employees Age between 30 and 40 OR Department = Marketing
-- (yoshi 30-40 orasida bo‘lgan yoki Marketing bo‘limida ishlaydigan xodimlar)
SELECT *
FROM Employees
WHERE (Age BETWEEN 30 AND 40) OR DepartmentName = 'Marketing';

-- 5. OFFSET-FETCH: 11–20-chi xodimlarni chiqarish, Salary kamayish tartibida
SELECT *
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- 6. Products Price <= 1000 AND Stock > 50, sort by Stock ASC
SELECT *
FROM Products
WHERE Price <= 1000 AND StockQuantity > 50
ORDER BY StockQuantity ASC;

-- 7. Products containing letter 'e' in ProductName (nomida 'e' bor mahsulotlar)
SELECT *
FROM Products
WHERE ProductName LIKE '%e%';

-- 8. Employees in HR, IT, Finance (bo‘limi HR, IT yoki Finance bo‘lganlar)
SELECT *
FROM Employees
WHERE DepartmentName IN ('HR', 'IT', 'Finance');

-- 9. Customers ordered by City ASC, PostalCode DESC
SELECT *
FROM Customers
ORDER BY City ASC, PostalCode DESC;

-- 1. Top 5 products with highest SalesAmount
-- (eng ko‘p sotilgan 5 ta mahsulot, umumiy sotuv summasi bo‘yicha)
SELECT TOP 5 p.ProductName, SUM(s.SaleAmount) AS TotalSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC;

-- 2. Combine FirstName + LastName as FullName
-- (ism va familiyani bitta ustunda chiqarish)
SELECT EmployeeID,
       (ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'')) AS FullName,
       DepartmentName, Salary
FROM Employees;

-- 3. DISTINCT Category, ProductName, Price for Price > 50
SELECT DISTINCT Category, ProductName, Price
FROM Products
WHERE Price > 50;

-- 4. Products cheaper than 10% of average price
-- (o‘rtacha narxning 10% dan ham arzon mahsulotlar)
SELECT *
FROM Products
WHERE Price < (SELECT AVG(Price) * 0.1 FROM Products);

-- 5. Employees Age < 30 AND Department HR or IT
SELECT *
FROM Employees
WHERE Age < 30 AND DepartmentName IN ('HR', 'IT');

-- 6. Customers with Email containing '@gmail.com'
SELECT *
FROM Customers
WHERE Email LIKE '%@gmail.com%';

-- 7. Employees whose Salary > ALL salaries in Sales department
-- (Sales bo‘limidagi barcha xodimlarning maoshidan katta bo‘lgan xodimlar)
SELECT *
FROM Employees
WHERE Salary > ALL (
    SELECT Salary FROM Employees WHERE DepartmentName = 'Sales'
);

-- 8. Orders placed in last 180 days
-- (so‘nggi 180 kun ichida berilgan buyurtmalar)
SELECT *
FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();

