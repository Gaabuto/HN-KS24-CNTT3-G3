-- create database ss3;
-- use ss3;


-- drop table student;










-- bai 1
create table student( 
student_id varchar(50) primary key,
full_name varchar(50) not null,
date_birth date,
gmail varchar(50) unique
);

insert into student()
values
('b24dtcn001', 'Nguyen Van A', '2025-04-06', 'khannh04060@gmail.com' ),
('b24dtcn002', 'Nguyen Van B', '2025-04-06', 'khannh040604@gmail.com' ),
('b24dtcn003', 'Nguyen Van C', '2025-04-06', 'khannh040603@gmail.com' );

select * from  student;

select student_id, full_name from student;






-- bai 2
update student
set gmail = 'khanh040603@gmail.com'
where student_id = 'b24dtcn003';
update student
set date_birth = '2006-03-06'
where student_id ='b24dtcn002';
insert into student()
values
('b24dtcn005', 'Nguyen Van F', '2025-03-01', 'khannh040605@gmail.com' );
select * from  student;


delete from student
where student_id = 'b24dtcn005';


select * from  student;









-- bai 3

create table subjects(
subject_id varchar(50) primary key,
subject_name varchar(50) not null,
credit int check(credit>0)
);

insert into subjects()
values ('Math1', 'Toan co', '15'),
 ('Eng1', 'Anh', '12'),
  ('Ltrl1', 'Van', '15');


update subjects
set credit = '15'
where subject_id = 'Eng1';


update subjects
set subject_name = 'Anh-Anh'
where subject_id = 'Eng1';



-- bai 4

create table Enrollment(
student_id varchar(50),
subject_id varchar(50),
enroll_date date,
primary key (student_id,subject_id),
foreign key (student_id) references student(student_id),
foreign key (subject_id) references subjects(subject_id)
);

insert into enrollment 
values
('b24dtcn001', 'Math1', '2025-04-10'),
('b24dtcn001', 'Eng1',  '2025-04-11'),
('b24dtcn002', 'Math1', '2025-04-10'),
('b24dtcn002', 'Ltrl1','2025-04-12');

select * from Enrollment;

select * from enrollment where student_id = 'b24dtcn001';



-- bai 5

create table score(
student_id varchar(50),
subject_id varchar(50),
mid_score float not null check(mid_score>0 and mid_score<10),
final_score float not null check(final_score>0 and final_score<10),
primary key (student_id,subject_id),
foreign key (student_id) references student(student_id),
foreign key (subject_id) references subjects(subject_id)
);

insert into score 
values
('b24dtcn001', 'Math1', 8.0, 8.5),
('b24dtcn001', 'Eng1',  7.5, 8.0),
('b24dtcn002', 'Math1', 6.5, 7.0),
('b24dtcn002', 'Ltrl1', 8.0, 9.0);

update score
set final_score ='9.0'
where student_id = 'b24dtcn001' and subject_id = 'Math1';

select * from score;


-- bai 6
insert into student
value 
('b24dtcn127','Nguyen Tran Bao Khanh', '2006-04-06', 'khanh040604@gmail.com');
insert into enrollment
values
('b24dtcn127', 'math1', '2025-12-29'),
('b24dtcn127', 'ltrt1', '2025-12-29');

insert into score 
value
('b24dtcn127', 'math1', '9.9', '5');

update score
set final_score = '10'
where student_id = 'b24dtcn127' and subject_id = 'math1';

 delete from enrollment 
 where student_id = 'b24dtcn127' and subject_id = 'ltrl1'; 
 
	