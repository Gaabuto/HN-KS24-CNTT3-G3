/*
1) Sử dụng lại database social_network_pro để thực hành

2)Tạo một index có tên idx_user_gender trên cột gender của bảng users:

3) Tạo một view tên view_user_activity để hiển thị tổng số lượng bài viết và bình luận của mỗi người dùng. Các cột trong view bao 
gồm: user_id (Mã người dùng), total_posts (Tổng số bài viết), total_comments (Tổng số bình luận).

4) Hiển thị lại view trên. 

5) Viết truy vấn kết hợp view_user_activity với bảng users để lấy thông tin người dùng:

- Điều kiện: total_posts > 5 và total_comments > 20.

- Sắp xếp theo total_comments (Tổng số bình luận) giảm dần.

- Giới hạn kết quả hiển thị 5 bản ghi đầu tiên.
*/
create index idx_user_gender on users(gender); -- 2

create or replace view view_user_activity -- 3
as
select u.user_id, count(p.post_id) as total_posts, count(c.comment_id) as total_comments
from users as u join posts as p on u.user_id = p.user_id
					join comments as c on u.user_id = c.user_id
group by u.user_id;

SELECT * FROM social_network_pro.view_user_activity; -- 4

select v.user_id, u.full_name, total_posts, total_comments -- 5
from view_user_activity as v join users as u on v.user_id = u.user_id
where total_posts > 5 and total_comments > 20
order by total_comments desc
limit 5;
	