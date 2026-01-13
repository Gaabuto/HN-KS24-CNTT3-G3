create database studentdb;
use studentdb;

create table department (
    deptid char(5) primary key,
    deptname varchar(50) not null
);

create table student (
    studentid char(6) primary key,
    fullname varchar(50),
    gender varchar(10),
    birthdate date,
    deptid char(5),
    foreign key (deptid) references department(deptid)
);

create table course (
    courseid char(6) primary key,
    coursename varchar(50),
    credits int
);

create table enrollment (
    studentid char(6),
    courseid char(6),
    score float,
    primary key (studentid, courseid),
    foreign key (studentid) references student(studentid),
    foreign key (courseid) references course(courseid)
);

insert into department values
('it','information technology'),
('ba','business administration'),
('acc','accounting');

insert into student values
('s00001','nguyen an','male','2003-05-10','it'),
('s00002','tran binh','male','2003-06-15','it'),
('s00003','le hoa','female','2003-08-20','ba'),
('s00004','pham minh','male','2002-12-12','acc'),
('s00005','vo lan','female','2003-03-01','it'),
('s00006','do hung','male','2002-11-11','ba'),
('s00007','nguyen mai','female','2003-07-07','acc'),
('s00008','tran phuc','male','2003-09-09','it');

insert into course values
('c00001','database systems',3),
('c00002','c programming',3),
('c00003','microeconomics',2),
('c00004','financial accounting',3);

insert into enrollment values
('s00001','c00001',8.5),
('s00001','c00002',7.0),
('s00002','c00001',6.5),
('s00003','c00003',7.5),
('s00004','c00004',8.0),
('s00005','c00001',9.0),
('s00006','c00003',6.0),
('s00007','c00004',7.0),
('s00008','c00001',5.5),
('s00008','c00002',6.5);

-- bai 1 + 2
create view View_StudentBasic as 
select s.studentid, s.fullname, d.deptname
	from student s join department d on s.deptid = d.deptid;
select studentid, fullname, deptname
	from View_StudentBasic;
create index idx_student_fullname on student(fullname);

delimiter //

-- bai 3
create procedure getStudentsIt()
begin	
    select s.studentid, s.fullname, d.deptname
	from student s join department d on s.deptid = d.deptid
where d.deptname = 'information technology';
end//
delimiter ;
call getStudentsIt();

-- bai 4
create view View_StudentCountByDept as
select d.deptname, count(s.studentid) as total_students
from department d
left join student s on d.deptid = s.deptid
group by d.deptname;

select deptname, total_students
from View_StudentCountByDept 
order by total_students desc
limit 1;

delimiter //
-- bai 5
create procedure GetTopScoreStudent(in p_courseid char(6))
begin
select s.studentid, s.fullname, e.score
 from enrollment e join student s on e.studentid = s.studentid
where e.courseid = p_courseid
	and e.score = (
select max(score)
from enrollment where courseid = p_courseid
);
end//
delimiter ;

call GetTopScoreStudent('c00001');
set @newscore = 11;
select @newscore as updatedscore;
select studentid, courseid, score
