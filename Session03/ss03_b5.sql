create database ss03_b5;
use ss03_b5;
drop table Student;
create table Student(
	student_id int primary key,
    full_name varchar(50) not null,
    date_of_birth date,
    email varchar(50) unique not null
);
insert into Student (student_id,full_name,date_of_birth,email)
value 
	('1','Nguyễn Trường An','2001-01-01','an@gmail.com'),
	('2','Nguyễn Văn A','2006-03-12','a@gmail.com'),
    ('3','Trần Thị B','2006-09-03','b@gmail.com');
    
drop table Subject ;
create table Subject (
	subject_id int primary key,
    subject_name varchar(50) not null,
    credit int check (credit > 0)
);

insert into Subject(subject_id, subject_name, credit) 
value ('1', 'Toán', 4),
('2', 'Văn', 3),
('3', 'Anh', 4);
drop table Enrollment;
create table Enrollment(
	student_id int,
    subject_id int,
    enroll_date date,
    foreign key (student_id) references Student(student_id),
    foreign key (subject_id) references Subject(subject_id)
);

insert into Enrollment(student_id,subject_id,enroll_date)
value (1,1,'2025-12-20'),
(1,2,'2025-11-25'),
(2,1,'2025-12-20');

select * from Enrollment;
select student_id, subject_id, enroll_date from Enrollment
where student_id = 1;
SHOW TABLES;
