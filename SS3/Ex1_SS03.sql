Create table Student (
	student_id int primary key auto_increment,
    full_name varchar(20) not null,
    date_of_birth date,
    email varchar(50) unique
);

insert into Student(full_name, date_of_birth,email)
values 
('Ngô Xuân Hoàng', '2005-11-16', 'nxh16112004@gmail.com'),
('Ngô Hoàng', '2005-11-17', 'nxh123@gmail.com'),
('Xuân Hoàng', '2005-11-18', 'nxh456@gmail.com')
