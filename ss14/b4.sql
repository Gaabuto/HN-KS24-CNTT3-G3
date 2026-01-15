create database b4;
use b4;
alter table posts
add column comments_count int default 0;

create table comments (
    comment_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

delimiter //

create procedure sp_post_comment(
    in p_post_id int,
    in p_user_id int,
    in p_content text
)
begin
    start transaction;

    insert into comments (post_id, user_id, content)
    values (p_post_id, p_user_id, p_content);

    savepoint after_insert;

    if p_content = 'force_error' then
        rollback to after_insert;
        commit;
    else
        update posts
        set comments_count = comments_count + 1
        where post_id = p_post_id;

        commit;
    end if;
end //

delimiter ;

call sp_post_comment(1, 2, 'nice post');

select * from posts;
select * from comments;

call sp_post_comment(1, 2, 'force_error');

select * from posts;
select * from comments;