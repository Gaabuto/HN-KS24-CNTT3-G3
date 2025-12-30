create database Ex04thuchanh;
use Ex04thuchanh;


drop table Enrollment;
drop table Score;
drop table Student;
drop table Course;
drop table Teacher;



CREATE TABLE Student (
    student_id VARCHAR(20) PRIMARY KEY,
    full_name  VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) NOT NULL UNIQUE CHECK (email LIKE '%@%')
);

CREATE TABLE Teacher (
    teacher_id VARCHAR(20) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE CHECK (email LIKE '%@%')
);

CREATE TABLE Course (
    course_id VARCHAR(20) PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    description TEXT,
    total_sessions INT NOT NULL CHECK (total_sessions > 0),
    teacher_id VARCHAR(20) NOT NULL,

    FOREIGN KEY (teacher_id)
        REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollment (
    student_id VARCHAR(20),
    course_id VARCHAR(20),
    enroll_date DATE NOT NULL,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
        REFERENCES Student(student_id),

    FOREIGN KEY (course_id)
        REFERENCES Course(course_id)
);

CREATE TABLE Score (
    student_id VARCHAR(20),
    course_id VARCHAR(20),
    mid_score DECIMAL(4,2) CHECK (mid_score BETWEEN 0 AND 10),
    final_score DECIMAL(4,2) CHECK (final_score BETWEEN 0 AND 10),

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
        REFERENCES Student(student_id),

    FOREIGN KEY (course_id)
        REFERENCES Course(course_id)
);

-- Phần 2 - Thêm dữ liệu
INSERT INTO Student VALUES
    ('SV01', 'Nguyễn Văn A', '2003-05-10', 'a@gmail.com'),
    ('SV02', 'Trần Thị B', '2003-08-15', 'b@gmail.com'),
    ('SV03', 'Lê Văn C', '2002-11-20', 'c@gmail.com'),
    ('SV04', 'Phạm Thị D', '2003-02-12', 'd@gmail.com'),
    ('SV05', 'Hoàng Văn E', '2002-09-30', 'e@gmail.com');

INSERT INTO Teacher VALUES
   ('GV01', 'Nguyễn Minh H', 'h@gmail.com'),
   ('GV02', 'Trần Văn K', 'k@gmail.com'),
   ('GV03', 'Lê Thị M', 'm@gmail.com'),
   ('GV04', 'Phạm Văn N', 'n@gmail.com'),
   ('GV05', 'Hoàng Thị P', 'p@gmail.com');

INSERT INTO Course VALUES
   ('C01', 'Cơ sở dữ liệu', 'Học về SQL và thiết kế CSDL', 30, 'GV01'),
   ('C02', 'Lập trình Java', 'Java cơ bản đến nâng cao', 40, 'GV02'),
   ('C03', 'Cấu trúc dữ liệu', 'Danh sách, Stack, Queue', 35, 'GV03'),
   ('C04', 'Web cơ bản', 'HTML, CSS, JavaScript', 25, 'GV04'),
   ('C05', 'Python cơ bản', 'Python cho người mới', 20, 'GV05');

INSERT INTO Enrollment VALUES
   ('SV01', 'C01', '2025-01-05'),
   ('SV01', 'C02', '2025-01-06'),
   ('SV02', 'C01', '2025-01-07'),
   ('SV03', 'C03', '2025-01-08'),
   ('SV04', 'C04', '2025-01-09');

INSERT INTO Score VALUES
   ('SV01', 'C01', 7.5, 8.0),
   ('SV01', 'C02', 6.5, 7.0),
   ('SV02', 'C01', 8.0, 8.5),
   ('SV03', 'C03', 7.0, 7.5),
   ('SV04', 'C04', 6.0, 6.5);

-- Phần 3 - Cập nhật dữ liệu
-- 1. Cập nhật email cho sinh viên
UPDATE Student
SET email = 'new_email@gmail.com'
WHERE student_id = 'SV01';

-- 2. Cập nhật mô tả khóa học
UPDATE Course
SET description = 'Khóa học SQL từ cơ bản đến nâng cao'
WHERE course_id = 'C01';

-- 3. Cập nhật điểm cuối kỳ
UPDATE Score
SET final_score = 9.0
WHERE student_id = 'SV01' AND course_id = 'C01';

-- Phần 4 - Xóa dữ liệu
-- 1. Xóa lượt đăng ký không hợp lệ
DELETE FROM Enrollment
WHERE student_id = 'SV04' AND course_id = 'C04';

-- 2. Xóa kết quả học tập tương ứng
DELETE FROM Score
WHERE student_id = 'SV04' AND course_id = 'C04';

-- Phần 5 - Truy vấn dữ liệu
-- 1. Lấy danh sách sinh viên
SELECT *
FROM Student;

-- 2. Lấy danh sách giảng viên
SELECT *
FROM Teacher;

-- 3. Lấy danh sách khóa học
SELECT *
FROM Course;

-- 4. Lấy danh sách các lượt đăng ký học
SELECT *
FROM Enrollment;

-- 5. Lấy danh sách kết quả học tập
SELECT *
FROM Score;