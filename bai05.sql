create database bai5;
use bai5;

create table student (
    student_id varchar(60)   primary key,  
    full_name varchar(90) not null           
);

create table class (
    class_id varchar(60) primary key,
    class_name varchar(60) not null,
    credit int not null check (credit > 0)
);

create table score (
    student_id varchar(50) not null,
    class_id varchar(50) not null,
    
    midterm_score decimal(4,2) check (midterm_score between 0 and 10),
    final_score decimal(4,2) check (final_score between 0 and 10),
    recorded_date date not null default '2000-01-01', -- giá trị tạm thời cho ngày tháng và năm
    primary key (student_id, class_id),
    
    foreign key (student_id) references student(student_id),
    foreign key (class_id)   references class(class_id)
);
