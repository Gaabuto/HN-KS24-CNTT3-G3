create database ss3ex04;
use ss3ex04;

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
    ('Trần Thị B', '2005-05-08', 'b@gmail.com'), 
    ('Đặng Văn C', '2005-12-28', 'c@gmail.com'),
    ('Phạm Quang D', '2005-03-22', 'd@gmail.com');
    
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
    
create table enrollment (
	student_id int not null,
    subject_id int not null,
    
    enroll_date date not null,
    
    primary key (student_id, subject_id),
    
    foreign key (student_id) references Student(student_id),
    foreign key (subject_id) references Subjects(subject_id)
);

-- Thêm dữ liệu đăng ký môn học cho ít nhất 2 sinh viên
insert into enrollment (student_id, subject_id, enroll_date)
value 
	(1, 1, '2025-12-28'),
    (2, 3, '2025-12-29');

-- Lấy ra tất cả các lượt đăng ký
select * from enrollment;

-- Lấy ra các lượt đăng ký của một sinh viên cụ thể
select * from enrollment where student_id = 2
    
    
    
    