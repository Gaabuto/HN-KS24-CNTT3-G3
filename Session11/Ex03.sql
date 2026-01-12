/*
1. Viết stored procedure tên CalculateBonusPoints nhận hai tham số:

p_user_id (INT, IN) – ID của user
p_bonus_points (INT, INOUT) – Điểm thưởng ban đầu (khi gọi procedure, bạn truyền vào một giá trị điểm khởi đầu, ví dụ 100).
Trong procedure:
Đếm số lượng bài viết (posts) của user đó.
Nếu số bài viết ≥ 10, cộng thêm 50 điểm vào p_bonus_points.
Nếu số bài viết ≥ 20, cộng thêm tổng cộng 100 điểm (thay vì chỉ 50).
Cuối cùng, tham số p_bonus_points sẽ được sửa đổi và trả ra giá trị mới.
*/
DELIMITER $$
create procedure CalculateBonusPoints(
	IN p_user_id INT,
    INOUT p_bonus_point INT
)
begin
	declare total_posts int;
    
    select count(post_id)
    into total_posts
    from posts
    where user_id = p_user_id;
    
    IF total_posts >= 20 then 
		set p_bonus_point = p_bonus_point + 100;
	elseif total_posts >= 10 then
		set p_bonus_point = p_bonus_point + 50;
	else
		set p_bonus_point = p_bonus_point;
    END IF;
end $$
DELIMITER ;

-- 2. Gọi thủ tục trên với giá trị id user và p_bonus_points bất kì mà bạn muốn cập nhật
set @bonus_point = 100;
call CalculateBonusPoints(2, @bonus_point);

-- 3. Select ra p_bonus_points 
select @bonus_point;
-- 4. Xóa thủ tục mới khởi tạo trên 
drop procedure CalculateBonusPoints;