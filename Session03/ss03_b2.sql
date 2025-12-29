-- Tạo bảng Student
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE
);

-- Thêm dữ liệu sinh viên
INSERT INTO Student (student_id, full_name, date_of_birth, email)
VALUES
(1, 'Nguyen Van An', '2002-05-10', 'an.nguyen@gmail.com'),
(2, 'Tran Thi Binh', '2001-09-22', 'binh.tran@gmail.com'),
(3, 'Le Hoang Cuong', '2003-01-15', 'cuong.le@gmail.com');

-- Lấy toàn bộ danh sách sinh viên
SELECT * FROM Student;

-- Lấy mã sinh viên và họ tên
SELECT student_id, full_name
FROM Student;
