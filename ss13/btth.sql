create database socialnetworkdb;
use socialnetworkdb;

create table users (
    user_id int primary key auto_increment,
    username varchar(100) not null,
    total_posts int default 0
);

create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text,
    created_at datetime default current_timestamp,
    constraint fk_posts_users
        foreign key (user_id)
        references users(user_id)
);

create table post_audits (
    audit_id int primary key auto_increment,
    post_id int not null,
    old_content text,
    new_content text,
    changed_at datetime default current_timestamp,
    constraint fk_audits_posts
        foreign key (post_id)
        references posts(post_id)
);

delimiter //
create trigger tg_CheckPostContent 
before insert 
on posts for each row
begin
if
length(trim(new.content)) = 0 then
	signal sqlstate '45000'
    set message_text = 'Nội dung bài viết không được để trống!';
end if;
end //

create trigger tg_UpdatePostCountAfterInsert 
after insert 
on posts for each row
begin
	update users
    set total_posts = total_posts + 1
    where user_id = new.user_id;
end //

create trigger tg_LogPostChanges 
after update
on posts for each row
begin
	insert into post_audits(post_id,old_content,new_content,changed_at)
    values
    (old.post_id,old.content,new.content,current_timestamp());
end //

create trigger tg_UpdatePostCountAfterDelete 
after delete
on posts for each row
begin
	update users
    set total_posts = total_posts - 1
    where user_id = old.user_id;
end //
delimiter ;

insert into users(username)
values ('gaabu');
insert into posts(user_id, content)
values (1, 'nwnwnwwnwnwnw');
insert into posts(user_id, content)
values (1, '');
update posts
set content = 'assaasasassas'
where post_id = 1;
delete from posts
where post_id = 1;

