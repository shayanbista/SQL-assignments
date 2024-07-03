-- Create a new database named 'first'
CREATE DATABASE first;

-- Connect to the 'first' database
\c first;

-- Create a new schema named 'Items'
CREATE SCHEMA Items;

-- Create a table 'Products' within the 'Items' schema
CREATE TABLE Items.Products (
    product_id SERIAL PRIMARY KEY,  
    product_name VARCHAR(50),       
    Category VARCHAR(50),           
    price INT                      
);

-- Create a table 'Orders' within the 'Items' schema
CREATE TABLE Items.Orders (
    order_id SERIAL PRIMARY KEY,        
    customer_name VARCHAR(100),          
    product_id INT REFERENCES Items.Products(product_id),  
    quantity INT,                        
    order_date TIMESTAMP                 
);

-- Insert sample data into 'Items.Products'
	INSERT INTO Items.Products (product_name, Category, price) VALUES
	('Laptop', 'Electronics', 1200),
	('Headphones', 'Electronics', 150),
	('Coffee Maker', 'Home Appliances', 80),
	('Book', 'Books', 20),
	('Office Chair', 'Furniture', 200);

-- Insert sample data into 'Items.Orders'
INSERT INTO Items.Orders (customer_name, product_id, quantity, order_date) VALUES
	('Ram', 1, 2, '2024-07-01 10:30:00'),
	('Hari', 2, 1, '2024-07-02 14:45:00'),
	('Chanfra', 3, 3, '2024-07-03 09:00:00'),
	('Mandra', 4, 5, '2024-07-03 11:15:00'),
	('Meow', 5, 1, '2024-07-04 16:20:00');

-- Update the category of the product with product_id = 1 to 'hardware'
	UPDATE Items.Products SET category = 'hardware' WHERE product_id = 1;

-- Delete the product with product_id = 5 from the 'Products' table
	DELETE FROM Items.Products WHERE product_id = 5;

-- Select the total quantity ordered for each product category
	SELECT p.category, SUM(o.quantity) AS total_quantity
	FROM Items.Orders o
	JOIN Items.Products p ON o.product_id = p.product_id
	GROUP BY p.category;

-- Select the product categories with total quantities ordered greater than 5
	SELECT p.category
	FROM Items.Orders o
	JOIN Items.Products p ON o.product_id = p.product_id
	GROUP BY p.category
	HAVING SUM(o.quantity) > 5;



