use bai1;

update Student
set email = 'hoangdeptrai@gmail.com'
where student_id = 3;

update Student
set date_of_birth = '2006-12-13'
where student_id = 2;

delete from Student
where student_id = 5
