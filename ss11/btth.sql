create database if not exists SocialLab;
use SocialLab;

create table posts (
    post_id int primary key auto_increment,
    content text,
    author varchar(255),
    likes_count int default 0
);
-- bài 1
delimiter //
	create procedure sp_CreatePost(
		author_in varchar(255),
        content_in text,
        post_id_in int 
    )
begin
	insert into posts (content, author)
    values (author_in, content_in);
    set post_id_in = last_insert_id();
end //
delimiter ;

call sp_CreatePost(
    'Tháng tư là lời nói dối của em',
    'Anh',
    @new_post_id
);
select @new_post_id;

drop procedure if exists sp_CreatePost;

-- bài 2
delimiter //
create procedure sp_SearchPost(
	keyword_in varchar(255)
)
begin
	select post_id,
        content,
        author,
        likes_count
	from posts
    where content like concat('%', keyword_in,'%');
end //
delimiter ;

call sp_SearchPost('SocialLab');

drop procedure if exists sp_SearchPost;

-- bài 3
delimiter //
create procedure sp_IncreaseLike(
    post_id_in int,
    likes_count_inout int
)
begin
	-- cập nhật số like trong bảng
    update posts
    set likes_count = likes_count + 1
    where post_id = post_id_in;
	
    -- lấy lại số like mới sau khi tăng
    select likes_count
    into likes_count_inout
    from posts
    where post_id = post_id_in;
end //
delimiter ;

set @likes = 0;
call sp_IncreaseLike(1, @likes);
select @likes as new_likes_count;

drop procedure if exists sp_IncreasePost;

-- bài 4
delimiter //
create procedure sp_DeletePost(
    post_id_in int
)
begin
    delete from posts
    where post_id = post_id_in;
end //
delimiter ;

drop procedure if exists sp_DeletePost;






