-- bài 1
use social_network_pro;
delimiter //
create procedure show_posts_user (
	in p_user_id int
)
begin
    -- Sắp xếp theo thời gian tạo giảm dần
    select 
        post_id,
        content,
        created_at
    from posts
    where user_id = p_user_id
    order by created_at desc;
end //
delimiter ;
-- Gọi thủ tục để lấy bài viết
call show_posts_user(7);
drop procedure if exists show_posts_user