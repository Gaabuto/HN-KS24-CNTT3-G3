create database ss03_b4;
use ss03_b4;

drop table Subject ;
create table Subject (
	subject_id int primary key,
    subject_name varchar(50) not null,
    credit int check (credit > 0)
);
insert into Subject(subject_id, subject_name, credit) 
value ('1', 'Toán', 4),
('2', 'Văn', 3),
('3', 'Anh', 4);

update Subject
set subject_name = 'CSDL', credit = '3'
where subject_id = '1';

select * from Subject;