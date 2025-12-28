create table subjects (
subject_id varchar(50) primary key,
subject_name varchar(50) not null,
credit int not null check (credit > 0)
);

create table student ( 
student_id varchar(50) primary key,
student_name varchar(50) not null
)

