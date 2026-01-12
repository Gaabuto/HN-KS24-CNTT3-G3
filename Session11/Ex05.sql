/*
	1. Viết procedure tên CalculateUserActivityScore nhận IN p_user_id (INT), trả về OUT activity_score (INT). Điểm được 
tính: mỗi post +10 điểm, mỗi comment +5 điểm, mỗi like nhận được +3 điểm. Sử dụng CASE hoặc IF để phân loại mức hoạt 
động (ví dụ: >500 “Rất tích cực”, 200-500 “Tích cực”, <200 “Bình thường”) và trả thêm OUT activity_level (VARCHAR(50)).
*/
DELIMITER $$
create procedure CalculateUserActivityScore(
	IN p_user_id INT,
    OUT activity_score INT,
    OUT return_message VARCHAR(100)
)
begin
	declare total_posts INT;
    declare total_comments INT;
    declare total_likes INT;
    
    -- Đếm bài viết
    select count(post_id)
    into total_posts
    from posts
    where user_id = p_user_id;
    
    -- Đếm comments
    select count(comment_id)
    into total_comments
    from comments
    where user_id = p_user_id;
    
    -- Đếm likes
    select count(l.like_id)
    into total_likes
    from likes as l join posts as p on l.post_id = p.post_id
    where p.user_id = p_user_id;
    
    -- Tổng điểm
    set activity_score = total_posts * 10 + total_comments * 5 + total_likes * 3;
    
    -- So sánh
    IF activity_score > 500 then
		set return_message = 'Rất tích cực';
	elseif activity_score > 200 then
		set return_message = 'Tích cực';
	else	
		set return_message = 'Bình thường';
    END IF;
end $$
DELIMITER ;

-- 2. Gọi thủ tục trên select ra activity_score và activity_level
set @score = 0;
set @levels = 0;
call CalculateUserActivityScore(1, @score, @levels);
select @score as activity_score, @levels as activity_level;

-- 3. Xóa thủ tục vừa khởi tạo trên
drop procedure CalculateUserActivityScore;