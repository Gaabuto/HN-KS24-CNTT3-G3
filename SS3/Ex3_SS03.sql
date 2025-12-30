create database bai3;
use bai3;

create table subject (
	subject_id int primary key auto_increment,
    subject_name varchar(50),
    credit int check (credit > 0)
);

insert into subject(subject_name, credit)
values  
('Math', 5),
('C++', 3),
('Python', 4)