create database bai05;
use bai05;
create table if not exists delete_log (
    log_id int auto_increment primary key,
    post_id int,
    deleted_at datetime default current_timestamp,
    deleted_by int
);

delimiter $$

create procedure sp_delete_post(
    in p_post_id int,
    in p_user_id int
)
begin
    declare v_owner_id int;

    start transaction;

    select user_id
    into v_owner_id
    from posts
    where post_id = p_post_id
    for update;

    if v_owner_id is null or v_owner_id <> p_user_id then
        rollback;
        signal sqlstate '45000'
        set message_text = 'delete not allowed';
    end if;

    delete from likes
    where post_id = p_post_id;

    delete from comments
    where post_id = p_post_id;

    delete from posts
    where post_id = p_post_id;

    update users
    set posts_count = posts_count - 1
    where user_id = p_user_id;

    insert into delete_log (post_id, deleted_by)
    values (p_post_id, p_user_id);

    commit;
end $$

delimiter ;

call sp_delete_post(1, 1);

call sp_delete_post(1, 2);

select * from users;
select * from posts;
select * from likes;
select * from comments;
select * from delete_log;
