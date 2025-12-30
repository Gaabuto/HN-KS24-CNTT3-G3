create database bai5;
use bai5;

Create table Student (
	student_id int primary key auto_increment,
    full_name varchar(20) not null,
    date_of_birth date,
    email varchar(50) unique
);

create table Subject (
	subject_id int primary key auto_increment,
    subject_name varchar(50),
    credit int check (credit > 0)
);

CREATE TABLE Score (
    student_id INT,
    subject_id INT,
    mid_score FLOAT CHECK (mid_score BETWEEN 0 AND 10),
    final_score FLOAT CHECK (final_score BETWEEN 0 AND 10),

    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);

insert into Student(full_name, date_of_birth,email)
values 
('Ngô Xuân Hoàng', '2005-11-16', 'nxh16112004@gmail.com'),
('Ngô Hoàng', '2005-11-17', 'nxh123@gmail.com'),
('Xuân Hoàng', '2005-11-18', 'nxh456@gmail.com');

insert into subject(subject_name, credit)
values  
('Math', 5),
('C++', 3),
('Python', 4);

INSERT INTO Score (student_id, subject_id, mid_score, final_score)
VALUES
(1, 1, 7.5, 8.0),
(2, 2, 6.0, 7.5),
(3, 3, 8.0, 9.0);

UPDATE Score
SET final_score = 9.0
WHERE student_id = 2 AND subject_id = 101;

SELECT * FROM Score;

SELECT *
FROM Score
WHERE final_score >= 8;