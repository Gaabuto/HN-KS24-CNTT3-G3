create database exercise01;
use exercise01;

create table class(
	class_id int primary key auto_increment,
    class_name varchar(100) not null,
    class_year int not null
);

create table student(
	student_id int primary key auto_increment,
    student_name varchar(100) not null,
    student_date date not null,
    class_id int not null,
    foreign key(class_id) references class(class_id)
);
drop table student;
