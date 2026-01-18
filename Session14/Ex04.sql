create table comments (
    comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

-- thêm cột comments_count
alter table posts
add column comments_count int default 0;

DELIMITER $$
create procedure sp_post_comment(
    in p_post_id int,
    in p_user_id int,
    in p_content text
)
begin
    start transaction;

    -- 1. thêm comment
    insert into comments (post_id, user_id, content)
    values (p_post_id, p_user_id, p_content);

    -- 2. tạo savepoint
    savepoint after_insert;

    -- 3. giả lập lỗi sau khi insert
    if p_content = 'lỗi' then
        rollback to after_insert;
        commit;
        select 'rollback phần update' as 'Kết quả';
    else
        -- 4. update count
        update posts
        set comments_count = comments_count + 1
        where post_id = p_post_id;

        commit;
        select 'thêm comment và cập nhật count thành công' as 'Kết quả';
    end if;
end $$
DELIMITER ;

-- Thành công
call sp_post_comment(1, 2, 'Đẹp quá');

-- check count
select * from comments where post_id = 1;
select post_id, comments_count from posts where post_id = 1;

-- Lỗi 
call sp_post_comment(1, 3, 'lỗi');
