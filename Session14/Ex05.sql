-- Tạo thêm bảng delete_log để ghi log mỗi lần xóa thành công (post_id, deleted_at, deleted_by).
create table if not exists delete_log (
    log_id int primary key auto_increment,
    post_id int not null,
    deleted_at datetime default current_timestamp,
    deleted_by int not null
);

/*
Kiểm tra bài viết tồn tại và thuộc về p_user_id → nếu không, ROLLBACK.
DELETE từ bảng likes WHERE post_id = p_post_id
DELETE từ bảng comments WHERE post_id = p_post_id
DELETE từ bảng posts WHERE post_id = p_post_id
UPDATE giảm posts_count -1 cho chủ bài viết
Nếu mọi bước thành công → COMMIT
Nếu có lỗi ở bất kỳ bước nào → ROLLBACK
*/

DELIMITER $$
create procedure sp_delete_post(
    in p_post_id int,
    in p_user_id int
)
begin
    declare v_owner_id int;

    declare exit handler for sqlexception
    begin
        rollback;
        select 'lỗi hệ thống, rollback toàn bộ' as ket_qua;
    end;

    start transaction;

    -- kiểm tra bài viết tồn tại và thuộc user
    select user_id
    into v_owner_id
    from posts
    where post_id = p_post_id
    for update;

    if v_owner_id is null then
        rollback;
        select 'bài viết không tồn tại' as 'Kết quả';

    elseif v_owner_id <> p_user_id then
        rollback;
        select 'không có quyền xóa bài viết này' as 'Kết quả';

    else
        -- xóa likes
        delete from likes where post_id = p_post_id;

        -- xóa comments
        delete from comments where post_id = p_post_id;

        -- xóa post
        delete from posts where post_id = p_post_id;

        -- giảm posts_count
        update users
        set posts_count = posts_count - 1
        where user_id = p_user_id;

        -- ghi log
        insert into delete_log (post_id, deleted_by)
        values (p_post_id, p_user_id);

        commit;
        select 'xóa bài viết thành công' as 'Kết quả';
    end if;
end $$
DELIMITER ;

-- Hợp lệ
call sp_delete_post(1, 1);

-- Check 
select * from posts where post_id = 1;
select * from likes where post_id = 1;
select * from comments where post_id = 1;
select posts_count from users where user_id = 1;
select * from delete_log;

-- Không hợp lệ
call sp_delete_post(2, 1);