create database ss3ex06;
use ss3ex06;

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

create table enrollment (
	student_id int not null,
    subject_id int not null,
    
    enroll_date date not null,
    
    primary key (student_id, subject_id),
    
    foreign key (student_id) references Student(student_id),
    foreign key (subject_id) references Subjects(subject_id)
);

-- Thêm một sinh viên mới
insert into Student (full_name, date_of_birth, email)
value ('Đinh Quốc C', '2005-02-28', 'c@gmail.com');

-- Đăng ký ít nhất 2 môn học cho sinh viên đó
insert into enrollment (student_id, subject_id, enroll_date)
value
	(4, 1, '2025-12-29'),
    (4, 2, '2025-12-30');

-- Thêm và cập nhật điểm cho sinh viên vừa thêm
-- Thêm
insert into Score (student_id, subject_id, mid_score, final_score)
value
	(4, 1, 8.75, 9),
    (4, 2, 9.5, 8);
-- Cập nhật
update Score 
set final_score = 7.75
where student_id = 4 and subject_id = 2;

-- Xóa một lượt đăng ký không hợp lệ
delete from enrollment
where student_id = 4 and subject_id = 1;

-- Lấy ra danh sách sinh viên và điểm số tương ứng
Select student_id, mid_score, final_score from Score




