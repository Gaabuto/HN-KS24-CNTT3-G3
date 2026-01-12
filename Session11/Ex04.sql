/*
	1. Viết procedure tên CreatePostWithValidation nhận IN p_user_id (INT), IN p_content (TEXT). Nếu độ dài content < 5 ký tự thì không 
thêm bài viết và SET một biến thông báo lỗi (có thể dùng OUT result_message VARCHAR(255) để trả về thông 
báo “Nội dung quá ngắn” hoặc “Thêm bài viết thành công”).
*/
DELIMITER $$
create procedure CreatePostWithValidation(
	IN p_user_id INT,
    IN p_content TEXT,
    OUT result_message VARCHAR(255)
)
begin
	IF CHAR_LENGTH(p_content) < 5 then
		set result_message = 'Nội dung quá ngắn';
	else
		insert into posts(user_id, content, created_at)
        values(p_user_id, p_content, NOW());
        
        set result_message = 'Thêm bài viết thành công';
    END IF;
end $$
DELIMITER ;

-- 2. Gọi thủ tục và thử insert các trường hợp --> 3. Kiểm tra các kết quả
-- Trường hợp Thêm bài viết thành công
set @message = '';
call CreatePostWithValidation(1, 'Xin chào', @message);
select @message;

-- Trường hợp Nội dung quá ngắn
set @message = '';
call CreatePostWithValidation(1, 'aaa', @message);
select @message;


-- 4. Xóa thủ tục vừa khởi tạo trên
drop procedure CreatePostWithValidation;