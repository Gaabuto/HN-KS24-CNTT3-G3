delimiter $$
create trigger check_likes_user_v2
before insert
on likes for each row
begin
    if new.user_id = (
		select user_id
        from posts
        where post_id = new.post_id
    ) then
		signal sqlstate '45000'
		set message_text = 'user khong duoc like bai dang cua chinh minh';
    end if;
end $$

create trigger after_insert_like_count_v2
after insert
on likes
for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end $$

create trigger after_delete_like_count_v2
after delete
on likes
for each row
begin
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
end $$

create trigger after_update_like_count_v2
after update
on likes
for each row
begin
    if old.post_id <> new.post_id then
        update posts
        set like_count = like_count - 1
        where post_id = old.post_id;

        update posts
        set like_count = like_count + 1
        where post_id = new.post_id;
    end if;
end $$

delimiter ;

-- Thử like chính mình
insert into likes (user_id, post_id)
values (1, 1);

-- like hợp lệ
insert into likes (user_id, post_id)
values (2, 1);

select post_id, like_count
from posts
where post_id = 1;

-- UPDATE một like sang post khác, kiểm tra like_count của cả hai post.
update likes
set post_id = 2
where like_id = 1;

select post_id, like_count
from posts
where post_id in (1, 2);

-- Xóa like và kiểm tra.
delete from likes
where like_id = 1;

select post_id, like_count
from posts
where post_id = 2;
