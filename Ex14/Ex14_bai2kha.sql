create database ex14_kha2;
use ex14_kha2;

-- 1. tạo bảng users
create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null
);

-- 2. tạo bảng posts 
create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    likes_count int default 0,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);

-- 3. tạo bảng likes 
create table likes (
    like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id),
    unique key unique_like (post_id, user_id)
);

-- 4. thêm dữ liệu mẫu
insert into users (username) values ('nguyen_van_a'), ('tran_thi_b');
insert into posts (user_id, content) values (1, 'ảnh đi du lịch đà lạt');

-- 5. viết stored procedure dùng transaction
delimiter $$
create procedure sp_like_post(
    in p_user_id int,
    in p_post_id int
)
begin
    -- khai báo xử lý lỗi
    declare exit handler for sqlexception
    begin
        rollback;
        select 'thất bại: bạn đã like bài này rồi hoặc dữ liệu không tồn tại' as 'kết quả';
    end;
    start transaction;
    -- bước 1: thêm vào bảng likes
    insert into likes (user_id, post_id) 
    values (p_user_id, p_post_id);
    -- bước 2: tăng số lượng like trong bảng posts
    update posts 
    set likes_count = likes_count + 1 
    where post_id = p_post_id;
    -- bước 3: xác nhận giao dịch
    commit;
    select 'thành công: đã like bài viết' as 'kết quả';
end $$
delimiter ;

-- 6. chạy thử
-- thành công
call sp_like_post(2, 1);
-- thất bại
call sp_like_post(2, 1);

-- 7. xem kết quả dữ liệu
select post_id, content, likes_count from posts;
-- kiểm tra bảng likes 
select like_id, user_id, post_id, created_at from likes;