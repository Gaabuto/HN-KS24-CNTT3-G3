create database ss3ex03;
use ss3ex03;

create table Subjects (
	subject_id int primary key auto_increment,
    subject_name varchar(50) not null,
    credit int check (credit > 0)
);

-- Thêm dữ liệu cho một số môn học
insert into Subjects (subject_name, credit)
value
	('Lập trình C', 10),
    ('Lập trình python', 8),
    ('Lập trình java', 7);

-- Cập nhật số tín chỉ cho một môn học
update Subjects
set credit = 20
where subject_id = 2;

-- Đổi tên một môn học
update Subjects
set subject_name = 'Lập trình C++'
where subject_id = 1