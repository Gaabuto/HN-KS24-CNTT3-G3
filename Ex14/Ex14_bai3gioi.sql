create database ex14_gioi3;
use ex14_gioi3;

-- 1. tạo bảng users 
create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null,
    following_count int default 0,
    followers_count int default 0
);

-- 2. tạo bảng followers 
create table followers (
    follower_id int not null,
    followed_id int not null,
    created_at datetime default current_timestamp,
    primary key (follower_id, followed_id),
    foreign key (follower_id) references users(user_id),
    foreign key (followed_id) references users(user_id)
);

-- 3. tạo bảng log lỗi 
create table follow_log (
    log_id int primary key auto_increment,
    follower_id int,
    followed_id int,
    error_message varchar(255),
    log_time datetime default current_timestamp
);

-- 4. thêm dữ liệu mẫu
insert into users (username) values 
('nguyen_van_a'),
('tran_thi_b'), 
('le_van_c'); 

-- 5. viết stored procedure
delimiter $$
create procedure sp_follow_user(
    in p_follower_id int,
    in p_followed_id int
)
begin
    -- khai báo biến kiểm tra
    declare v_check_exist int;
    -- xử lý lỗi 
    declare exit handler for sqlexception
    begin
        rollback;
        insert into follow_log (follower_id, followed_id, error_message) 
        values (p_follower_id, p_followed_id, 'lỗi hệ thống sql');
        select 'lỗi hệ thống' as 'kết quả';
    end;
    start transaction;
    -- logic 1: kiểm tra không tự follow chính mình
    if p_follower_id = p_followed_id then
        rollback;
        insert into follow_log (follower_id, followed_id, error_message) 
        values (p_follower_id, p_followed_id, 'không thể tự follow chính mình');
        select 'không thể tự follow chính mình' as 'kết quả';
    -- logic 2: kiểm tra cả 2 user có tồn tại không
    elseif (select count(*) from users where user_id in (p_follower_id, p_followed_id)) < 2 then
        rollback;
        insert into follow_log (follower_id, followed_id, error_message) 
        values (p_follower_id, p_followed_id, 'người dùng không tồn tại');
        select 'người dùng không tồn tại' as 'kết quả';
    -- logic 3: kiểm tra đã follow chưa (bảng followers)
    elseif exists (select 1 from followers where follower_id = p_follower_id and followed_id = p_followed_id) then
        rollback;
        insert into follow_log (follower_id, followed_id, error_message) 
        values (p_follower_id, p_followed_id, 'đã follow trước đó');
        select 'bạn đã theo dõi người này rồi' as 'kết quả';
    else
        -- logic 4: thực hiện follow 
        -- a. thêm vào bảng followers
        insert into followers (follower_id, followed_id) 
        values (p_follower_id, p_followed_id);
        -- b. tăng số lượng người đang theo dõi 
        update users 
        set following_count = following_count + 1 
        where user_id = p_follower_id;
        -- c. tăng số lượng người theo dõi 
        update users 
        set followers_count = followers_count + 1 
        where user_id = p_followed_id;
        -- xác nhận thành công
        commit;
        select 'thành công: đã theo dõi người dùng' as 'kết quả';
    end if;
end $$
delimiter ;

-- 6. chạy thử các trường hợp
-- case 1: thành công 
call sp_follow_user(1, 2);
-- case 2: thất bại - tự follow chính mình
call sp_follow_user(1, 1);
-- case 3: thất bại - đã follow rồi 
call sp_follow_user(1, 2);

-- case 4: thất bại 
-- user không tồn tại 
call sp_follow_user(1, 99);

-- 7. xem kết quả kiểm tra
-- kiểm tra bảng users 
select user_id, username, following_count, followers_count from users;
-- kiểm tra bảng followers
select follower_id, followed_id, created_at from followers;
-- kiểm tra bảng log 
select log_id, follower_id, followed_id, error_message, log_time from follow_log;