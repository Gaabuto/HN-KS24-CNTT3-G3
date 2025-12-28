CREATE DATABASE bai4;
USE bai4;
CREATE TABLE Teacher (
    teacher_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

ALTER TABLE Subject
ADD teacher_id VARCHAR(10) NOT NULL;

ALTER TABLE Subject
ADD CONSTRAINT fk_subject_teacher
FOREIGN KEY (teacher_id)
REFERENCES Teacher(teacher_id);
