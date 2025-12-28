create database exercise04;
use exercise04;

create table teacher (
	teacher_id int primary key auto_increment,
    teacher_name varchar(50) not null,
    teacher_email varchar(50) not null unique
);

create table subjects(
	subject_id int primary key auto_increment,
    subject_name varchar(50) not null,
    subject_credit int not null check(subject_credit > 0)
);

alter table subjects add teacher_id int;
alter table subjects add constraint subjects_teacher foreign key (teacher_id) references teacher(teacher_id);