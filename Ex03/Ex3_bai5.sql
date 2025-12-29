drop table if exists score;
use ex3_btth;

create table score(
	studentId int,
    subjectId int,
    midScore decimal(4,2) check(midScore >= 0 and midScore <= 10),
    finalScore decimal(4,2) check(finalScore >= 0 and finalScore <= 10),
    primary key (studentId, subjectId)
);

insert into score(studentId, subjectId, midScore, finalScore)
values
	(1, 1, 7.5, 8.5),
    (2, 2, 7, 7.5),
    (3, 2, 5, 6.5);
    
select * from score;
select st.fullName, sb.subjectName, sc.midScore, sc.finalScore
	from score sc
    join student st on sc.studentId = st.studentId
    join subject sb on sc.subjectId = sb.subjectId;