-- 1. Create all table

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    CustomerEmail VARCHAR(100),
    CustomerPhone VARCHAR(20),
    CustomerAddress VARCHAR(255),
    CustomerCity VARCHAR(50),
    CustomerState VARCHAR(50),
    CustomerZip VARCHAR(10)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    Date DATE,
    CustomerID INT,
    ProdNumber VARCHAR(10),
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Product_category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50),
    CategoryAbbreviation VARCHAR(5)
);

CREATE TABLE Products (
    ProdNumber VARCHAR(10) PRIMARY KEY,
    ProdName VARCHAR(255),
    Category INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (Category) REFERENCES Product_category(CategoryID)
);

-- 2. ERD

ALTER TABLE Orders
ADD FOREIGN KEY (ProdNumber) REFERENCES Products(ProdNumber);

ALTER TABLE Products
ADD FOREIGN KEY (Category) REFERENCES Product_category(CategoryID);

-- 3. Create Table Master

select
	b.date as order_date,
	d.CategoryName as category_name,
	c.ProdName as product_name,
	c.Price as product_price,
	b.Quantity as order_qty,
	(b.Quantity*c.Price) as total_sales,
	a.CustomerEmail as cust_email,
	a.CustomerCity as cust_city
from customers a 
join orders b
on a.CustomerID = b.CustomerID
join products c
on b.ProdNumber = c.ProdNumber
join Product_category d
on c.Category = d.CategoryID
order by date;

