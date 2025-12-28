
CREATE DATABASE bai2;
USE bai2;


CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL
);


CREATE TABLE Subject (
    subject_id VARCHAR(10) PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    CONSTRAINT chk_credits CHECK (credits > 0)
);