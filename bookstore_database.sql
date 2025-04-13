CREATE DATABASE bookstore_database;

USE bookstore_database;

-- A list of possibble languages of books.
CREATE TABLE book_language (
	language_id INT PRIMARY KEY,
    language_name VARCHAR(50)
);

-- A list of bublisher for books
CREATE TABLE publisher (
	publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(100)
);

-- books - Shows a list of all books available in the store 
CREATE TABLE books (
	book_id INT PRIMARY KEY,
    title VARCHAR(400),
    language_id INT,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
	isbn VARCHAR(17),
    num_pages INT,
    publication_date DATE,
    publisher_id INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- author: A list of all authors
CREATE TABLE author (
	author_id INT PRIMARY KEY,
    full_name VARCHAR(100)
);

-- book_author - A junction table to manage the many-to-many relationship between books and authors.
-- It references the primary keys of both the books and authors tables.
CREATE TABLE book_author (
	book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGn KEY (author_id) REFERENCES author(author_id)
);

-- Customer: A list of the bookstore's customers
CREATE TABLE customer (
	customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

-- address_status: A list of statuses for an address (e.g., current, old).
CREATE TABLE address_status (
	status_id INT PRIMARY KEY,
    status_name VARCHAR(30)
);

-- country: A list of countries where the addresses are located.
CREATE TABLE country (
	country_id INT PRIMARY KEY,
    country_name VARCHAR(100)
);

-- address: A list of all addresses in the system.
CREATE TABLE address (
	address_id INT PRIMARY KEY,
    street_number VARCHAR(10),
    street_name VARCHAR(200),
    city VARCHAR(100),
    postal_code VARCHAR(10),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- customer_address: A list of addresses for customers. Each customer can have multiple addresses.
CREATE TABLE customer_address (
	address_id INT, 
    status_id INT, 
    customer_id INT,
    PRIMARY KEY (address_id, customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- shipping_method: A list of possible shipping methods for an order.
CREATE TABLE shipping_method (
	method_id INT PRIMARY KEY,
    method_name VARCHAR(100)
);

-- cust_order: A list of orders placed by customers.
CREATE TABLE cust_order (
	customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    order_id INT PRIMARY KEY,
    order_date DATETIME,
    shipping_method_id INT,
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id)
);

-- .order_status: A list of possible statuses for an order (e.g., pending, shipped, delivered).
CREATE TABLE order_status (
	status_id INT PRIMARY KEY,
    status_value VARCHAR(20)
);

-- order_history: A record of the history of an order (e.g., ordered, cancelled, delivered).
CREATE TABLE order_history (
	status_id INT, 
    FOREIGN KEY (status_id) REFERENCES order_status(status_id),
    history_id INT PRIMARY KEY,
    status_date DATETIME,
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id)
);

-- order_line: A list of books that are part of each order
CREATE TABLE order_line (
	order_id INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    line_id INT PRIMARY KEY,
    quantity INT,
    book_id INT,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    price DECIMAL(5, 2)
);

show tables;

INSERT INTO book_language (language_id, language_name) VALUES
(1, 'Language_1'), (2, 'Language_2'), (3, 'Language_3'),
(4, 'Language_4'), (5, 'Language_5'), (6, 'Language_6'),
(7, 'Language_7'), (8, 'Language_8'), (9, 'Language_9'),
(10, 'Language_10');

INSERT INTO publisher (publisher_id, publisher_name) VALUES
(1, 'Publisher_1'), (2, 'Publisher_2'), (3, 'Publisher_3'),
(4, 'Publisher_4'), (5, 'Publisher_5'), (6, 'Publisher_6'),
(7, 'Publisher_7'), (8, 'Publisher_8'), (9, 'Publisher_9'),
(10, 'Publisher_10');

INSERT INTO books (book_id, title, language_id, isbn, num_pages, publication_date, publisher_id) VALUES
(1, 'Title_1', 9, 'ISBN00001', 875, '2020-06-22', 2),
(2, 'Title_2', 5, 'ISBN00002', 169, '2020-10-02', 10),
(3, 'Title_3', 7, 'ISBN00003', 882, '2020-12-06', 7),
(4, 'Title_4', 2, 'ISBN00004', 605, '2020-02-15', 4),
(5, 'Title_5', 6, 'ISBN00005', 532, '2020-07-16', 1),
(6, 'Title_6', 5, 'ISBN00006', 734, '2020-12-15', 7),
(7, 'Title_7', 9, 'ISBN00007', 517, '2020-01-08', 3),
(8, 'Title_8', 5, 'ISBN00008', 562, '2020-12-14', 10),
(9, 'Title_9', 6, 'ISBN00009', 234, '2020-11-21', 1),
(10, 'Title_10', 4, 'ISBN00010', 568, '2020-10-03', 2);

INSERT INTO author (author_id, full_name) VALUES
(1, 'Author One'), (2, 'Author Two'), (3, 'Author Three'),
(4, 'Author Four'), (5, 'Author Five'), (6, 'Author Six'),
(7, 'Author Seven'), (8, 'Author Eight'), (9, 'Author Nine'),
(10, 'Author Ten');

INSERT INTO book_author (book_id, author_id) VALUES
(1, 1), (1, 2), (2, 3), (3, 1), (3, 4),
(4, 5), (5, 6), (6, 7), (7, 8), (8, 9);

INSERT INTO customer (customer_id, first_name, last_name, email) VALUES
(1, 'Alice', 'Smith', 'alice@example.com'),
(2, 'Bob', 'Johnson', 'bob@example.com'),
(3, 'Carol', 'Williams', 'carol@example.com'),
(4, 'David', 'Brown', 'david@example.com'),
(5, 'Eva', 'Jones', 'eva@example.com'),
(6, 'Frank', 'Garcia', 'frank@example.com'),
(7, 'Grace', 'Martinez', 'grace@example.com'),
(8, 'Henry', 'Davis', 'henry@example.com'),
(9, 'Isla', 'Miller', 'isla@example.com'),
(10, 'Jack', 'Wilson', 'jack@example.com');

INSERT INTO address_status (status_id, status_name) VALUES
(1, 'Current'), (2, 'Previous'), (3, 'Shipping'), (4, 'Billing'),
(5, 'Office'), (6, 'Temporary'), (7, 'Home'), (8, 'Secondary'),
(9, 'Old'), (10, 'Primary');

INSERT INTO country (country_id, country_name) VALUES
(1, 'USA'), (2, 'UK'), (3, 'Canada'), (4, 'Germany'), (5, 'France'),
(6, 'Australia'), (7, 'India'), (8, 'Kenya'), (9, 'Brazil'), (10, 'Japan');

INSERT INTO address (address_id, street_number, street_name, city, postal_code, country_id) VALUES
(1, '101', 'Main St', 'New York', '10001', 1),
(2, '202', '2nd Ave', 'London', 'W1A1AA', 2),
(3, '303', 'Queen St', 'Toronto', 'M5H2N2', 3),
(4, '404', 'Hauptstrasse', 'Berlin', '10115', 4),
(5, '505', 'Rue Cler', 'Paris', '75007', 5),
(6, '606', 'George St', 'Sydney', '2000', 6),
(7, '707', 'MG Road', 'Bangalore', '560001', 7),
(8, '808', 'Moi Ave', 'Nairobi', '00100', 8),
(9, '909', 'Av Paulista', 'Sao Paulo', '01310-100', 9),
(10, '111', 'Shibuya St', 'Tokyo', '150-0002', 10);

INSERT INTO customer_address (address_id, status_id, customer_id) VALUES
(1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 1, 4), (5, 2, 5),
(6, 1, 6), (7, 1, 7), (8, 3, 8), (9, 4, 9), (10, 1, 10);

INSERT INTO shipping_method (method_id, method_name) VALUES
(1, 'Standard'), (2, 'Express'), (3, 'Overnight'),
(4, 'Same Day'), (5, 'Pickup'), (6, 'Courier'),
(7, 'Economy'), (8, 'Next-Day'), (9, 'Drone'), (10, 'Sea');

INSERT INTO cust_order (customer_id, order_id, order_date, shipping_method_id) VALUES
(1, 1, '2024-01-01 10:00:00', 1),
(2, 2, '2024-01-02 11:00:00', 2),
(3, 3, '2024-01-03 12:00:00', 3),
(4, 4, '2024-01-04 13:00:00', 4),
(5, 5, '2024-01-05 14:00:00', 5),
(6, 6, '2024-01-06 15:00:00', 6),
(7, 7, '2024-01-07 16:00:00', 7),
(8, 8, '2024-01-08 17:00:00', 8),
(9, 9, '2024-01-09 18:00:00', 9),
(10, 10, '2024-01-10 19:00:00', 10);

INSERT INTO order_status (status_id, status_value) VALUES
(1, 'Pending'), (2, 'Processing'), (3, 'Shipped'), (4, 'Delivered'),
(5, 'Cancelled'), (6, 'Returned'), (7, 'On Hold'), (8, 'Refunded'),
(9, 'Failed'), (10, 'Completed');

INSERT INTO order_history (status_id, history_id, status_date, order_id) VALUES
(1, 1, '2024-01-01 10:00:00', 1),
(2, 2, '2024-01-02 11:00:00', 2),
(3, 3, '2024-01-03 12:00:00', 3),
(4, 4, '2024-01-04 13:00:00', 4),
(5, 5, '2024-01-05 14:00:00', 5),
(6, 6, '2024-01-06 15:00:00', 6),
(7, 7, '2024-01-07 16:00:00', 7),
(8, 8, '2024-01-08 17:00:00', 8),
(9, 9, '2024-01-09 18:00:00', 9),
(10, 10, '2024-01-10 19:00:00', 10);

INSERT INTO order_line (order_id, line_id, quantity, book_id, price) VALUES
(1, 1, 2, 1, 19.99),
(2, 2, 1, 2, 29.99),
(3, 3, 3, 3, 15.50),
(4, 4, 1, 4, 25.75),
(5, 5, 2, 5, 10.00),
(6, 6, 1, 6, 12.99),
(7, 7, 4, 7, 18.49),
(8, 8, 1, 8, 21.00),
(9, 9, 1, 9, 14.90),
(10, 10, 2, 10, 22.25);



-- CREATING USERS AND USER ROLES --
-- CREATING ROLES WITH DIFFERENT PRIVILEDGES --
-- CREATING ROLES --
CREATE ROLE 'admin';
GRANT ALL ON bookstore_database.* TO admin;
CREATE ROLE 'sales_manager';
GRANT SELECT, INSERT, UPDATE ON bookstore_database.* TO sales_manager;
CREATE ROLE 'customerRep';
GRANT SELECT ON bookstore_database.* TO customerRep;
-- CREATING USERS --
CREATE USER 'admin'@'localhost' IDENTIFIED BY '1234';
CREATE USER 'sales'@'localhost' IDENTIFIED BY '4567';
CREATE USER 'costomerRep'@'localhost' IDENTIFIED BY '6789';
--- ASSIGNING ROLES TO USERS --
-- ADMIN USERS --
GRANT 'admin' TO 'Brilliant'@'localhost';
GRANT 'admin' TO 'Manuel'@'localhost';
GRANT 'admin' TO 'Eugene'@'localhost';
-- OTHER USERS --
-- Assign roles to users
GRANT 'admin' TO 'admin'@'localhost';
GRANT 'sales_manager' TO 'sales'@'localhost';
GRANT 'customerRep' TO 'customerRep'@'localhost';
-- DONE --

