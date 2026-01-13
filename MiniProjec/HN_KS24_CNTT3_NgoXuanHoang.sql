CREATE DATABASE StudentDB;
USE StudentDB;
-- 1. Bảng Khoa
CREATE TABLE Department (
    DeptID CHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- 2. Bảng SinhVien
CREATE TABLE Student (
    StudentID CHAR(6) PRIMARY KEY,
    FullName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    DeptID CHAR(5),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 3. Bảng MonHoc
CREATE TABLE Course (
    CourseID CHAR(6) PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

-- 4. Bảng DangKy
CREATE TABLE Enrollment (
    StudentID CHAR(6),
    CourseID CHAR(6),
    Score FLOAT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
INSERT INTO Department VALUES
('IT','Information Technology'),
('BA','Business Administration'),
('ACC','Accounting');

INSERT INTO Student VALUES
('S00001','Nguyen An','Male','2003-05-10','IT'),
('S00002','Tran Binh','Male','2003-06-15','IT'),
('S00003','Le Hoa','Female','2003-08-20','BA'),
('S00004','Pham Minh','Male','2002-12-12','ACC'),
('S00005','Vo Lan','Female','2003-03-01','IT'),
('S00006','Do Hung','Male','2002-11-11','BA'),
('S00007','Nguyen Mai','Female','2003-07-07','ACC'),
('S00008','Tran Phuc','Male','2003-09-09','IT');

INSERT INTO Course VALUES
('C00001','Database Systems',3),
('C00002','C Programming',3),
('C00003','Microeconomics',2),
('C00004','Financial Accounting',3);

INSERT INTO Enrollment VALUES
('S00001','C00001',8.5),
('S00001','C00002',7.0),
('S00002','C00001',6.5),
('S00003','C00003',7.5),
('S00004','C00004',8.0),
('S00005','C00001',9.0),
('S00006','C00003',6.0),
('S00007','C00004',7.0),
('S00008','C00001',5.5),
('S00008','C00002',6.5);
 -- PHẦN A
 
 -- CÂU 1
create or replace view View_StudentBasic AS
select s.StudentID, s.FullName , d.DeptName
from department d join student s on d.deptid = s.deptid;

select * from View_StudentBasic;

-- CÂU 2
create index idx_fullname on Student(FullName);

-- CÂU 3
DELIMITER //

create procedure GetStudentsIT()
begin
    select
        s.StudentID,
        s.FullName,
        s.Gender,
        s.BirthDate,
        d.DeptName
    from Student s
    join Department d on s.DeptID = d.DeptID
    where d.DeptName = 'Information Technology'
    order by s.FullName;
end //

DELIMITER ;

call GetStudentsIT();

-- PHẦN B
-- CÂU 4:

create or replace view View_StudentCountByDept AS
select
    d.DeptName,
    COUNT(s.StudentID) AS TotalStudents
from Department d
left join Student s ON d.DeptID = s.DeptID
group by d.DeptID, d.DeptName;

select DeptName, TotalStudents
from View_StudentCountByDept
order by TotalStudents DESC
limit 1;

-- Câu 5
DELIMITER //

create procedure GetTopScoreStudent(IN p_CourseID CHAR(6))
begin
    select
        s.StudentID,
        s.FullName,
        e.Score,
        c.CourseName
    from Enrollment e
    join Student s on e.StudentID = s.StudentID
    join Course c on e.CourseID = c.CourseID
    where e.CourseID = p_CourseID
    order by e.Score DESC
    limit 1;
end //

DELIMITER ;

call GetTopScoreStudent('C00001');

-- Câu 6
create view View_IT_Enrollment_DB as
select
    e.StudentID,
    s.FullName,
    e.CourseID,
    c.CourseName,
    e.Score,
    d.DeptName
from Enrollment e
join Student s on e.StudentID = s.StudentID
join Department d on s.DeptID = d.DeptID
join Course c on e.CourseID = c.CourseID
-- Chỉ cho phép cập nhật điểm cho sinh viên thuộc khoa IT
WHERE d.DeptName = 'Information Technology'
  AND e.CourseID = 'C00001'

with check option;

DELIMITER //

create procedure UpdateScore_IT_DB(
    IN p_StudentID CHAR(6),
    INOUT p_NewScore FLOAT
)
BEGIN
    -- Nếu điểm mới > 10 → tự động gán = 10
    IF p_NewScore > 10 THEN
        SET p_NewScore = 10.0;
    END IF;

    -- Việc cập nhật phải thực hiện thông qua Stored Procedure
    UPDATE View_IT_Enrollment_DB
    SET Score = p_NewScore
    WHERE StudentID = p_StudentID;

    -- Dữ liệu cập nhật phải đảm bảo không vi phạm điều kiện của View
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Sinh viên này không thuộc khoa IT hoặc không đăng ký môn Database Systems (C00001)';
    END IF;

END //

DELIMITER ;

-- Nếu p_NewScore > 10 → gán lại = 10
SET @score = 11.5;
CALL UpdateScore_IT_DB('S00005', @score);
SELECT @score AS Diem_sau_cap_nhat;   

-- Cập nhật điểm thông qua View View_IT_Enrollment_DB
SELECT * FROM View_IT_Enrollment_DB WHERE StudentID = 'S00005';

-- Hiển thị lại giá trị điểm mới
SET @score2 = 8.0;
CALL UpdateScore_IT_DB('S00003', @score2);  



