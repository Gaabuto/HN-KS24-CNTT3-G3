create database ss03_b7;
use ss03_b7;
drop table Student;
create table Student(
	student_id int primary key,
    full_name varchar(50) not null,
    date_of_birth date,
    email varchar(50) unique not null
);
insert into Student (student_id,full_name,date_of_birth,email)
value 
	('1','Nguyễn Mạnh Thắng','2006-04-24','thang@gmail.com'),
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


drop table Score;
create table Score(
	student_id int,
    subject_id  int,
    mid_score float check (mid_score between 0 and 10),
    final_score float check (final_score  between 0 and 10),
    foreign key (student_id) references Student(student_id),
    foreign key (subject_id) references Subject(subject_id)
);

insert into Score(student_id,subject_id,mid_score,final_score)
value (1,1,8.5,9.0),
(1,2,7.25,6.5),
(2,1,10,9.5);

update Score
set mid_score = 7, final_score = 6
where student_id = 1 and subject_id = 2;

delete from Score
where subject_id = '2';

select * from Student;
select * from Score;
SHOW TABLES;
