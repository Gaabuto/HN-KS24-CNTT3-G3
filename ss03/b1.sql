create database bai01;
use bai01;

create table studentz(
    student_id varchar(50) primary key,
    full_name varchar(50) not null,
    date_of_birth date,
    email varchar(255) unique
);
insert into studentz(student_id, full_name, date_of_birth, email)
values
("01","Phan Phuoc Anh","2006-10-29","example@gmail.com"),
("02","Bang De Tam","2005-01-21","ex@gmail.com"),
("03","Nguyen Tran Bao Khanh","2006-04-06","buas@gmail.com");
