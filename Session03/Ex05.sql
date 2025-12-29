create database ss3ex05;
use ss3ex05;

create table Student (
	student_id int primary key auto_increment,
    full_name varchar(50) not null,
    date_of_birth date not null,
    email varchar(50) unique
);

insert into Student (full_name, date_of_birth, email)
value 
	('Bàng Trọng Tú', '2005-01-21', 'tu@gmail.com'),
    ('Nguyễn Văn A', '2005-02-10', 'a@gmail.com'),
    ('Trần Thị B', '2005-05-08', 'b@gmail.com');
    
create table Subjects (
	subject_id int primary key auto_increment,
    subject_name varchar(50) not null,
    credit int check (credit > 0)
);

insert into Subjects (subject_name, credit)
value
	('Lập trình C', 10),
    ('Lập trình python', 8),
    ('Lập trình java', 7);
    
create table Score (
	student_id int not null,
    subject_id int not null,
    
    mid_score decimal(4,2) check (mid_score between 0 and 10),
    final_score decimal(4,2) check (final_score between 0 and 10),
    
    primary key (student_id, subject_id),
    
    foreign key (student_id) references Student(student_id),
    foreign key (subject_id) references Subjects(subject_id)
);

-- Thêm điểm cho ít nhất 2 sinh viên
insert into Score (student_id, subject_id, mid_score, final_score)
value
	(1, 1, 8.75, 8),
    (2, 2, 7.5, 7.25);

-- Cập nhật điểm cuối kỳ cho một sinh viên
update Score
set final_score = 9
where student_id = 1 and subject_id = 1;

-- Lấy ra toàn bộ bảng điểm
select * from Score;

-- Lấy ra các sinh viên có điểm cuối kỳ từ 8 trở lên
select * from score where final_score > 8;




