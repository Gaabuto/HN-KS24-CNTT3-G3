create database bai4;
use bai4;

create table teacher (
    teacher_id varchar(60) primary key,
    full_name varchar(80) not null,
    email varchar(80) not null unique
);

create table teaching (
    teacher_id varchar(60) not null,
    class_id varchar(60) not null,
    primary key (teacher_id, class_id),
    foreign key (teacher_id) references teacher(teacher_id),
    foreign key (class_id) references class(class_id)
);

