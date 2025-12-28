create database bai1;
use bai1;

create table Class ( 
	ClassID int primary key, 
    ClassName varchar(50) not null, 
    AcademicYear varchar(20) not null 
) engine = InnoDB; 

create table Student ( 
	StudentID int primary key, 
    FullName varchar(30) not null, 
    BirthDate date not null, 
    ClassID int not null, 
    constraint FK_Student_Class foreign key(ClassID) references Class(ClassID)
) engine = InnoDB;