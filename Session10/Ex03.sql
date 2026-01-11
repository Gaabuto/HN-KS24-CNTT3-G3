-- 1. Viết câu truy vấn Select tìm tất cả những User ở Hà Nội. Sử dụng EXPLAIN ANALYZE để kiểm tra truy vấn thực tế.
explain analyze
select *
from users
where hometown = 'Hà Nội';

-- 2. Tạo một chỉ mục có tên idx_hometown cho cột hometown của bảng User. 
create index idx_hometown on users(hometown);

/*
	3. Chạy lại yêu cầu số (2) với EXPLAIN ANALYZE để kiểm tra kết quả sau khi đánh 
chỉ mục . So sánh kết quả trước và sau khi đánh chỉ mục.
*/
explain analyze
select *
from users
where hometown = 'Hà Nội'; -- sau khi đánh chỉ mụ thì hiệu năng nhanh hơn

-- 4. Hãy xóa chỉ mục idx_hometown khỏi bảng user.
drop index idx_hometown on users;