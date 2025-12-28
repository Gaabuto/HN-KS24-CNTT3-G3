create database bai1;
use bai1;
create table class (
    class_id varchar(50) primary key,
    class_name varchar(50) not null,
    years int not null
);
create table student (
    student_id varchar(50) primary key,
    student_name varchar(50) not null,
    date_birth date not null,
    class_id varchar(50) not null,
    foreign key (class_id)
	references class (class_id)
);
drop table student;