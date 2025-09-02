
   LESSON 8 PRACTICE - SQL ANSWERS



-- 🟢 EASY LEVEL TASKS


-- 1. Har bir category bo‘yicha productlar soni
SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;

-- 2. Electronics category uchun o‘rtacha narx
SELECT AVG(Price) AS AvgPrice
FROM Products
WHERE Category = 'Electronics';

-- 3. City 'L' harfi bilan boshlanuvchi customerlar
SELECT *
FROM Customers
WHERE City LIKE 'L%';

-- 4. Product nomi 'er' bilan tugaydiganlar
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';

-- 5. Country 'A' bilan tugaydigan customerlar
SELECT *
FROM Customers
WHERE Country LIKE '%A';

-- 6. Eng yuqori narxdagi product
SELECT MAX(Price) AS HighestPrice
FROM Products;

-- 7. StockQuantity bo‘yicha Low Stock / Sufficient belgilash
SELECT ProductName,
       CASE 
         WHEN StockQuantity < 30 THEN 'Low Stock'
         ELSE 'Sufficient'
       END AS StockStatus
FROM Products;

-- 8. Har bir country bo‘yicha customerlar soni
SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;

-- 9. Orders bo‘yicha min va max quantity
SELECT MIN(Quantity) AS MinQuantity,
       MAX(Quantity) AS MaxQuantity
FROM Orders;



-- 🟡 MEDIUM LEVEL TASKS


-- 1. 2023-yanvarda order qilgan, lekin invoice chiqmagan CustomerIDlar
SELECT DISTINCT o.CustomerID
FROM Orders o
WHERE YEAR(o.OrderDate) = 2023 AND MONTH(o.OrderDate) = 1
AND o.CustomerID NOT IN (
    SELECT CustomerID
    FROM Invoices
    WHERE YEAR(InvoiceDate) = 2023 AND MONTH(InvoiceDate) = 1
);

-- 2. Products va Products_Discounted birlashtirish (duplikatlar bilan)
SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;

-- 3. Products va Products_Discounted birlashtirish (duplikatlarsiz)
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 4. Har yil bo‘yicha o‘rtacha order summasi
SELECT YEAR(OrderDate) AS OrderYear, AVG(TotalAmount) AS AvgAmount
FROM Orders
GROUP BY YEAR(OrderDate);

-- 5. Narx bo‘yicha grouping
SELECT ProductName,
       CASE 
         WHEN Price < 100 THEN 'Low'
         WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
         ELSE 'High'
       END AS PriceGroup
FROM Products;

-- 6. City_Population pivot by year
SELECT district_name, [2012], [2013]
INTO Population_Each_Year
FROM (
    SELECT district_name, year, population
    FROM City_Population
) AS src
PIVOT (
    SUM(population) FOR year IN ([2012], [2013])
) AS pvt;

-- 7. Sales bo‘yicha productID kesimida jami savdo
SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;

-- 8. ProductName ichida 'oo' borlari
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';

-- 9. City_Population pivot by city
SELECT year, [Bektemir], [Chilonzor], [Yakkasaroy]
INTO Population_Each_City
FROM (
    SELECT district_name, year, population
    FROM City_Population
) AS src
PIVOT (
    SUM(population) FOR district_name IN ([Bektemir],[Chilonzor],[Yakkasaroy])
) AS pvt;



-- 🔴 HARD LEVEL TASKS


-- 1. Invoice bo‘yicha eng ko‘p xarajat qilgan 3 customer
SELECT TOP 3 CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

-- 2. Population_Each_Year dan original formatga o‘tkazish
SELECT district_name, '2012' AS Year, [2012] AS Population
FROM Population_Each_Year
UNION ALL
SELECT district_name, '2013', [2013]
FROM Population_Each_Year;

-- 3. Products va Sales bo‘yicha product nomi + nechta sotilgan
SELECT p.ProductName, COUNT(s.SaleID) AS TimesSold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName;

-- 4. Population_Each_City dan original formatga o‘tkazish
SELECT 'Bektemir' AS District_Name, year, [Bektemir] AS Population
FROM Population_Each_City
UNION ALL
SELECT 'Chilonzor', year, [Chilonzor]
FROM Population_Each_City
UNION ALL
SELECT 'Yakkasaroy', year, [Yakkasaroy]
FROM Population_Each_City;
