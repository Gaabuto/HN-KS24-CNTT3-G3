create database bai4;
use bai4;

Create table Student (
	student_id int primary key auto_increment,
    full_name varchar(20) not null,
    date_of_birth date,
    email varchar(50) unique
);

create table subject (
	subject_id int primary key auto_increment,
    subject_name varchar(50),
    credit int check (credit > 0)
);

create table enrollment (
	student_id int primary key auto_increment,
    subject_id int primary key auto_increment,
	foreign key (student_id) references student(student_id),
    foreign key (subject_id) references subject(subject_id),
    Enroll_date date
);

insert into Student(full_name, date_of_birth,email)
values
('Ngo Xuan Hoang', '2005-11-16', 'nxh16112005@gmail.com'),
('Hoang Xuan', '2006-12-11', 'hoang123@gmail.com')


