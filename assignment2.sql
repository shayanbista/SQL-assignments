
-- Query to create a database 
	create database dbassignment1
-- Query to use the database
	\c lf1
-- Query to create schema
	create schema BookStore
-- Query to create Publisher entity
	create table  BookStore.Publisher(publisher_id SERIAL PRIMARY KEY, publisher_name Varchar(30),country Varchar(30))
-- Query to create Books entity in relation to Publisher
	create table BookStore.Books(book_id SERIAL, title Varchar(30), genre Varchar(20),publication_year INT, publisher_id references Bookstore.Publisher(publisher_id))
-- Query to create Customer entity
 	create table BookStore.Customers(customer_id SERIAL PRIMARY KEY,customer_name VARCHAR(50),email VARCHAR(50),addtess VARCHAR(50))
-- Query to create Orders entity in relation to Customers
	create table BookStore.Orders(order_id SERIAL PRIMARY KEY, order_date TIMESTAMP,total_amount INT, customer_id INT REFERENCES Bookstore.Customers(customer_id))
-- Query to create Author entity
	create table BookStore.Authors(author_id SERIAL PRIMARY KEY, auther_name VARCHAR(50),birth_date DATE, nationality VARCHAR(15))
-- Query to create a many-to-many relation between Orders and Books
	create table BookStore.Order_Items(order_id INT REFERENCES BookStore.Orders(order_id),book_id INT REFERENCES BookStore.Books(book_id),PRIMARY KEY (order_id, book_id))
-- Query to create a many-to-many relation between Authors and Books	
	create table BookStore.Book_Authors(id INT PRIMARY KEY,book_id INT REFERENCES BookStore.Books(book_id),author_id INT REFERENCES Bookstore.Authors(author_id))