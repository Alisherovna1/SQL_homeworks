-- Easy Level
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Olma', 5000.00),
(2, 'Banan', 12000.00),
(3, 'Uzum', 8000.00);

ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

SELECT * FROM Products;

ALTER TABLE Products
ADD CategoryID INT;

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

-- Medium Level
BULK INSERT Products
FROM 'C:\data\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

-- Hard Level
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(50),
    Age INT CHECK (Age >= 18)
);

CREATE TABLE TestIdentity (
    ID INT IDENTITY(100,10) PRIMARY KEY,
    Value VARCHAR(50)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);

SELECT ISNULL(NULL, 'Default');
SELECT COALESCE(NULL, NULL, 'X');

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FullName VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
