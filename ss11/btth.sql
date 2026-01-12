create database SocialLab;
use SocialLab;
create table posts(
post_id int primary key auto_increment,
content text,
author varchar(50),
likes_count int default 0
);

delimiter //
create procedure sp_CreatePost (
content_in text,
author_in varchar(50),
out id_in int 
)
begin
	insert into posts(content, author)
    values(content_in,author_in);
    set id_in = last_insert_id();
end //

create procedure sp_SearchPost (
search text
)
begin
select content
from posts
where content like concat('%', search, '%') ;
end //

create  procedure sp_IncreaseLike (id_in, inout

delimiter ;

call sp_CreatePost('context me','khanh1',@id);
select @id;

delimiter //

create procedure sp_SearchPost (
    in keyword text
)
begin
    select post_id, content, author, likes_count
    from posts
    where content like concat('%', keyword, '%');
end //

delimiter ;

delimiter //

create procedure sp_IncreaseLike (
    in p_post_id int,
    inout p_likes_count int
)
begin
    set p_likes_count = p_likes_count + 1;

    update posts
    set likes_count = p_likes_count
    where post_id = p_post_id;
end //

delimiter ;


delimiter //

create procedure sp_DeletePost (
    in p_post_id int
)
begin
    delete from posts
    where post_id = p_post_id;
end //

delimiter ;
