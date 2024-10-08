-- What is the name of the table that holds the items Northwind sells? 
-- Product

use northwind;

-- Write a query to list the product id, product name, and unit price of every product.
SELECT ProductID, ProductName, UnitPrice 
FROM Products;

-- Write a query to list the product id, product name, and unit price of every product.  Except this time, order then in ascending order by price.
SELECT ProductID, ProductName, UnitPrice 
FROM Products
ORDER BY UnitPrice;

-- What are the products that we carry where the unit price is $7.50 or less? 
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice <=7.50;

-- What are the products that we carry where we have at least 100 units on hand? Order them in descending order by price. 
SELECT ProductName, UnitsInStock, UnitPrice
FROM Products
WHERE UnitsInStock >=100
ORDER BY UnitPrice DESC;

-- What are the products that we carry where we have at least 100 units on hand?  Order them in descending order by price.   
-- If two or more have the same price, list those in ascending order by product name.
SELECT ProductName, UnitsInStock, UnitPrice
FROM Products
WHERE UnitsInStock >=100
ORDER BY UnitPrice DESC , ProductName;

-- What are the products that we carry where we have no units on hand, but 1 or more units of them on backorder?  Order them by product name. 
SELECT ProductName, UnitsInStock, UnitsOnOrder
FROM Products
WHERE UnitsInStock = 0 AND UnitsOnOrder >=1
ORDER BY ProductName;

-- What is the name of the table that holds the types (categories) of the items Northwind sells?
-- you have already answered in your question : categories

-- Write a query that lists all of the columns and all of the rows of the categories table?  What is the category id of seafood?
SELECT * 
FROM categories;

SELECT CategoryID, categoryName
FROM categories
WHERE categoryName = 'Seafood';

-- Examine the Products table.  How does it identify the type (category) of each item sold?  Write a query to list all of the seafood items we carry.
SELECT ProductId, ProductName 
FROM Products 
WHERE CategoryID = 8;

-- What are the first and last names of all of the Northwind employees?
SELECT FirstName, LastName
FROM Employees;

-- What employees have "manager" in their titles?
SELECT * 
FROM Employees
WHERE Title Like '%manager%';

-- List the distinct job titles in employees
SELECT  distinct title
FROM Employees;

-- What employees have a salary that is between $2000 and $2500?
SELECT LastName, FirstName, Salary
FROM Employees
WHERE Salary between 2000 and 2500;

-- List all of the information about all of Northwind's suppliers.
SELECT *
FROM Suppliers;

-- Examine the Products table.  How do you know what supplier supplies each product?  
-- Write a query to list all of the items that  "Tokyo Traders" supplies to Northwind

SELECT ProductName FROM Products
WHERE SupplierID = 4;

-- AGGREGATE FUNCTIONS, GROUPS, AND AS RELATED EXERCISE --

-- How many suppliers are there?  Use a query! 
SELECT count(*)
FROM Suppliers;

-- What is the sum of all the employee's salaries? 
SELECT sum(salary) 
FROM Employees;

-- What is the price of the cheapest item that Northwind sells? 
-- SELECT ProductName, UnitPrice
-- FROM Products 
-- WHERE UnitPrice = (
-- SELECT min(UnitPrice)
-- FROM Products);

SELECT min(UnitPrice)
FROM Products;

-- What is the average price of items that Northwind sells? 
SELECT avg(unitPrice)
FROM Products;

-- What is the price of the most expensive item that Northwind sells?
SELECT max(UnitPrice)
FROM Products; 

-- What is the supplier ID of each supplier and the number of items they supply?  
-- You can answer this query by only looking at the Products table.

SELECT SupplierID, count(*)
FROM Products
GROUP BY SupplierID;

-- What is the category ID of each category and the average price of each item in the category?  
-- You can answer this query by only looking at the Products table.
SELECT CategoryID, avg(UnitPrice)
FROM Products
GROUP BY CategoryID;

-- For suppliers that provide at least 5 items to Northwind, what is the supplier ID of each supplier and the number of items they supply?  
-- You can answer this query by only looking at the Products table.

SELECT SupplierID, count(*)
FROM Products
GROUP BY SupplierID
HAVING count(*) >= 5
ORDER BY SupplierID;

-- List the product id, product name, and inventory value (calculated by multiplying unit price by the number of units on hand).  
-- Sort the results in descending order by value.  If two or more have the same value, order by product name.

SELECT ProductID, ProductName, (UnitPrice * UnitsInStock) AS InventoryValue
FROM Products
ORDER BY  InventoryValue DESC, ProductName;

-- NESTED QUERY EXERCISES --

-- What is the product name(s) of the most expensive products?  
-- HINT:  Find the max price in a subquery and then use that value to find products whose price equals that value. 

SELECT ProductName
FROM Products
WHERE UnitPrice = (
	SELECT max(UnitPrice)
    FROM Products);

--  What is the order id, shipping name and shipping address of all orders shipped via "Federal Shipping"?  
-- HINT:  Find the shipper id of "Federal Shipping" in a subquery and then use that value to find the orders that used that shipper.
SELECT OrderID, ShipName, ShipAddress
FROM Orders
WHERE ShipVia = (
	SELECT ShipperID
FROM Shippers
WHERE CompanyName = 'Federal Shipping');

-- What are the order ids of the orders that ordered "Sasquatch Ale"?  
-- HINT: Find the product id of "Sasquatch Ale" in a subquery and then use that value to find the matching orders from the `order details` table.  
-- Because the `order details` table has a space in its name, you will need to surround it with back ticks in the FROM clause.
SELECT OrderID
FROM `Order Details`
WHERE ProductID = (
	SELECT ProductID 
	From Products
	WHERE ProductName = 'Sasquatch Ale');

-- What is the name of the employee that sold order 10266?
SELECT LastName, FirstName 
FROM Employees
WHERE EmployeeID = (
	SELECT EmployeeID FROM Orders
	WHERE OrderID = 10266);

-- What is the name of the customer that bought order 10266?
SELECT CompanyName
FROM Customers
WHERE CustomerID = 
	(
		SELECT CustomerID 
		FROM Orders
		WHERE OrderID = 10266
    );

-- JOINS EXERCISES --
-- List the product id, product name, unit price and category name of all products. Order by category name and within that, by product name. 

SELECT ProductID, ProductName, UnitPrice, CategoryName
FROM Products P
INNER JOIN Categories C 
ON P.CategoryID = C.CategoryID
ORDER BY C.CategoryName, P.ProductName;

-- List the product id, product name, unit price and supplier name of all products that cost more than $75.  Order by product name.
SELECT ProductID, ProductName, UnitPrice, CompanyName
FROM Products Pr
INNER JOIN Suppliers Su
ON Pr.SupplierID = Su.SupplierID
WHERE Pr.UnitPrice > 75;

-- List the product id, product name, unit price, category name, and supplier name of every product.  Order by product name.
SELECT ProductID, ProductName, UnitPrice, CategoryName, CompanyName
FROM Products Pr
INNER JOIN Categories C
ON Pr.CategoryID = C.CategoryID
INNER JOIN Suppliers Su
ON Pr.SupplierID = Su.SupplierID;

-- What is the product name(s) and categories of the most expensive products?  
-- HINT:  Find the max price in a subquery and then use that in your more complex query that joins products with categories.
SELECT ProductName, CategoryName
FROM Products P
INNER JOIN Categories C
ON P.CategoryID = C.CategoryID
WHERE UnitPrice = (
	SELECT max(UnitPrice)
	FROM Products);

-- List the order id, ship name, ship address, and shipping company name of every order that shipped to Germany. 
SELECT OrderId, ShipName, ShipAddress, CompanyName
FROM Orders O
INNER JOIN Shippers S
ON O.ShipVia = S.ShipperID
WHERE ShipCountry = 'Germany';

-- List the order id, order date, ship name, ship address of all orders that ordered "Sasquatch Ale"? 
SELECT O.OrderId, OrderDate, ShipName, ShipAddress
FROM Orders O
INNER JOIN `Order Details` Od
ON O.OrderId = Od.OrderId
INNER JOIN Products P
ON P.ProductID = Od.ProductID
WHERE ProductName = 'Sasquatch Ale';

-- INSERT, UPDATE, DELETE EXERCISES --

--  Add a new supplier.
INSERT INTO Suppliers
VALUES (30,'TATA Enterprises','Chantal Goulet','Accounting Manager','148 rue Chasseur','Ste-Hyacinthe','Delhi','J2S 7S8','India','(022) 555-2900','(514) 555-2921',NULL);

-- Add a new product provided by that supplier 
INSERT INTO Products
VALUES(78, 'Salt', 30, 2, '1 box', 10, 32, 0, 15, 0);

-- List all products and their suppliers. 
SELECT ProductName , CompanyName
FROM Products
INNER JOIN Suppliers 
ON Suppliers.SupplierID = Products.ProductID;

--  Raise the price of your new product by 15%. 
UPDATE Products
SET UnitPrice = round(UnitPrice * 1.15, 2)
WHERE ProductID = 78;

--  List the products and prices of all products from that supplier. 
SELECT ProductName, UnitPrice
FROM Products P
WHERE SupplierID = 30;

--  Delete the new product.
DELETE FROM Products 
WHERE SupplierID = 30;

--  Delete the new supplier. 
DELETE FROM Suppliers 
WHERE SupplierID = 30;

--  List all products.
SELECT ProductName
FROM Products; 
 
--  List all suppliers.
SELECT CompanyName
FROM Suppliers;
 

