
use ex3_btth;
update student set email = 'new@example.com' where studentId = 3;

update student set dateOfBirth = '2003-09-03' where studentId = 2;

delete from student where studentId = 4;

select * from student;