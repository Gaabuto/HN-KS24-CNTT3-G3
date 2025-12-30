create database ss4;
use ss4;

create table Student (
    student_id varchar(20) primary key,
    full_name varchar(50) not null,
    birth_date date not null,
    email varchar(50) not null unique
);

create table Teacher (
    teacher_id varchar(20) primary key,
    full_name varchar(50) not null,
    email varchar(50) not null unique
);

create table Course (
    course_id varchar(20) primary key,
    course_name varchar(50) not null,
    description varchar(100),
    total_sessions int not null check (total_sessions > 0),
    teacher_id varchar(20),
    foreign key (teacher_id) references Teacher(teacher_id)
);

create table Enrollment (
    student_id varchar(20),
    course_id varchar(20),
    enroll_date date not null,
    primary key (student_id, course_id),
    foreign key (student_id) references Student(student_id),
    foreign key (course_id) references Course(course_id)
);

create table Result (
    student_id varchar(20),
    course_id varchar(20),
    mid_score float not null check (mid_score between 0 and 10),
    final_score float not null check (final_score between 0 and 10),
    primary key (student_id, course_id),
    foreign key (student_id, course_id) references Enrollment(student_id, course_id)
);

insert into Student 
values
('SV01','Nguyen Van A','2004-01-10','a@gmail.com'),
('SV02','Nguyen Van B','2004-02-15','b@gmail.com'),
('SV03','Nguyen Van C','2004-03-20','c@gmail.com'),
('SV04','Nguyen Van D','2004-04-25','d@gmail.com'),
('SV05','Nguyen Van E','2004-05-30','e@gmail.com');

insert into Teacher 
values
('GV01','Tran Van T','t@gmail.com'),
('GV02','Le Thi H','h@gmail.com'),
('GV03','Pham Van K','k@gmail.com'),
('GV04','Do Thi M','m@gmail.com'),
('GV05','Hoang Van P','p@gmail.com');

insert into Course 
values
('C01','Toan','Toan',30,'GV01'),
('C02','Ly','Vat ly',25,'GV02'),
('C03','Hoa','Hoa hoc',20,'GV03'),
('C04','Anh','Tieng Anh',15,'GV04'),
('C05','Tin','Lap trinh co ban',40,'GV05');

insert into Enrollment 
values
('SV01','C01','2025-01-10'),
('SV01','C02','2025-01-11'),
('SV02','C03','2025-01-12'),
('SV03','C04','2025-01-13'),
('SV04','C05','2025-01-14');

insert into Result values
('SV01','C01',7.5,8.0),
('SV01','C02',6.5,7.0),
('SV02','C03',8.0,8.5),
('SV03','C04',7.0,7.5),
('SV04','C05',9.0,9.5);

update Student
set email = 'new_a@gmail.com'
where student_id = 'SV01';

update Course
set description = 'Lap trinh nang cao'
where course_id = 'C05';


update Result
set final_score = 9.0
where student_id = 'SV01' and course_id = 'C02';

delete from Result
where student_id = 'SV01' and course_id = 'C02';

delete from Enrollment
where student_id = 'SV01' and course_id = 'C02';

select * from Student;
select * from Teacher;
select * from Course;
select * from enrollment;
select * from result;


