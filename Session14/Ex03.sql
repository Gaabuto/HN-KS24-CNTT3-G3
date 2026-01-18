create table followers (
    follower_id int not null,
    followed_id int not null,
    
    primary key (follower_id, followed_id),
    foreign key (follower_id) references users(user_id),
    foreign key (followed_id) references users(user_id)
);

-- Thêm cột
alter table users
add column following_count int default 0,
add column followers_count int default 0;

/*
Kiểm tra cả hai user có tồn tại không → nếu không, ghi log lỗi (INSERT vào bảng follow_log nếu tạo) và ROLLBACK.
Kiểm tra không tự follow chính mình (p_follower_id <> p_followed_id).
Kiểm tra chưa follow trước đó (không tồn tại bản ghi trong followers).
Nếu mọi kiểm tra OK: INSERT vào followers, UPDATE tăng following_count của follower, UPDATE tăng followers_count của followed → COMMIT.
Nếu có lỗi: ROLLBACK.
*/

DELIMITER $$
create procedure sp_follow_user(
    in p_follower_id int,
    in p_followed_id int
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        select 'lỗi hệ thống' as ket_qua;
    end;

    start transaction;

    if p_follower_id = p_followed_id then
        rollback;
        select 'không thể follow bản thân' as ket_qua;

    elseif (select count(*) from users where user_id in (p_follower_id, p_followed_id)) < 2 then
        rollback;
        select 'người dùng không tồn tại' as ket_qua;

    elseif exists (
        select 1 from followers
        where follower_id = p_follower_id
          and followed_id = p_followed_id
    ) then
        rollback;
        select 'bạn đã theo dõi người này rồi' as ket_qua;

    else
        insert into followers values (p_follower_id, p_followed_id);

        update users
        set following_count = following_count + 1
        where user_id = p_follower_id;

        update users
        set followers_count = followers_count + 1
        where user_id = p_followed_id;

        commit;
        select 'theo dõi người dùng thành công' as ket_qua;
    end if;
end $$
DELIMITER ;

-- Trường hợp thành công
call sp_follow_user(1, 2);

-- Trường hợp trùng
call sp_follow_user(1, 2);

-- Tự follow
call sp_follow_user(1, 1);

-- Không tồn tại
call sp_follow_user(1, 999);