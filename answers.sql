-- Database Design and Normalization Assignment
-- Author: Neo Mokoele
-- Date: April 2025

-- Question 1: Achieving 1NF (First Normal Form)

-- Create a new table in 1NF by splitting Products into individual rows
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Insert normalized data into ProductDetail_1NF
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES 
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Question 2: Achieving 2NF (Second Normal Form)

-- Step 1: Create an Orders table to store OrderID and CustomerName
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create a separate OrderProducts table with full dependency on (OrderID, Product)
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert data into Orders table (no redundancy of CustomerName)
INSERT INTO Orders (OrderID, CustomerName)
VALUES 
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 4: Insert data into OrderProducts table (each row now fully depends on full primary key)
INSERT INTO OrderProducts (OrderID, Product, Quantity)
VALUES 
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Question 3: Achieving 3NF (Third Normal Form)

-- Create a table for Customer details that eliminates transitive dependencies
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100)
);

-- Create a new table for OrderDetails (removes transitive dependency)
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Step 1: Insert data into Customers table
INSERT INTO Customers (CustomerName)
VALUES 
('John Doe'),
('Jane Smith'),
('Emily Clark');

-- Step 2: Link the Orders table with the Customers table using CustomerID
-- Update Orders table to store CustomerID instead of CustomerName
ALTER TABLE Orders ADD COLUMN CustomerID INT;

UPDATE Orders o
JOIN Customers c ON o.CustomerName = c.CustomerName
SET o.CustomerID = c.CustomerID;

-- Drop the redundant CustomerName column in the Orders table
ALTER TABLE Orders DROP COLUMN CustomerName;

-- Step 3: Insert data into OrderDetails table
INSERT INTO OrderDetails (OrderID, CustomerID, Product, Quantity)
VALUES 
(101, 1, 'Laptop', 2),
(101, 1, 'Mouse', 1),
(102, 2, 'Tablet', 3),
(102, 2, 'Keyboard', 1),
(102, 2, 'Mouse', 2),
(103, 3, 'Phone', 1);

-- The database is now in 3NF with no transitive dependencies
