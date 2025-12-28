create database exercise06;
use exercise06;

create table class(
	class_id int primary key auto_increment,
    class_name varchar(100) not null,
    class_year int not null
);

create table student(
	student_id int primary key auto_increment,
    student_name varchar(50) not null,
    class_id int not null,
    foreign key (class_id) references class(class_id)
);

create table teacher (
	teacher_id int primary key auto_increment,
    teacher_name varchar(50) not null,
    teacher_email varchar(50) not null unique
);

create table subjects(
	subject_id int primary key auto_increment,
    subject_name varchar(50) not null,
    subject_credit int not null check(subject_credit > 0),
    teacher_id int not null,
    foreign key (teacher_id) references teacher(teacher_id)
);

create table enrollment (
	student_id int not null,
    subject_id int not null,
    enrollment_date date not null,
    primary key (student_id, subject_id),
    foreign key(student_id) references student(student_id),
    foreign key(subject_id) references subjects(subject_id)
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
