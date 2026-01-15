CREATE database session14_ex1;

use session14_ex1;

CREATE table users(
	user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default 0
);

CREATE table posts(
	post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key(user_id) references users(user_id)
);

insert into users (username) values 
('nguyenvana'),
('tran_thi_b'),
('le_van_c'),
('pham_dang_d'),
('hoang_thi_e'),
('minh_tuan_99');


Delimiter //
CREATE procedure add_posts(in p_user_id int, in p_content text)
begin
	declare exit handler for sqlexception 
	begin
		rollback;
		select 'Đã có lỗi xảy ra, hệ thống đã khôi phục dữ liệu' as ErrorMessage;
	end;
	start transaction;
    if not exists (select 1 from users where user_id = p_user_id) then
		rollback;
        select 'User ID không tồn tại!' as errormessage;
	end if;
	INSERT INTO posts(user_id, content) values(p_user_id, p_content);
	UPDATE users set posts_count = posts_count + 1 where user_id = p_user_id;
    
    commit;
end//

drop procedure add_posts;

call add_posts(1, 'Học CSDL');
call add_posts(20, 'Học CSDL');
select * from posts;
select * from users;