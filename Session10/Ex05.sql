-- 1. Tạo chỉ mục có tên idx_hometown trên cột hometown của bảng users
create index idx_hometown on users(hometown);
/*
	2. Thực hiện truy vấn với các yêu cầu sau:

Viết một câu truy vấn để tìm tất cả các người dùng (users) có hometown là "Hà Nội"
Kết hợp với bảng posts để hiển thị thêm post_id và content về các lần đăng bài. 
Sắp xếp danh sách theo username giảm dần và giới hạn kết quả chỉ hiển thị 10 bài đăng đầu tiên.
*/
EXPLAIN ANALYZE
select u.full_name, u.hometown, p.post_id, p.content
from users as u join posts as p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
order by u.full_name desc
limit 10;
-- 3. Sử dụng EXPLAIN ANALYZE để kiểm tra lại kế hoạch thực thi trước và sau khi có chỉ mục.
create index idx_hometown on users(hometown);

EXPLAIN ANALYZE
select u.full_name, u.hometown, p.post_id, p.content
from users as u join posts as p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
order by u.full_name desc
limit 10;

-- Số bản ghi cần xử lý giảm mạnh từ 296 -> 94,7 avf thời gian thực tế giảm từ 0.35 -> 0.26