-- Step 1: Create the main Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Insert Order and Customer data
INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 3: Create the Product table to store unique products per order
CREATE TABLE Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100)
);

-- Step 4: Insert product names (no duplicates)
INSERT INTO Product (ProductName)
VALUES
('Laptop'),
('Mouse'),
('Tablet'),
('Keyboard'),
('Phone');

-- Step 5: Create a linking table between Orders and Products with Quantity
CREATE TABLE OrderProduct (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Step 6: Map the orders to their products with quantities
-- Assuming ProductID mapping: Laptop=1, Mouse=2, Tablet=3, Keyboard=4, Phone=5
INSERT INTO OrderProduct (OrderID, ProductID, Quantity)
VALUES
(101, 1, 2),  -- John Doe - Laptop
(101, 2, 1),  -- John Doe - Mouse
(102, 3, 3),  -- Jane Smith - Tablet
(102, 4, 1),  -- Jane Smith - Keyboard
(102, 2, 2),  -- Jane Smith - Mouse
(103, 5, 1);  -- Emily Clark - Phone
