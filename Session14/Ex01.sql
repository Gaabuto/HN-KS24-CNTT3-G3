create database ss14_db;
use ss14_db;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default(0)
);

create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);

insert into users (username) 
values 
	('Nguyễn Văn An'),
	('Ma Văn Bình'),
    ('Hồ Quốc Cường'),
    ('Đinh Thùy Dương');
    
/*
Viết script SQL sử dụng TRANSACTION để thực hiện:
INSERT một bản ghi mới vào bảng posts (với user_id và content do bạn chọn).
UPDATE tăng posts_count +1 cho user tương ứng.
Nếu bất kỳ thao tác nào thất bại, thực hiện ROLLBACK.
Nếu thành công, thực hiện COMMIT.
*/

DELIMITER $$
create procedure insert_post_with_transaction(
    in p_user_id int,
    in p_content text
)
begin
	declare exit handler for sqlexception
    begin
        rollback;
        select 'rollback do xay ra loi' as result;
    end;

    start transaction;

    insert into posts (user_id, content)
    values (p_user_id, p_content);

    update users
    set posts_count = posts_count + 1
    where user_id = p_user_id;

    commit;
    select 'commit thanh cong' as result;
end $$
DELIMITER ;

/*
Chạy script với ít nhất 2 trường hợp:
Trường hợp thành công (COMMIT).
Trường hợp gây lỗi cố ý (ví dụ: vi phạm ràng buộc khóa ngoại bằng user_id không tồn tại) để kiểm tra ROLLBACK.
*/
-- Trường hợp thành công (COMMIT).
call insert_post_with_transaction(1, 'một hai ba bốn');

select * from posts;
select * from users where user_id = 1;

-- Trường hợp gây lỗi cố ý
call insert_post_with_transaction(99, 'Mười chín');