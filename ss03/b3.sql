create database bai03;
use bai03;

create table Subject(
	subject_id varchar(50) primary key,
    subject_name varchar(50) not null,
    credit int check (credit > 0)
);

insert into Subject(subject_id, subject_name, credit)
value 
("IT1","Lap trinh huong doi tuong","04"),
("IT2","HTML-CSS-JAVASCRIPT","06"),
("IT3","Lap trinh java","03");

update Subject
set subject_name = "lap trinh typescript"
where subject_id = "IT1";

update Subject
SET credit = 05
WHERE subject_id = 'IT3';

select * from Subject;
select subject_id, subject_name, credit
from Subject
where credit >= 4;