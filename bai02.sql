create database bai2;
use bai2;
create table student (
    student_id varchar(50)   primary key, 
    full_name varchar(100) not null           
);

create table subject (
    subject_id   varchar(50)   primary key,
    subject_name varchar(100)  not null,
    credits int not null check (credits > 0)
);