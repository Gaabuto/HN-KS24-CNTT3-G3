use social_network_pro;

DELIMITER //

-- 2) tạo stored procedure nhận user_id trả về danh sách bài viết
create procedure sp_getuserposts(p_user_id int)
begin
    select post_id, content, created_at 
    from posts 
    where user_id = p_user_id;
end //

DELIMITER ;

-- 3) gọi lại thủ tục vừa tạo (test với user id = 1)
call sp_getuserposts(1);

-- 4) xóa thủ tục vừa tạo
drop procedure if exists sp_getuserposts;