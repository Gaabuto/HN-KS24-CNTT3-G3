/*
	1. Tạo một view tên view_users_summary để thống kê số lượng bài viết của từng người 
    dùng.user_id (Mã người dùng), username (Tên người dùng), total_posts (Tổng số lượng bài viết của người dùng)
*/
create or replace view view_users_summary 
as
select u.user_id, u.full_name, count(p.post_id) as total_posts
from users as u join posts as p on u.user_id = p.user_id
group by u.user_id, u.full_name;
/*
	2. Truy vấn từ view_users_summary để hiển thị các thông tin về user_id, username và total_posts của các người 
    dùng có total_posts lớn hơn 5.
*/
create or replace view view_users_summary 
as
select u.user_id, u.full_name, count(p.post_id) as total_posts
from users as u join posts as p on u.user_id = p.user_id
group by u.user_id, u.full_name
having total_posts > 5;
SELECT * FROM social_network_pro.view_users_summary;