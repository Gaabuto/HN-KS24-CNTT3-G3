drop table if exists subject;
drop table if exists student;
use ex3_btth;

create table student(
	studentId int primary key,
    fullName varchar(30) not null,
    dateOfBirth date,
    email varchar(30) unique
);

insert into student (studentId, fullName, dateOfBirth, email)
values
	(1, 'Nguyen Van A', '2001-01-01', 'a@example.com'),
    (2, 'Nguyen Van B', '2002-02-02', 'b@example.com'),
    (3, 'Nguyen Van C', '2003-03-03', 'c@example.com'),
    (4, 'Nguyen Van D', '2004-04-04', 'd@example.com');

create table subject(
	subjectId int primary key,
    subjectName varchar(30) not null,
    credit int not null check(credit > 0)
);

insert into subject(subjectId, subjectName, credit)
values
	(1, 'Java', 4),
    (2, 'Frontend', 6),
    (3, 'ReactJs', 8),
    (4, 'Python', 4);
    
update subject set credit = 10 where subjectId = 4;
update subject set subjectName = 'C' where subjectId = 4;

select * from subject;