-- bài 2
use social_network_pro;

delimiter //
create procedure CalculatePostLikes(
    post_id_in int,
    total_likes_out int
)
begin
    -- đếm số lượt like của bài viết
    select count(*)
    into total_likes_out
    from likes
    where post_id = post_id_in;
end //
delimiter ;
set @total_likes = 0;   -- biến để nhận kết quả
call CalculatePostLikes(102, @total_likes);
select @total_likes as total_likes;
drop procedure if exists CalculatePostLikes;
