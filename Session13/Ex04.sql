create table post_history (
    history_id int primary key auto_increment,
    post_id int not null,
    old_content text,
    new_content text,
    changed_at datetime,
    changed_by_user_id int,
    foreign key (post_id) references posts(post_id)
);

DELIMITER $$
create trigger before_update_post_v4
before update
on posts
for each row
begin
	insert into post_history(post_id,old_content,new_content,changed_at,changed_by_user_id)
    values
		(old.post_id,old.content, new.content, now(), old.user_id);
end $$

create trigger after_delete_post_v4
after delete
on posts
for each row
begin
	insert into post_history (post_id, old_content, changed_at, changed_by_user_id)
	values 
		(old.post_id, old.content,now(), old.user_id);
end $$
DELIMITER ;

-- Thực hiện UPDATE nội dung một số bài đăng, sau đó SELECT từ post_history để xem lịch sử.
update posts
set content = 'noi dung moi sau khi chinh sua'
where post_id = 1;

select *
from post_history
order by changed_at desc;