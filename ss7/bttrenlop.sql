create database Ss7_db;
use Ss7_db;
-- =======================================================
-- phần 1: ddl - thiết kế và tạo bảng
-- =======================================================

-- xóa bảng theo thứ tự để tránh lỗi khóa ngoại
drop table order_details;
drop table orders;
drop table products;
drop table customers;

-- 1. bảng khách hàng
create table customers (
    id int primary key,
    name varchar(100),
    city varchar(50)
);

-- 2. bảng sản phẩm (thêm cột category_id cho câu nâng cao)
create table products (
    id int primary key,
    name varchar(100),
    price decimal(15, 2),
    category_id int -- 1: điện tử, 2: phụ kiện
);

-- 3. bảng đơn hàng (thêm total_amount để dễ tính toán)
create table orders (
    id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(15, 2),
    foreign key (customer_id) references customers(id)
);

-- 4. bảng chi tiết đơn hàng
create table order_details (
    order_id int,
    product_id int,
    quantity int,
    primary key (order_id, product_id),
    foreign key (order_id) references orders(id),
    foreign key (product_id) references products(id)
);

-- =======================================================
-- phần 2: dml - thêm dữ liệu mẫu
-- =======================================================

-- thêm khách hàng
insert into customers (id, name, city) values
(1, 'nguyễn văn an', 'hà nội'),
(2, 'trần thị bình', 'hồ chí minh'),
(3, 'lê văn cường', 'đà nẵng'),
(4, 'phạm thị dung', 'hà nội');

-- thêm sản phẩm
-- giá trung bình ~ 10.9 triệu
insert into products (id, name, price, category_id) values
(1, 'laptop dell xps', 30000000, 1),   -- giá cao
(2, 'iphone 15', 25000000, 1),         -- giá cao
(3, 'chuột logitech', 500000, 2),      -- giá thấp
(4, 'bàn phím cơ', 1500000, 2),        -- giá thấp
(5, 'tai nghe sony', 3000000, 2);      -- giá thấp

-- thêm đơn hàng (tổng tiền tự tính dựa trên chi tiết để khớp dữ liệu)
insert into orders (id, customer_id, order_date, total_amount) values
(101, 1, '2024-01-01', 30500000), -- ông an mua laptop + chuột
(102, 2, '2024-01-05', 500000),   -- bà bình mua chuột
(103, 3, '2024-01-10', 50000000), -- ông cường mua 2 cái iphone (đại gia)
(104, 1, '2024-01-15', 1500000);  -- ông an mua thêm bàn phím

-- thêm chi tiết đơn hàng
insert into order_details (order_id, product_id, quantity) values
(101, 1, 1), -- đơn 101: 1 laptop
(101, 3, 1), -- đơn 101: 1 chuột
(102, 3, 1), -- đơn 102: 1 chuột
(103, 2, 2), -- đơn 103: 2 iphone
(104, 4, 1); -- đơn 104: 1 bàn phím

-- =======================================================
-- phần 3: giải bài tập (chỉ dùng subquery)
-- =======================================================

-- -------------------------------------------------------
-- câu 1: sản phẩm có giá cao hơn giá trung bình
-- -------------------------------------------------------
select id, name, price
from products
where price > (
    select avg(price) 
    from products
);

-- -------------------------------------------------------
-- câu 2: sản phẩm có số lượng bán trong 1 lần thấp hơn trung bình
-- (trung bình số lượng của các dòng trong order_details)
-- -------------------------------------------------------
select id, name
from products
where id in (
    select product_id
    from order_details
    where quantity < (
        select avg(quantity) 
        from order_details
    )
);

-- -------------------------------------------------------
-- câu 3: khách hàng có tổng chi tiêu cao hơn mức "trung bình đơn hàng"
-- (lưu ý: so sánh tổng tiền khách bỏ ra vs giá trị trung bình 1 đơn hàng)
-- -------------------------------------------------------
select id, name
from customers c
where (
    select sum(total_amount)
    from orders o
    where o.customer_id = c.id
) > (
    select avg(total_amount)
    from orders
);

-- -------------------------------------------------------
-- câu 4: khách hàng "chỉ" mua sản phẩm giá cao
-- (nghĩa là không mua sản phẩm nào giá thấp hơn trung bình)
-- -------------------------------------------------------
select id, name
from customers c
where exists (select 1 from orders o where o.customer_id = c.id) -- phải từng mua hàng
and not exists (
    -- tìm xem có lỡ mua món nào giá rẻ không
    select 1
    from order_details od
    where od.order_id in (select id from orders where customer_id = c.id)
    and od.product_id in (
        select id 
        from products 
        where price <= (select avg(price) from products)
    )
);
-- kết quả mong đợi: lê văn cường (chỉ mua iphone)

-- -------------------------------------------------------
-- câu 5: các đơn hàng có tổng số lượng sản phẩm > trung bình
-- -------------------------------------------------------
-- bước 1: tính tổng sl từng đơn. bước 2: tính trung bình của các tổng đó.
select order_id, sum(quantity) as total_qty
from order_details
group by order_id
having sum(quantity) > (
    select avg(sum_qty)
    from (
        select sum(quantity) as sum_qty 
        from order_details 
        group by order_id
    ) as temp_table
);

-- -------------------------------------------------------
-- câu 6: tìm đơn hàng lớn nhất trong nhóm đơn hàng trên trung bình
-- -------------------------------------------------------
select order_id, sum(quantity) as total_qty
from order_details
group by order_id
having sum(quantity) > (
    select avg(sum_qty)
    from (select sum(quantity) as sum_qty from order_details group by order_id) as temp
)
order by total_qty desc
limit 1;

-- -------------------------------------------------------
-- câu 7 (nâng cao): trong mỗi danh mục, tìm sản phẩm giá cao nhất
-- sử dụng correlated subquery
-- -------------------------------------------------------
select id, name, category_id, price
from products p_outer
where price = (
    select max(price)
    from products p_inner
    where p_inner.category_id = p_outer.category_id
);