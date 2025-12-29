/*
   TẠO DATABASE
  */
create database BTTH;
use BTTH;

/* 
   TABLE STUDENT
    */
create table student (
    student_id int primary key auto_increment,
    full_name varchar(100) not null,
    email varchar(100) not null unique,
    gender enum('male','female','other') default 'other',
    date_of_birth date,
    class_name varchar(50)
);

/* 
   TABLE SUBJECT
 */
create table subject (
    subject_id int primary key auto_increment,
    subject_name varchar(255) not null,
    credit_hours int not null check (credit_hours > 0)
);

/* 
   TABLE ENROLLMENT
*/
create table enrollment (
    student_id int not null,
    subject_id int not null,
    semester varchar(20),
    regist_date datetime default current_timestamp,

    primary key (student_id, subject_id),
    foreign key (student_id) references student(student_id),
    foreign key (subject_id) references subject(subject_id)
);

/*
   THÊM DỮ LIỆU (Ít nhất 5 bản ghi)
  */

/* STUDENT */
insert into student (full_name, email, gender, date_of_birth, class_name) values
('Hoang', 'hoang@gmail.com', 'male', '2003-01-01', 'CNTT1'),
('Tu', 'tu@gmail.com', 'male', '2003-02-02', 'CNTT1'),
('Thanh', 'thanh@gmail.com', 'male', '2003-03-03', 'CNTT2'),
('Lan', 'lan@gmail.com', 'female', '2003-04-04', 'CNTT2'),
('Mai', 'mai@gmail.com', 'female', '2003-05-05', 'CNTT3');

/* SUBJECT */
insert into subject (subject_name, credit_hours) values
('Lập trình C', 3),
('Lập trình Java', 4),
('Lập trình Python', 3),
('Cơ sở dữ liệu', 3),
('Mạng máy tính', 3);

/*
   CÂU 5: ĐĂNG KÝ MÔN HỌC 1 CHO SV 2
 */
insert into enrollment (student_id, subject_id, semester)
values (2, 1, 'HK1');

/*
   UPDATE THEO YÊU CẦU
   */

/* Thêm chữ "giỏi" sau tên sinh viên */
update student
set full_name = concat(full_name, ' giỏi');

/* Sửa tên môn học */
update subject
set subject_name = 'Môn Học Lập Trình C'
where subject_name = 'Lập trình C';

/* 
   CÂU 6: HỦY ĐĂNG KÝ MÔN HỌC 1 CHO SV 2
   */
delete from enrollment
where student_id = 2
  and subject_id = 1;

/*
   KIỂM TRA KẾT QUẢ
   */
select * from student;
select * from subject;
select * from enrollment;
