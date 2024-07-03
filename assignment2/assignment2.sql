-- Query to create a database 
	create database db_assignment1

-- Query to use the database
	\c db_assignment1

-- Query to create schema
	create schema BookStore

-- Query to create Publisher entity
	CREATE TABLE BookStore.Publisher (
    	publisher_id SERIAL PRIMARY KEY,
    	publisher_name VARCHAR(100),
   	 country VARCHAR(50)
	)

-- Query to create Books entity in relation to Publisher
	CREATE TABLE BookStore.Books (
    	book_id SERIAL PRIMARY KEY,
    	title VARCHAR(30),
    	genre VARCHAR(20),
    	publication_year INT,
    	publisher_id INT REFERENCES BookStore.Publisher(publisher_id)
	)

-- Query to create Customer entity
   	CREATE TABLE BookStore.Customers (
    	customer_id SERIAL PRIMARY KEY,
    	customer_name VARCHAR(100),
    	email VARCHAR(254),
    	address VARCHAR(100)
	)

-- Query to create Orders entity in relation to Customers
    	CREATE TABLE BookStore.Orders (
    	order_id SERIAL PRIMARY KEY,
    	order_date TIMESTAMP,
    	total_amount INT,
    	customer_id INT REFERENCES BookStore.Customers(customer_id)
	)

-- Query to create Author entity
   	CREATE TABLE BookStore.Authors (
    	author_id SERIAL PRIMARY KEY,
    	author_name VARCHAR(100),
    	birth_date DATE,
    	nationality VARCHAR(50)
	)

-- Query to create a many-to-many relation between Orders and Books
	CREATE TABLE BookStore.Order_Items (
   	order_id INT REFERENCES BookStore.Orders(order_id),
    	book_id INT REFERENCES BookStore.Books(book_id),
    	PRIMARY KEY (order_id, book_id)
	)

-- Query to create a many-to-many relation between Authors and Books	
	CREATE TABLE BookStore.Book_Authors (
    	id INT PRIMARY KEY,
    	book_id INT REFERENCES BookStore.Books(book_id),
    	author_id INT REFERENCES BookStore.Authors(author_id)
	)
