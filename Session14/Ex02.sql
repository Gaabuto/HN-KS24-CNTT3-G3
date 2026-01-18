create table likes (
    like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id),
    unique key unique_like (post_id, user_id)
);

-- thêm cột likes_count vào posts
alter table posts
add column likes_count int default 0;

insert into posts (user_id, content) 
values 
	(1, 'ảnh chó'),
    (2, 'ảnh mèo');

/*
Viết script SQL sử dụng TRANSACTION để:
INSERT vào bảng likes (post_id và user_id do bạn chọn).
UPDATE tăng likes_count +1 cho bài viết tương ứng.
Nếu vi phạm UNIQUE constraint (đã like trước đó) hoặc lỗi khác, ROLLBACK.
Nếu thành công, COMMIT.
*/
DELIMITER $$
create procedure like_post(
    in p_post_id int,
    in p_user_id int
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        select 'rollback: da like truoc do' as result;
    end;

    start transaction;

    insert into likes (post_id, user_id)
    values (p_post_id, p_user_id);

    -- tang likes_count
    update posts
    set likes_count = likes_count + 1
    where post_id = p_post_id;

    commit;
    select 'commit: like thanh cong' as result;
end $$
DELIMITER ;

/*
Thực hiện thử nghiệm:
Like lần đầu → COMMIT.
Like lần thứ hai cùng post và user → gây lỗi → ROLLBACK.
*/
-- Like làn đầu
call like_post(1, 2);

select post_id, likes_count
from posts
where post_id = 1;

select *
from likes
where post_id = 1 and user_id = 2;

-- Like lần 2 rollback
call like_post(1, 2);