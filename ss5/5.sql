create database ss5;
use ss5;


-- bai 1
create table products(
product_id int primary key auto_increment,
product_name varchar(255) not null,
price decimal(10,2) not null,
stock int not null,
status enum('active','inactive') not null
);

select * from products;
select * from products where status = 'active';
select * from products where price > 1000000;
select * from products where stock > 0 order by price asc;


-- bai 2

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    city VARCHAR(255),
    status ENUM('active', 'inactive') DEFAULT 'active'
);

select * from customers;
select * from customers where city in ('HCM',  'Ho Chi Minh');
select * from customers order by full_name asc;

-- bai 3

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    status ENUM('pending', 'completed', 'cancelled') DEFAULT 'pending',

	foreign key (customer_id) references customers(customer_id)
);

select * from orders where status ='completed';
select * from orders where total_amount > 5000000;
select * from orders order by order_id desc limit 5;
select * from orders where status ='completed' order by total_amount desc;

-- bai 4

alter table products
add column sold_quantity int not null;
select * from products order by sold_quantity desc limit 10;
select * from products order by sold_quantity desc limit 5 offset 10;
select * from products where price < 2000000 order by price desc;


-- bai 5

select * from orders where status <> 'cancelled' order by order_id desc limit 5 offset 0 ;
select * from orders where status <> 'cancelled' order by order_id desc limit 5 offset 5;
select * from orders where status <> 'cancelled' order by order_id desc limit 5 offset 10;


-- bai 6

select * from products where status = active and price between 1000000 and 3000000 order by price asc limit 10;
select * from products where status = active and price between 1000000 and 3000000 order by price asc limit 10 offset 10;

