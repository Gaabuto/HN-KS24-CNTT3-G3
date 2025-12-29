create database ss3btth;
use ss3btth;

create table student (
	student_id int primary key auto_increment,
    full_name varchar(100) not null,
    date_of_birth date not null,
    gender enum('Male', 'Female', 'Other') default('Other'),
    email varchar(100) not null unique,
    class_name varchar(50) not null
);

create table subject (
	subject_id int primary key auto_increment,
    subject_name varchar(255) not null,
    credit_hours int not null check(credit_hours>0)
);

create table enrollment (
	student_id int not null,
    subject_id int not null,
    
    semester varchar(50) not null,
    regist_date datetime default current_timestamp,
    
    primary key (student_id, subject_id),
    foreign key (student_id) references student(student_id),
    foreign key (subject_id) references subject(subject_id)
    
);

-- 1. thêm ít nhất 5 dữ liệu cho mỗi bảng
insert into student (full_name, date_of_birth, gender, email, class_name)
value 
	('Bàng Đệ Nhất', '2005-01-21', 'Male', 'nhat@gamil.com', 'Toan'),
    ('Bàng Đệ Nhị', '2005-01-22', 'Male', 'nhi@gmail.com', 'Van'),
    ('Bàng Đệ Tam', '2005-01-23', 'Female', 'tam@gmail.com', 'Anh'),
    ('Bàng Đệ Tu', '2005-01-24', 'Female', 'tu@gmail.com', 'Lich Su'),
    ('Bàng Đệ Ngu', '2005-01-25', 'Male', 'ngu@gmail.com', 'Dia Ly');
    
insert into subject (subject_name, credit_hours)
value 
	('Toan', 18),
    ('Van', 20),
    ('Anh', 22),
    ('Lich Su', 16),
    ('Dia Ly', 15);
	
    
-- 2. sửa cho sinh viên Giỏi vào sau sinh viên: Nguyễn Văn A => Nguyễn Văn A Giỏi
update student
set full_name = 'Bàng Đệ Nhất Giỏi'
where student_id = 1;

-- 3. Sửa cho môn học 'Lập trình C' --> 'Môn học lập trình C'
update subject
set subject_name = 'Môn học lập trình C'
where subject_id = 1;

-- 4. Xóa những môn học có mã 2, 3
delete from subject
where subject_id = 2;

delete from subject
where subject_id = 3;

-- 5. Đăng ký môn học 1 cho sinh viên 2
insert into enrollment (student_id, subject_id, semester)
value (2, 1, 'HK1');

-- 6. Hủy đăng ký môn học 1 cho sinh viên 2
delete from enrollment
where subject_id = 1 and student_id = 2