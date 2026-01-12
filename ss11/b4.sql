-- bài 4
use social_network_pro;

delimiter //
create procedure CreatePostWithValidation(
    p_user_id int,
    p_content text,
    result_message varchar(255)
)
begin
    -- kiểm tra độ dài nội dung
    if char_length(p_content) < 5 then 
        set result_message = 'Nội dung quá ngắn';
    else
        -- thêm bài viết mới
        insert into posts(user_id, content, create_at)
        values (p_user_id, p_content, now());

        set result_message = 'Thêm bài viết thành công';
    end if;
end //
delimiter ;

set @message = '';
call CreatePostWithValidation(1, 'a b c d e f g h', @message);
select @message as result;
drop procedure if exists CreatePostWithValidation;