CREATE DATABASE bai3;
USE bai3;
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
