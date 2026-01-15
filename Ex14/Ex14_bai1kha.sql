create database ex14_kha1;
use ex14_kha1;

-- 1. tạo bảng users
create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default 0
);

-- 2. tạo bảng posts
create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);

-- 3. thêm dữ liệu mẫu
insert into users (username) values 
('nguyen_van_a'),
('tran_thi_b');

-- 4. viết stored procedure dùng transaction
delimiter $$
create procedure sp_create_post_transaction(
    in p_user_id int,
    in p_content text
)
begin
    -- xử lý lỗi thì rollback
    declare exit handler for sqlexception
    begin
        rollback;
        select 'thất bại: lỗi hệ thống hoặc sai id người dùng' as 'kết quả';
    end;
    start transaction;
    -- bước 1: thêm bài viết mới
    insert into posts (user_id, content) 
    values (p_user_id, p_content);
    -- bước 2: cập nhật số lượng bài viết của user
    update users 
    set posts_count = posts_count + 1 
    where user_id = p_user_id;
    -- bước 3: xác nhận giao dịch
    commit;
    select 'thành công: bài viết đã được đăng' as 'kết quả';
end $$
delimiter ;

-- 5. chạy thử
-- thành công 
call sp_create_post_transaction(1, 'hôm nay trời đẹp quá!');
-- lỗi
call sp_create_post_transaction(999, 'bài viết này sẽ bị lỗi');

-- 7. xem kết quả dữ liệu
-- kiểm tra user
select user_id, username, posts_count from users;
-- kiểm tra posts
select post_id, user_id, content, created_at from posts;