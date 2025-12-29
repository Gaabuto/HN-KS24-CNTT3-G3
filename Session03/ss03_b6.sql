create database ss03_b6;
use ss03_b6;
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
drop table Score;
create table Score(
	student_id int,
    subject_id int,
    mid_score  float check (mid_score between 0 and 10),
    final_score float check (final_score between 0 and 10),
    foreign key (student_id) references Student(student_id),
    foreign key (subject_id) references Subject(subject_id)
);

insert into Score(student_id, subject_id, mid_score, final_score)
value (1,1,5,7),
(2,1,9,10),
(3,1,8,8.5);

update Score
set final_score = 7.75
where student_id = 1 and subject_id = 1;

select * from Score;
select * from Score where final_score > 8;
SHOW TABLES;
