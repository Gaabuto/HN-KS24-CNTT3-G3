DELIMITER $$
create procedure addUser(
	IN name_in varchar(50), 
    IN email_in varchar(100), 
    IN created_at_in date
)
begin
	insert into users(username, email, created_at)
    values
    (name_in, email_in,created_at_in);
end $$

create trigger check_before_insert
before insert
on users
for each row
begin
	if new.email not like '%@%.%' then
        signal sqlstate '45000'
        set message_text = 'email khong hop le';
    end if;
end $$
DELIMITER ;

-- Gọi procedure với dữ liệu hợp lệ và không hợp lệ để kiểm thử.
call addUser('tu', 'tu@gmail.com', '2025-01-10');

-- SELECT * FROM users để xem kết quả.
select * from users where username = 'tu';