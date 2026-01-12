use social_network_pro;

DELIMITER //

-- 2) viết stored procedure calculatepostlikes tính tổng like của bài viết
create procedure calculatepostlikes(
    in p_post_id int, 
    out total_likes int
)
begin
    -- đếm số dòng trong bảng likes có post_id tương ứng
    select count(user_id) into total_likes 
    from likes 
    where post_id = p_post_id;
end //

DELIMITER ;

-- 3) thực hiện gọi stored procedure và truy vấn giá trị
-- tạo biến @likes để hứng kết quả trả về từ tham số out
call calculatepostlikes(101, @likes); -- giả sử check bài viết id 101
select @likes as total_likes_result;

-- 4) xóa thủ tục vừa mới tạo
drop procedure if exists calculatepostlikes;