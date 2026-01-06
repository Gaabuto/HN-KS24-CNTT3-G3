create database ss7;
use ss7;





-- bai 1




create table customers(
customer_id varchar(255) primary key ,
customer_name varchar(255) not null,
email varchar(255) not null unique
);

create table orders(
order_id varchar(255),
customer_id varchar(255),
order_date date not null,
total_amount decimal(10,2) not null,
foreign key (customer_id) references customers(customer_id),
primary key(order_id, customer_id)
);

insert into customers (customer_id, customer_name, email) values
('c001', 'nguyen van an', 'an@gmail.com'),
('c002', 'tran thi binh', 'binh@gmail.com'),
('c003', 'le van cuong', 'cuong@gmail.com'),
('c004', 'pham thi dao', 'dao@gmail.com'),
('c005', 'hoang van em', 'em@gmail.com'),
('c006', 'vo thi giang', 'giang@gmail.com'),
('c007', 'dang van hung', 'hung@gmail.com');

insert into orders (order_id, customer_id, order_date, total_amount) values
('o001', 'c001', '2025-01-01', 150000.00),
('o002', 'c001', '2025-01-05', 320000.50),
('o003', 'c002', '2025-01-03', 210000.00),
('o004', 'c003', '2025-01-10', 450000.75),
('o005', 'c004', '2025-01-12', 98000.00),
('o006', 'c005', '2025-01-15', 670000.00),
('o007', 'c006', '2025-01-20', 125000.25);

select customer_name
from customers
where customer_id in (
    select customer_id
    from orders
);


-- bai 2

create table products (
    id int primary key,
    name varchar(100) not null,
    price decimal(10,2) not null
);

create table order_items (
    order_id int,
    product_id int,
    quantity int not null,
    primary key (order_id, product_id),
    foreign key (product_id) references products(id)
);

insert into products (id, name, price) values
(1, 'laptop dell', 15000000.00),
(2, 'chuot logitech', 350000.00),
(3, 'ban phim co', 1200000.00),
(4, 'man hinh samsung', 4200000.00),
(5, 'tai nghe sony', 1800000.00);

insert into order_items (order_id, product_id, quantity) values
(101, 1, 1),
(101, 2, 2),
(102, 3, 1),
(102, 5, 1),
(103, 2, 1),
(103, 4, 2);


select name as 'sold item'
from products 
where id in 
	(select product_id 
	from order_items);

-- bai 3

insert into orders (order_id, customer_id, order_date, total_amount) values
('o008', 'c001', '2025-02-01', 200000.00),
('o009', 'c002', '2025-02-03', 350000.50),
('o010', 'c003', '2025-02-05', 125000.00),
('o011', 'c004', '2025-02-07', 890000.00),
('o012', 'c005', '2025-02-10', 410000.75);


select order_id, total_amount
from orders
where total_amount > 
	(select avg(total_amount)
	from orders);
    
    
-- bai 4

insert into customers (customer_id, customer_name, email) values
('c008', 'pham thi khanh', 'khanh@gmail.com'),
('c009', 'le van long', 'long@gmail.com'),
('c010', 'tran thi mai', 'mai@gmail.com');

insert into orders (order_id, customer_id, order_date, total_amount) values
('o013', 'c004', '2025-02-07', 920000.00),
('o014', 'c005', '2025-02-10', 410000.75),
('o015', 'c006', '2025-02-12', 300000.00);

select customer_name, ( select count(order_id) from orders where ( orders.customer_id = customers.customer_id))
from customers;

-- bai 5

select customer_name
from customers
where customer_id in (
    select customer_id
    from orders
    group by customer_id
    having sum(total_amount) = 
		(select max(total_spent)
        from (
            select sum(total_amount) as total_spent
            from orders
            group by customer_id
        ) as t
    )
);

    
    
    -- bai 6
    
    select customer_name 
    from customers
    where customer_id in
		(select customer_id
        from orders
        group by customer_id
        having sum(total_amount) >
        (select avg(total_spent)
        from (
			 select sum(total_amount) as total_spent
            from orders
            group by customer_id
		) as t
	)
);
    