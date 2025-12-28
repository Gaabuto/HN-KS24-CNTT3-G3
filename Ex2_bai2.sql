create database bai2;
use bai2;

create table Student(
	StudentId int primary key,
    FullName varchar(20) not null
);

create table Subject(
	SubjectId int primary key,
    SubjectName varchar(50) not null,
    Credit int not null
    constraint checkCredit check(Credit > 0)
);



