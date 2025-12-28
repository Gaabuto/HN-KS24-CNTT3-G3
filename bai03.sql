create database exercise03;
use exercise03;

create table student (
	student_id int primary key auto_increment,
    student_name varchar(50) not null
);

create table subjects(
	subject_id int primary key auto_increment,
    subject_name varchar(50) not null,
    subject_credit int not null check(subject_credit > 0)
);

create table enrollment (
	student_id int not null,
    subject_id int not null,
    enrollment_date date not null,
    primary key (student_id, subject_id),
    foreign key(student_id) references student(student_id),
    foreign key(subject_id) references subjects(subject_id)
)
