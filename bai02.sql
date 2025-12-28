create database exercise02;
use exercise02;

create table student(
	student_id int primary key auto_increment,
    student_name varchar(50) not null
);

create table subjects(
	subject_id int primary key auto_increment,
    subject_name varchar(50) not null,
    subject_credit int not null check(subject_credit > 0)
)
