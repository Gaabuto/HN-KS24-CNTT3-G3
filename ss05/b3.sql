DROP Table IF EXISTS customers;
drop table if exists orders;
create table customers (
    customerId int PRIMARY key,
    fullName varchar(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    city VARCHAR(255),
    status enum('active', 'inactive')
);

create table orders(
    orderId int primary key,
    customerId int, 
    totalAmount decimal(10,2),
    orderDate date,
    status enum('pending', 'completed', 'cancelled')
);

insert into orders(orderId, customerId, totalAmount, orderDate, status)
values
    (101, 1, 25000000, '2024-01-15', 'completed'),
    (102, 2, 15000000, '2024-02-20', 'pending'),
    (103, 1, 110000, '2024-03-05', 'cancelled'),
    (104, 3, 14000000, '2024-04-10', 'completed'),
    (105, 2, 1500000, '2024-05-12', 'completed'),
    (106, 1, 2000000, '2024-06-18', 'pending'),
    (107, 4, 800000, '2024-07-22', 'completed'),
    (108, 3, 3000000, '2024-08-30', 'cancelled'),
    (109, 2, 600000, '2024-09-14', 'completed'),
    (110, 4, 450000, '2024-10-03', 'pending'),
    (111, 1, 1200000, '2024-11-11', 'completed'),
    (112, 3, 50000000, '2024-12-25', 'completed'),
    (113, 2, 7500000, '2024-12-31', 'pending'),
    (114, 4, 9000000, '2024-11-05', 'completed'),
    (115, 1, 1300000, '2024-10-19', 'cancelled');

select * from orders where status = 'completed';
select * from orders where totalAmount > 5000000;
select * from orders ORDER BY orderDate DESC limit 5;
select * from orders where status = 'completed' ORDER BY totalAmount DESC;