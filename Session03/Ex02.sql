create database ss3ex02;
use ss3ex02;

create table Student (
	student_id int primary key auto_increment,
    full_name varchar(50) not null,
    date_of_birth date not null,
    email varchar(50) unique
);

insert into Student (full_name, date_of_birth, email)
value 
	('Bàng Trọng Tú', '2005-01-21', 'tu@gmail.com'),
    ('Nguyễn Văn A', '2005-02-10', 'a@gmail.com'), -- sửa ngày sinh
    ('Trần Thị B', '2005-05-08', 'b@gmail.com'), -- sửa email
    ('Đặng Văn C', '2005-12-28', 'c@gmail.com'),
    ('Phạm Quang D', '2005-03-22', 'd@gmail.com'); -- Xóa
    
-- Cập nhật email cho sinh viên có student_id = 3
update Student
set email = 'ttb@gmail.com'
where student_id = 3;

-- Cập nhật ngày sinh cho sinh viên có student_id = 2
update Student
set date_of_birth = '2005-11-11'
where student_id = 2;

-- Xóa một sinh viên có student_id = 5
delete from Student where student_id = 5;

-- Lấy ra tất cả sinh viên sau khi thực hiện câu lệnh Cập nhật và Xóa
select * from Student

    
