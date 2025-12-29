create database bai05;
use bai05;

create table Score(
    student_id varchar(10) not null,
    subject_id varchar(10) not null,
    mid_score decimal(4,2) check (mid_score >= 0 and mid_score <= 10),
    final_score decimal(4,2) check (final_score >= 0 and final_score <= 10),
    primary key(student_id, subject_id)
);

insert into Score (student_id, subject_id, mid_score, final_score)
values 
('m01', 'code01', 7.50, 8.00),
('m02', 'math02', 6.00, 7.50),
('m03', 'phys03', 8.50, 9.00),
('m04', 'code01', 9.25, 8.50),
('m05', 'math02', 7.40, 6.50);
update score
set final_score = 10
where student_id = 'm01' and subject_id = 'code01';
select 
    student_id,
    subject_id,
    mid_score,
    final_score
from score;
select 
    student_id,
    subject_id,
    mid_score,
    final_score
from score
where final_score >= 8.00



