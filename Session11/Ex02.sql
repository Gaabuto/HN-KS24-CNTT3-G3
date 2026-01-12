/*
1. Tính tổng like của bài viết
Viết stored procedure CalculatePostLikes nhận vào:

IN p_post_id: mã bài viết
OUT total_likes: tổng số lượt like nhận được trên tất cả bài viết của người dùng đó
*/
DELIMITER $$
create procedure CalculatePostLikes(
	IN p_post_id INT,
    OUT total_likes INT
)
begin
	select count(post_id) 
    into total_likes
    from likes
    where post_id = p_post_id;
end $$
DELIMITER ;

-- 2. Thực hiện gọi stored procedure CalculatePostLikes với một post cụ thể và truy vấn giá trị của tham 
-- số OUT total_likes sau khi thủ tục thực thi.
set @total_likes = 0;
call CalculatePostLikes(103, @total_likes);
select @total_likes as total_likes;

-- 3. Xóa thủ tục vừa mới tạo trên
drop procedure CalculatePostLikes;