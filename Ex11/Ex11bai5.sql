use social_network_pro;

DELIMITER //
-- 2) viết procedure tính điểm
create procedure calculateuseractivityscore(
    in p_user_id int,
    out activity_score int,
    out activity_level varchar(50)
)
begin
    -- tính tổng điểm trực tiếp bằng cách cộng các select count lại với nhau
    set activity_score = 
        (select count(post_id) from posts where user_id = p_user_id) * 10 + 
        (select count(comment_id) from comments where user_id = p_user_id) * 5 + 
        (select count(l.user_id) from posts p join likes l on p.post_id = l.post_id where p.user_id = p_user_id) * 3;
    -- phân loại mức độ hoạt động dựa trên tổng điểm vừa tính
    if activity_score > 500 then
        set activity_level = 'rất tích cực';
    elseif activity_score >= 200 then
        set activity_level = 'tích cực';
    else
        set activity_level = 'bình thường';
    end if;
end //

DELIMITER ;

-- 3) gọi thủ tục và xem kết quả
call calculateuseractivityscore(1, @score, @level);

-- hiển thị kết quả
select 
    @score as `Điểm hoạt động`, 
    @level as `Mức độ hoạt động`;

-- 4) xóa thủ tục
drop procedure if exists calculateuseractivityscore;