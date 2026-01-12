use social_network_pro;

DELIMITER //

-- 2) viết procedure tên createpostwithvalidation
create procedure createpostwithvalidation(
    in p_user_id int,
    in p_content text,
    out result_message varchar(255)
)
begin
    -- kiểm tra độ dài nội dung dùng char_length
    if char_length(p_content) < 5 then
        -- trường hợp lỗi
        set result_message = 'nội dung quá ngắn';
    else
        -- trường hợp hợp lệ thì insert
        insert into posts (user_id, content) 
        values (p_user_id, p_content);
        set result_message = 'thêm bài viết thành công';
    end if;
end //

DELIMITER ;

-- 3) gọi thủ tục và thử insert các trường hợp
-- test case 1: nội dung quá ngắn
call createpostwithvalidation(1, 'hi', @msg1);
-- test case 2: nội dung đủ dài
call createpostwithvalidation(1, 'hello world, đây là bài viết hợp lệ', @msg2);

-- 4) kiểm tra các kết quả (liệt kê rõ tên cột)
select @msg1 as ket_qua_test_1;
select @msg2 as ket_qua_test_2;

-- kiểm tra lại bảng posts (lấy bài mới nhất)
select post_id, user_id, content, created_at 
from posts 
where user_id = 1 
order by post_id desc 
limit 1;

-- 5) xóa thủ tục vừa khởi tạo
drop procedure if exists createpostwithvalidation;