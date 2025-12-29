create database ss03_b3;
use ss03_b3;

drop table Student;
create table Student(
	student_id int primary key,
    full_name varchar(50) not null,
    date_of_birth date,
    email varchar(50) unique not null
);

insert into Student (student_id,full_name,date_of_birth,email)
value 
	('1','Nguyễn Trường An','2001/01/01','thang@gmail.com'),
	('2','Nguyễn Văn A','2006/03/12','a@gmail.com'),
    ('3','Trần Thị B','2006/09/03','b@gmail.com'),
    ('5','Trần Thị B','2006/09/03','f@gmail.com');
update Student
set email = 'ttb@gmail.com'
where student_id = '3';

update Student
set date_of_birth = '2005/10/30'
where student_id = '2';

delete from Student
where student_id = '5';

select * from Student;