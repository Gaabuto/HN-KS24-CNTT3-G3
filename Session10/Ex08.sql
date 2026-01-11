-- 1. Tạo một index idx_user_gender trên cột gender của bảng users.
create index idx_user_gender on users(gender);

/*
	2. Tạo một View tên view_popular_posts để lưu trữ post_id, username người đăng,content(Nội dung bài viết), số like, số 
comment (sử dụng JOIN giữa posts, users, likes, comments; GROUP BY post_id).
*/
create or replace view view_popular_posts 
as
select p.post_id, u.full_name, p.content, count(l.user_id) as total_likes, count(c.user_id) as total_comments
from posts as p join users as u on p.user_id = u.user_id
					join likes as l on p.post_id = l.post_id
						join comments as c on p.post_id = c.post_id
group by p.post_id, u.full_name, p.content;

-- 3. Truy vấn các thông tin của view view_popular_posts 
SELECT * FROM social_network_pro.view_popular_posts;

-- 4. viết query sử dụng View này để liệt kê các bài viết có số like + comment > 10, ORDER BY tổng tương tác giảm dần.
select *,
		(total_likes + total_comments) as total_likes_comments
from view_popular_posts
where total_likes + total_comments > 10
order by total_likes_comments desc;