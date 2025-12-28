create database bai3;
use bai3;

create table class (
    class_id varchar(60) primary key,
    class_name varchar(60) not null,
    credit int not null check (credit > 0)
);
create table student (
    student_id varchar(60) primary key,
    student_name varchar(60) not null
);
create table enrollment (
    student_id varchar(60) not null,
    class_id varchar(60) not null,
    register_date date not null,
    primary key (student_id, class_id),
    
    foreign key (student_id) references student(student_id),
    foreign key (class_id) references class(class_id)
);