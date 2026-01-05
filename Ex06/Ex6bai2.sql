use ss06;

create table customers (
    customer_id int primary key auto_increment,
    full_name varchar(255),
    city varchar(255)
);

create table orders (
    order_id int primary key auto_increment,
    customer_id int,
    order_date date,
    status enum('pending', 'completed', 'cancelled'),
    total_amount decimal(10,2),
    foreign key (customer_id) references customers(customer_id)
);

insert into customers (full_name, city) values
('Nguyễn Văn A', 'Hà Nội'),
('Trần Thị B', 'Hải Phòng'),
('Lê Văn C', 'Đà Nẵng'),
('Phạm Thị D', 'Cần Thơ'),
('Hoàng Văn E', 'TP HCM');

insert into orders (customer_id, order_date, status, total_amount) values
(1, '2024-08-01', 'completed', 1500.00),
(1, '2024-08-05', 'pending', 800.00),
(2, '2024-08-03', 'completed', 1200.00),
(3, '2024-08-06', 'cancelled', 500.00),
(3, '2024-08-08', 'completed', 2000.00);

-- hiển thị tổng tiền mà mỗi khách hàng đã chi tiêu
select c.customer_id,c.full_name,sum(o.total_amount)
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

-- hiển thị giá trị đơn hàng cao nhất của từng khách
select c.customer_id,c.full_name,max(o.total_amount)
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

-- sắp xếp danh sách khách hàng theo tổng tiền giảm dần
select c.customer_id,c.full_name,sum(o.total_amount)
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name order by tong_tien desc;
