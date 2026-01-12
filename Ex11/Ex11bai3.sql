use social_network_pro;

DELIMITER //

-- 2) viết stored procedure calculatebonuspoints
create procedure calculatebonuspoints(
    in p_user_id int,
    inout p_bonus_points int
)
begin
    declare v_post_count int;
    -- đếm số lượng bài viết của user
    select count(post_id) into v_post_count 
    from posts 
    where user_id = p_user_id;
    -- logic cộng điểm thưởng
    if v_post_count >= 20 then
        -- nếu >= 20 bài thì cộng 100 điểm
        set p_bonus_points = p_bonus_points + 100;
    elseif v_post_count >= 10 then
        -- nếu >= 10 bài thì cộng 50 điểm
        set p_bonus_points = p_bonus_points + 50;
    end if;
end //

DELIMITER ;

-- 3) gọi thủ tục với giá trị khởi tạo ban đầu là 100
set @points = 100; 
-- giả sử test với user_id = 6 (user này có nhiều bài viết trong data mẫu)
call calculatebonuspoints(6, @points);

-- 4) select ra giá trị mới của điểm thưởng
select @points as updated_bonus_points;

-- 5) xóa thủ tục mới khởi tạo
drop procedure if exists calculatebonuspoints;