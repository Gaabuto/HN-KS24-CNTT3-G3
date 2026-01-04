create database customers;
use customers;

create table customers (
    customerId int PRIMARY key,
    fullName varchar(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    city VARCHAR(255),
    status enum('active', 'inactive')
);

INSERT INTO customers(customerId, fullName, email, city, status)
VALUES
    (1, 'Nguyen Van A', 'nguyenvana@gmail.com', 'Ha Noi', 'active'),
    (2, 'Tran Thi B', 'tranthib@gmail.com', 'Ho Chi Minh', 'active'),
    (3, 'Le Van C', 'levanc@gmail.com', 'Da Nang', 'inactive');

SELECT * FROM customers;
SELECT * FROM customers WHERE city = 'Ho Chi Minh';
SELECT * FROM customers WHERE city = 'Ha Noi';
SELECT * FROM customers ORDER BY fullName ASC;