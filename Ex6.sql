CREATE DATABASE bai6;
USE bai6;
CREATE DATABASE TrainingManagement;
USE TrainingManagement;

CREATE TABLE Class (
    class_id VARCHAR(10) PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    school_year VARCHAR(9) NOT NULL
);

CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    class_id VARCHAR(10) NOT NULL,

    CONSTRAINT fk_student_class
        FOREIGN KEY (class_id)
        REFERENCES Class(class_id)
);

CREATE TABLE Teacher (
    teacher_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Subject (
    subject_id VARCHAR(10) PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    teacher_id VARCHAR(10) NOT NULL,

    CONSTRAINT chk_credits CHECK (credits > 0),

    CONSTRAINT fk_subject_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollment (
    student_id VARCHAR(10) NOT NULL,
    subject_id VARCHAR(10) NOT NULL,
    enrollment_date DATE NOT NULL,

    PRIMARY KEY (student_id, subject_id),

    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id)
        REFERENCES Student(student_id),

    CONSTRAINT fk_enrollment_subject
        FOREIGN KEY (subject_id)
        REFERENCES Subject(subject_id)
);

CREATE TABLE Score (
    student_id VARCHAR(10) NOT NULL,
    subject_id VARCHAR(10) NOT NULL,
    process_score DECIMAL(3,1) NOT NULL,
    final_score   DECIMAL(3,1) NOT NULL,

    PRIMARY KEY (student_id, subject_id),

    CONSTRAINT chk_process_score CHECK (process_score BETWEEN 0 AND 10),
    CONSTRAINT chk_final_score   CHECK (final_score   BETWEEN 0 AND 10),

    CONSTRAINT fk_score_student
        FOREIGN KEY (student_id)
        REFERENCES Student(student_id),

    CONSTRAINT fk_score_subject
        FOREIGN KEY (subject_id)
        REFERENCES Subject(subject_id)
);
