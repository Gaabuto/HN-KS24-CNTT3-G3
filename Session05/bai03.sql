create database bai03;
use bai03; 
create table Orders(
order_id int,
customer_id int,
total_amount decimal(10,2),
order_date date,
status enum ('pending','completed','cancelled')
);
-- Lấy danh sách đơn hàng đã hoàn thành
select * from Orders where status = 'completed' ;
-- Lấy các đơn hàng có tổng tiền > 5.000.000
select * from Orders where total_amount > 5000000;
-- Hiển thị 5 đơn hàng mới nhất
SELECT * FROM Orders ORDER BY order_date DESC LIMIT 5;
-- Hiển thị các đơn hàng đã hoàn thành, sắp xếp theo tổng tiền giảm dần
SELECT * FROM Orders WHERE status = 'completed' ORDER BY total_amount DESC;