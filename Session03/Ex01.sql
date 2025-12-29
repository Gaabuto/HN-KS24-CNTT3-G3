create database ss3ex01;
use ss3ex01;

create table Student (
	student_id int primary key auto_increment,
    full_name varchar(50) not null,
    date_of_birth date not null,
    email varchar(50) unique
);

-- Thêm ít nhất 3 sinh viên vào bảng
insert into Student (full_name, date_of_birth, email)
value 
	('Bàng Trọng Tú', '2005-01-21', 'tu@gmail.com'),
    ('Nguyễn Văn A', '2005-02-10', 'a@gmail.com'),
    ('Trần Thị B', '2005-05-08', 'b@gmail.com');
    
-- Lấy ra toàn bộ danh sách sinh viên
select * from Student;

-- Lấy ra mã sinh viên và họ tên của tất cả sinh viên
select student_id, full_name from Student;
