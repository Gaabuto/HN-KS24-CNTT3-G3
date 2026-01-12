use social_network_pro;

DELIMITER //

-- 2) viết procedure dùng cursor để gửi thông báo
create procedure notifyfriendsonnewpost(
    in p_user_id int,
    in p_content text
)
begin
    -- khai báo biến (bắt buộc khi dùng cursor)
    declare v_sender_name varchar(100);
    declare v_friend_id int;
    declare done boolean default false;

    -- khai báo cursor: lấy danh sách bạn bè (cả 2 chiều)
    declare cur_friends cursor for 
        select friend_id from friends where user_id = p_user_id and status = 'accepted'
        union
        select user_id from friends where friend_id = p_user_id and status = 'accepted';
    -- khai báo handler: để nhận biết khi nào hết danh sách thì dừng
    declare continue handler for not found set done = true;
    -- bước 1: lấy tên người đăng bài
    select full_name into v_sender_name from users where user_id = p_user_id;
    -- bước 2: đăng bài viết mới
    insert into posts (user_id, content) values (p_user_id, p_content);
    -- bước 3: mở cursor và duyệt vòng lặp
    open cur_friends;
    read_loop: loop
        -- lấy từng id bạn bè bỏ vào biến v_friend_id
        fetch cur_friends into v_friend_id;
        -- nếu hết danh sách (done = true) thì thoát vòng lặp
        if done then 
            leave read_loop; 
        end if;
        -- tạo thông báo cho người bạn đó
        insert into notifications (user_id, type, content)
        values (v_friend_id, 'new_post', concat(v_sender_name, ' đã đăng một bài viết mới'));
    end loop;
    -- đóng cursor giải phóng bộ nhớ
    close cur_friends;
end //

DELIMITER ;

-- 3) gọi procedure (ví dụ user 1 đăng bài)
-- user 1 có rất nhiều bạn bè trong data mẫu, nên sẽ tạo ra nhiều thông báo
call notifyfriendsonnewpost(1, 'hôm nay tôi học về cursor trong mysql, khá phức tạp!');

-- 4) select ra những thông báo vừa tạo
-- lấy những thông báo mới nhất loại 'new_post'
select notification_id, user_id, content, created_at
from notifications
where type = 'new_post'
order by notification_id desc
limit 10;

-- 5) xóa thủ tục
drop procedure if exists notifyfriendsonnewpost;