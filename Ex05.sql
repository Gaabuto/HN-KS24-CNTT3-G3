create database exercise05;
use exercise05;

create table student (
	student_id int primary key auto_increment,
    student_name varchar(50) not null
);

create table subjects(
	subject_id int primary key auto_increment,
    subject_name varchar(50) not null
);

create table score (
	student_id int not null,
    subject_id int not null,
    progress_score decimal(4,2) not null check(progress_score between 0 and 10),
    final_score decimal(4,2) not null check(final_score between 0 and 10),
    primary key (student_id, subject_id),
    foreign key (student_id) references student(student_id),
    foreign key (subject_id) references subjects(subject_id)
)