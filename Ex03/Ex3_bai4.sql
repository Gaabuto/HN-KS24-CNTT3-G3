use ex3_btth;
drop table if exists enrollment;
create table enrollment(
	studentId int,
    subjectId int,
    enrollDate date,
    primary key (studentId, subjectId),
    foreign key (studentId) references student(studentId),
    foreign key (subjectId) references subject(subjectId)
);

insert into enrollment(studentId, subjectId, enrollDate)
values
	(1, 1, '2009-01-01'),
    (2, 2, '2012-09-02'),
    (3, 2, '2022-01-05');
    
select * from enrollment;
select e.fullName, en.subjectName, er.enrollDate
	from enrollment er
    join student e on er.studentId = e.studentId
    join subject en on er.subjectId = en.subjectId;