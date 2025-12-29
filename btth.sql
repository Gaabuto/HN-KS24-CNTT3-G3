create database btth;
use btth;

create table student (
    studentid int primary key,
    fullname varchar(30) not null,
    dateofbirth date,
    email varchar(30) unique
);

create table subject (
    subjectid int primary key,
    subjectname varchar(30) not null,
    credit int not null check(credit > 0)
);

create table enrollment (
    studentid int,
    subjectid int,
    enrolldate date,
    primary key (studentid, subjectid),
    foreign key (studentid) references student(studentid),
    foreign key (subjectid) references subject(subjectid)
);

create table score (
    studentid int,
    subjectid int,
    score decimal(4,2),
    primary key (studentid, subjectid),
    foreign key (studentid) references student(studentid),
    foreign key (subjectid) references subject(subjectid)
);
insert into student (studentid, fullname, dateofbirth, email) values
(1, 'nguyen van a', '2001-01-01', 'a@example.com'),
(2, 'nguyen van b', '2002-02-02', 'b@example.com'),
(3, 'nguyen van c', '2003-03-03', 'c@example.com'),
(4, 'nguyen van d', '2004-04-04', 'd@example.com');
insert into subject (subjectid, subjectname, credit) values
(1, 'java', 4),
(2, 'frontend', 6),
(3, 'reactjs', 4),
(4, 'python', 4);
insert into score (studentid, subjectid, score) values
(2, 2, 7.75),
(4, 3, 8.5);
select * from score;
insert into enrollment (studentid, subjectid, enrolldate) values
(4, 2, '2022-03-04'),
(1, 1, '2025-01-01');

update score set score = 8.00 where studentid = 2 and subjectid = 2;
delete from enrollment where studentid = 1 and subjectid = 1;
delete from score where studentid = 4 and subjectid = 3;
select * from student;
select * from subject;
select * from enrollment;
select * from score;

select 
s.fullname,
sub.subjectname,
sc.score
from score sc
join student s on sc.studentid = s.studentid
join subject sub on sc.subjectid = sub.subjectid;