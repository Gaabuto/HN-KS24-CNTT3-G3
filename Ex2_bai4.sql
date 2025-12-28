create database bai4;
use bai4;

create table Teacher(
	TeacherId int primary key,
    FullName varchar(30) not null,
    Email varchar (30) unique
);

alter table Subject
add TeacherId int not null;
alter table Subject
add constraint FK_Subject_Teacher foreign key (TeacherId)
	references Teacher(TeacherId)
	on update cascade
	on delete restrict;