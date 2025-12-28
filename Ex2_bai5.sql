create database bai5;
use bai5;

create table Score(
	StudentId int not null,
    SubjectId int not null,
	ProcessScore decimal(4,2) not null,
    FinalScore decimal(4,2) not null,
    primary key(StudentId, SubjectId),
    constraint CK_ProcessScore check (ProcessScore >= 0 and ProcessScore <= 10),
    constraint CK_FinalScore check (FinalScore >= 0 and FinalScore <= 10),
    constraint FK_Score_Student foreign key (StudentId)
		references Student(StudentId)
			on update cascade
            on delete cascade,
		constraint FK_Score_Subject foreign key (SubjectId)
			references Subject(SubjectId)
            on update cascade
            on delete cascade
);
