create database bai04;
use bai04;

create table student (
    student_id varchar(50) primary key,
    full_name varchar(50) not null,
    date_of_birth date,
    email varchar(255) unique
);

insert into student (student_id, full_name, date_of_birth, email) values
('01', 'phan phuoc anh', '2006-10-29', 'example@gmail.com'),
('02', 'bang de tam', '2005-04-30', 'ex@gmail.com'),
('03', 'nguyen tran bao khanh', '2006-04-06', 'khanhbua@gmail.com');

create table subject (
    subject_id varchar(50) primary key,
    subject_name varchar(50) not null,
    credit int check (credit > 0)
);

insert into subject (subject_id, subject_name, credit) values
('it1', 'lap trinh typescript', 4),
('it2', 'html-css-javascript',  6),
('it3', 'lap trinh java', 5);

create table enrollment (
    student_id varchar(50) not null,
    subject_id varchar(50) not null,
    enroll_date date not null,
    primary key (student_id, subject_id),
    foreign key (student_id) references student(student_id),
    foreign key (subject_id) references subject(subject_id)
);

insert into enrollment (student_id, subject_id, enroll_date) 
values
('01', 'it1', '2025-09-01'),
('01', 'it2', '2025-09-02'),
('01', 'it3', '2025-09-03'),
('02', 'it2', '2025-09-04'),
('02', 'it3', '2025-09-05'),
('03', 'it1', '2025-09-06');
select 
    student_id,
    subject_id,
    enroll_date
from enrollment
order by student_id, subject_id;
select 
    student_id,
    subject_id,
    enroll_date
from enrollment
where student_id = '02'
order by subject_id;