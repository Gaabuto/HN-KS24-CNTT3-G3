create database bai3;
use bai3;

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

create table Enrollment(
	StudentId int not null,
    SubjectId int not null,
    EnrollmentDate Date not null,
    primary key (StudentId, SubjectId),
    constraint FK_Enrollment_Student foreign key (StudentId)
		references Student(StudentId)
        on update restrict
        on delete cascade,
	constraint FK_Enrollment_Subject foreign key (SubjectId)
		references Subject(SubjectId)
        on update restrict
        on delete cascade
);

