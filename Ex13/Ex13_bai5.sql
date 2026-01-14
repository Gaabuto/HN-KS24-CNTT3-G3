drop database if exists ss13_ex5;
create database ss13_ex5;
use ss13_ex5;

create table users(
  user_id int auto_increment primary key,
  username varchar(50) unique not null,
  email varchar(100) unique not null,
  created_at date
) engine=innodb;

delimiter $$
drop trigger if exists users_before_insert_validate $$
create trigger users_before_insert_validate
before insert on users
for each row
begin
  if new.email is null or new.email not like '%@%' or new.email not like '%.%' then
    signal sqlstate '45000'
      set message_text = 'email khong hop le (can co @ va .)';
  end if;
  if new.username is null or new.username = '' or new.username regexp '^[A-Za-z0-9_]+$' = 0 then
    signal sqlstate '45000'
      set message_text = 'username khong hop le (chi duoc chu, so, underscore)';
  end if;
end $$

drop procedure if exists add_user $$
create procedure add_user(
  in p_username varchar(50),
  in p_email varchar(100),
  in p_created_at date
)
begin
  insert into users (username, email, created_at)
  values (p_username, p_email, p_created_at);
end $$
delimiter ;

call add_user('alice_01', 'alice@example.com', '2025-01-01');
call add_user('bob', 'bob@mail.com', '2025-01-02');
call add_user('charlie', 'charlieexample.com', '2025-01-03');
call add_user('david', 'david@mail', '2025-01-04');

select * from users order by user_id;