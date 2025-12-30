create database btth;
use btth;

create table student(
	studentId int primary key,
    fullName varchar(30) not null,
    dateOfBirth date,
    email varchar(30) unique
);

create table subject(
	subjectId int primary key,
    subjectName varchar(30) not null,
    credit int not null check(credit > 0)
);

create table enrollment(
	studentId int,
    subjectId int,
    enrollDate date,
    primary key (studentId, subjectId),
    foreign key (studentId) references student(studentId),
    foreign key (subjectId) references subject(subjectId)
);

create table score(
	studentId int,
    subjectId int,
    score decimal(4,2),
    primary key (studentId, subjectId),
    foreign key (studentId) references student(studentId),
    foreign key (subjectId) references subject(subjectId)
);

insert into student (studentId, fullName, dateOfBirth, email)
values
	(1, 'Nguyen Van A', '2001-01-01', 'a@example.com'),
    (2, 'Nguyen Van B', '2002-02-02', 'b@example.com'),
    (3, 'Nguyen Van C', '2003-03-03', 'c@example.com'),
    (4, 'Nguyen Van D', '2004-04-04', 'd@example.com');

insert into subject(subjectId, subjectName, credit)
values
	(1, 'Java', 4),
    (2, 'Frontend', 6),
    (3, 'ReactJs', 8),
    (4, 'Python', 4);


insert into score (studentId, subjectId, score)
values
	(2, 2, 7.75),
    (4, 3, 8.5);
    
select * from score;

insert into enrollment (studentId, subjectId, enrollDate)
values
	(4, 2, '2022-03-04'),
    (1, 1, '2025-01-01');
    
update score 
	set score = 8 where studentId = 2 and subjectId = 2;
    
delete from enrollment
	where studentId = 1 and subjectId = 1;

delete from score
	where studentId = 4 and subjectId = 3;

select * from student;
select * from subject;
select * from enrollment;
select * from score;
select s.fullName, sub.subjectName, sc.score
	from score sc
    join student s on sc.studentId = s.studentId
    join subject sub on sc.subjectId = sub.subjectId;