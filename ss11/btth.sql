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

create 

delimiter ;

call sp_CreatePost('context me','khanh1',@id);
select @id;
