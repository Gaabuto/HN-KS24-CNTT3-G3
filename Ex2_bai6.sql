create database bai6;
use bai6;

create table `class`(
	classId int primary key,
	className varchar(50) not null
);

create table teacher (
	teacherId int primary key,
	fullName varchar(30) not null,
	email varchar(50) unique
);

create table student(
	studentId int primary key,
	fullName varchar(30) not null,
	email varchar(30) unique,
	classId int not null,
	constraint FK_StudentClass foreign key (classId)
		references `class`(classId)
		on update cascade
		on delete restrict
);

create table subject(
	subjectId int primary key,
	subjectName varchar(50) not null,
	credit int not null,
	teacherId int not null,
	constraint CHK_Subject_Credit check(credit > 0),
	constraint FK_Subject_Teacher foreign key (teacherId)
		references teacher(teacherId)
		on update cascade
		on delete restrict
);

create table enrollment(
	subjectId int not null,
	studentId int not null,
	enrollmentDate date not null,
	primary key (studentId, subjectId),
	constraint FK_Enrollment_Student foreign key (studentId)
		references student(studentId)
		on update cascade
		on delete cascade,
	constraint FK_Enrollment_Subject foreign key (subjectId)
		references subject(subjectId)
		on update cascade
		on delete cascade
);

create table score(
	studentId int not null,
	subjectId int not null,
	processScore decimal(4,2) not null check(processScore between 0 and 10),
	finalScore decimal(4,2) not null check(finalScore between 0 and 10),
	primary key (studentId, subjectId),
	constraint FK_Score_Student foreign key (studentId)
		references student(studentId)
		on update cascade
		on delete cascade,
	constraint FK_Score_Subject foreign key (subjectId)
		references subject(subjectId)
		on update cascade
		on delete cascade
);