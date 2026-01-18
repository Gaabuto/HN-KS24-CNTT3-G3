create table likes(
	like_id int primary key auto_increment,
    user_id int not null,
    post_id int not null,
    liked_at datetime default(current_timestamp),
    foreign key (user_id) references users(user_id),
    foreign key (post_id) references posts(post_id)
);

INSERT INTO likes (user_id, post_id, liked_at) VALUES

(2, 1, '2025-01-10 11:00:00'),

(3, 1, '2025-01-10 13:00:00'),

(1, 3, '2025-01-11 10:00:00'),

(3, 4, '2025-01-12 16:00:00');

DELIMITER $$
create trigger after_insert_like_count
after insert
on likes for each row
begin
	update posts
	set like_count = like_count  + 1
	where post_id = new.post_id;
end $$

create trigger after_delete_like_count
after delete
on likes for each row
begin
	update posts
	set like_count = like_count - 1
	where post_id = old.post_id;
end $$
DELIMITER ;

create or replace view user_statistics 
as
select u.user_id, u.username, u.post_count, count(p.like_count) as 'total_likes'
from users as u left join posts as p on u.user_id = p.user_id
group by u.user_id, u.username, u.post_count;

INSERT INTO likes (user_id, post_id, liked_at) VALUES (2, 4, NOW());

SELECT * FROM posts WHERE post_id = 4;

SELECT * FROM user_statistics;

delete from likes where like_id = 3;