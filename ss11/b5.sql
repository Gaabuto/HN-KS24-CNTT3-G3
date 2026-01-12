-- bài 5
use social_network_pro;

delimiter //
create procedure CalculateUserActivityScore(
    p_user_id int,
    activity_score int,
    activity_level varchar(50)
)
begin
    declare posts_count int default 0;
    declare comments_count int default 0;
    declare likes_count int default 0;
    -- đếm số bài viết
    select count(*)
    into posts_count from posts
    where user_id = p_user_id;
    -- đếm số bình luận
    select count(*)
    into comments_count from comments
    where user_id = p_user_id;
    -- đếm số lượt like dựa trên các bài viết
    select count(*)
    into likes_count from likes l
    join posts p on p.post_id = l.post_id
    where p.user_id = p_user_id;
    -- tính điểm hoạt động
    set activity_score = posts_count * 10 + comments_count * 5 + likes_count * 3;
    -- xác định mức độ hoạt động
    set activity_level = case
        when activity_score >= 500 then 'Rất tích cực'
        when activity_score between 200 and 499 then 'Tích cực'
        else 'Bình thường'
    end;
end //
delimiter ;
set @score = 0;
set @level = '';
call CalculateUserActivityScore(7, @score, @level);
select @score as activity_score,
       @level as activity_level;
drop procedure if exists CalculateUserActivityScore;

