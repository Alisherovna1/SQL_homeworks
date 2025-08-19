/* 🟢 EASY LEVEL TASKS */

/* 1. BULK INSERT nima? */
-- BULK INSERT - tashqi fayldan katta hajmdagi ma’lumotlarni tezkor import qilish buyrug‘i.

/* 2. Import qilinadigan fayl formatlari */
-- CSV, TXT, Excel (XLS/XLSX), XML, JSON

/* 3. Products jadvalini yaratish */
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,          -- Har bir mahsulot uchun unikal ID
    ProductName VARCHAR(50),            -- Mahsulot nomi
    Price DECIMAL(10,2)                 -- Narx
);

/* 4. Products jadvaliga yozuv qo‘shish */
INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Olma', 5000.00),
(2, 'Banan', 12000.00),
(3, 'Uzum', 8000.00);

/* 5. NULL va NOT NULL farqi */
-- NULL: qiymat yo‘qligini bildiradi.
-- NOT NULL: ustunda albatta qiymat bo‘lishi kerak.

/* 6. UNIQUE constraint qo‘shish */
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

/* 7. SQL queryga izoh */
-- Quyidagi SELECT barcha mahsulotlarni chiqaradi
SELECT * FROM Products;

/* 8. Products jadvaliga CategoryID ustuni qo‘shish */
ALTER TABLE Products
ADD CategoryID INT;

/* 9. Categories jadvalini yaratish */
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,         -- Kategoriya ID
    CategoryName VARCHAR(50) UNIQUE     -- Kategoriya nomi takrorlanmas bo‘lishi kerak
);

/* 10. IDENTITY vazifasi */
-- IDENTITY ustuni avtomatik tartib raqam beradi (masalan: IDENTITY(1,1)).


/* 🟠 MEDIUM LEVEL TASKS */

/* 1. BULK INSERT */
BULK INSERT Products
FROM 'C:\data\products.txt'
WITH (
    FIELDTERMINATOR = ',',              -- Ustunlarni ajratish belgisi
    ROWTERMINATOR = '\n',               -- Qator tugash belgisi
    FIRSTROW = 2                        -- 1-qator sarlavha
);

/* 2. FOREIGN KEY qo‘shish */
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

/* 3. PRIMARY va UNIQUE farqi */
-- PRIMARY KEY: takrorlanmaydi, NULL bo‘lmaydi.
-- UNIQUE KEY: takrorlanmaydi, lekin bitta NULL bo‘lishi mumkin.

/* 4. CHECK constraint (Price > 0) */
ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

/* 5. Stock ustuni qo‘shish */
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

/* 6. ISNULL bilan NULL qiymatlarni almashtirish */
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

/* 7. FOREIGN KEY vazifasi */
-- FOREIGN KEY boshqa jadvaldagi PRIMARY KEY bilan bog‘laydi va ma’lumot yaxlitligini saqlaydi.


/* 🔴 HARD LEVEL TASKS */

/* 1. Customers jadvali (Age >= 18) */
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(50),
    Age INT CHECK (Age >= 18)           -- Yosh 18 dan kichik bo‘lmasligi kerak
);

/* 2. IDENTITY (100 dan boshlanib, 10 ga oshadi) */
CREATE TABLE TestIdentity (
    ID INT IDENTITY(100,10) PRIMARY KEY,
    Value VARCHAR(50)
);

/* 3. OrderDetails jadvali (kompozit PRIMARY KEY) */
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)    -- Birgalikdagi birlamchi kalit
);

/* 4. COALESCE va ISNULL farqi */
-- ISNULL: 1 ta qiymatni almashtiradi (ISNULL(NULL,'Default') → Default).
-- COALESCE: birinchi NULL bo‘lmagan qiymatni qaytaradi (COALESCE(NULL,NULL,'X') → X).

SELECT ISNULL(NULL, 'Default');
SELECT COALESCE(NULL, NULL, 'X');

/* 5. Employees jadvali (PRIMARY KEY va UNIQUE) */
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FullName VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

/* 6. FOREIGN KEY (ON DELETE CASCADE, ON UPDATE CASCADE) */
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    ON DELETE CASCADE                  -- Customer o‘chirilsachi → unga bog‘liq orderlar ham o‘chadi
    ON UPDATE CASCADE                  -- CustomerID o‘zgarsa → Orders jadvalida ham yangilanadi
);
