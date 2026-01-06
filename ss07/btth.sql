/* ====================================================
    dự án ecommerce 
   ==================================================== */

-- 1. ddl: tạo database và bảng
create database ss7_db;
use ss7_db;

drop table if exists chi_tiet_don_hang;
drop table if exists don_hang;
drop table if exists san_pham;
drop table if exists khach_hang;

create table khach_hang (
    customer_id int primary key,
    customer_name varchar(100),
    city varchar(50)
);

create table san_pham (
    product_id int primary key,
    product_name varchar(100),
    category varchar(50),
    price decimal(12,2)
);

create table don_hang (
    order_id int primary key,
    customer_id int,
    order_date date,
    foreign key (customer_id) references khach_hang(customer_id)
);

create table chi_tiet_don_hang (
    order_id int,
    product_id int,
    quantity int,
    primary key (order_id, product_id),
    foreign key (order_id) references don_hang(order_id),
    foreign key (product_id) references san_pham(product_id)
);

-- 2. dml: thêm dữ liệu mẫu
insert into khach_hang values
(1, 'nguyen van a', 'ha noi'), (2, 'tran thi b', 'da nang'),
(3, 'le van c', 'hcm'), (4, 'pham thi d', 'ha noi'), (5, 'hoang van e', 'can tho');

insert into san_pham values
(101, 'laptop dell', 'electronics', 20000000),
(102, 'iphone 14', 'electronics', 25000000),
(103, 'tai nghe bluetooth', 'accessories', 1500000),
(104, 'ban phim co', 'accessories', 2000000),
(105, 'man hinh 27 inch', 'electronics', 7000000),
(106, 'chuot khong day', 'accessories', 800000);

insert into don_hang values
(1001, 1, '2024-01-10'), (1002, 2, '2024-01-12'), (1003, 1, '2024-01-15'),
(1004, 3, '2024-01-18'), (1005, 4, '2024-01-20'), (1006, 5, '2024-01-22');

insert into chi_tiet_don_hang values
(1001, 101, 1), (1001, 103, 2), (1002, 102, 1), (1003, 104, 1),
(1003, 103, 1), (1004, 101, 1), (1004, 106, 2), (1005, 105, 1),
(1006, 103, 3), (1006, 106, 1);

/* ====================================================
   phần 3: giải 8 câu bài tập 
   ==================================================== */

-- câu 1: xác định các sản phẩm có giá cao hơn mặt bằng chung
select product_id, product_name, price
from san_pham
where price > (select avg(price) from san_pham);

-- câu 2: tìm sản phẩm có số lượng bán (trong 1 đơn) thấp hơn mức trung bình
select product_id, product_name
from san_pham
where product_id in (
    select product_id
    from chi_tiet_don_hang
    where quantity < (select avg(quantity) from chi_tiet_don_hang)
);

-- câu 3: khách hàng có tổng số đơn hàng cao hơn mức trung bình
select customer_id, customer_name
from khach_hang c
where (select count(*) from don_hang where customer_id = c.customer_id) > (
    select count() * 1.0 / (select count() from khach_hang) from don_hang
);

-- câu 4 : tính giá của sản phẩm có giá cao hơn giá trung bình
select product_name, price
from san_pham
where price > (
    select avg(price)
    from san_pham
);

-- câu 5: các đơn hàng có tổng số lượng sản phẩm lớn hơn mức trung bình
select order_id, sum(quantity) as total_qty
from chi_tiet_don_hang
group by order_id
having sum(quantity) > (
    select avg(sum_qty)
    from (select sum(quantity) as sum_qty from chi_tiet_don_hang group by order_id) as t
);

-- câu 6 : tìm đơn hàng có doanh thu lớn nhất

select order_id, 
       sum(quantity * (select price from san_pham where san_pham.product_id = chi_tiet_don_hang.product_id)) as total_revenue
from chi_tiet_don_hang
group by order_id
having total_revenue > (
    -- bước 2: tính trung bình doanh thu của tất cả đơn hàng
    select avg(revenue)
    from (
        -- bước 1: tính tổng doanh thu cho từng đơn hàng
        select sum(quantity * (select price from san_pham where san_pham.product_id = ct.product_id)) as revenue
        from chi_tiet_don_hang ct
        group by order_id
    ) as avg_table
)
order by total_revenue desc
limit 1;

-- câu 7: trong mỗi danh mục, xác định sản phẩm giá cao nhất
select product_name, category, price
from san_pham
where (category, price) in (
    select category, max(price)
    from san_pham
    group by category
);

-- câu 8: ví dụ về subquery nhiều cấp (tìm khách mua đồ điện tử)
select customer_name
from khach_hang
where customer_id in (
    select customer_id
    from don_hang
    where order_id in (
        select order_id
        from chi_tiet_don_hang
        where product_id in (
            select product_id from san_pham where category = 'electronics'
        )
    )
);
