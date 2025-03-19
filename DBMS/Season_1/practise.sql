create database delete1
use delete1
DELETE  delete1


-- Subjects
CREATE TABLE Subjects(
    subject_id INT PRIMARY KEY,
    title VARCHAR(50) NOT NULL
);

-- Teachers
CREATE TABLE Teachers(
    teacher_id INT PRIMARY KEY,
    first_teacher_name VARCHAR(15) NOT NULL,
    last_teacher_name VARCHAR(15)
);

-- Groups
CREATE TABLE Groups(
    group_id INT PRIMARY KEY,
    group_name VARCHAR(15) NOT NULL
);

-- Subject-Teacher Relationship (Many-to-Many)
CREATE TABLE subject_teacher(
    subject_id INT,
    teacher_id INT,
    group_id INT,
    PRIMARY KEY (subject_id, teacher_id, group_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id),
    FOREIGN KEY (group_id) REFERENCES Groups(group_id)
);

-- Students
CREATE TABLE Students(
    student_id INT PRIMARY KEY,
    first_student_name VARCHAR(15) NOT NULL,
    last_student_name VARCHAR(15),
    group_id INT,
    FOREIGN KEY (group_id) REFERENCES Groups(group_id)
);

-- Marks Table
CREATE TABLE Marks(
    marks_id INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    mark_date DATE NOT NULL,
    marks INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- Inserting Data
INSERT INTO Groups VALUES
(1, 'BCE'),
(2, 'BEE-P'),
(3, 'BEE-E'),
(4, 'BEE-T');

INSERT INTO Teachers VALUES
(1, 'Usman', 'Rafiq'),
(2, 'Jehangir', 'Arshad'),
(3, 'Modassir', 'Ishfaq'),
(4, 'Imran', 'Ahmed'),
(5, 'Arsla', 'Khan'),
(6, 'Ahmad', 'Mudassir'),
(7, 'Zaid', 'Ahmed'),
(8, 'Wajeeha', 'Khan'),
(9, 'Moazzam', 'Ali Sahi'),
(10, 'Muhammad', 'Jawad'),
(11, 'Mirza', 'Tariq Humayun'),
(12, 'Abbas', 'Javed'),
(13, 'Bilal', 'Zafar Amin'),
(14, 'Hina', 'Munir'),
(15, 'Muhammad', 'Naeem Awais'),
(16, 'Ikram', 'Ullah Khosa'),
(17, 'Sobia', 'Baig');

INSERT INTO Subjects VALUES
(1, 'Islamic Studies'),
(2, 'Discrete Mathematics'),
(3, 'Linear Algebra'),
(4, 'Digital Logic Design'),
(5, 'Programming Fundamentals'),
(6, 'Engineering Professionalism'),
(7, 'Probability Methods in Engineering'),
(8, 'Signals and Systems'),
(9, 'Electronic Devices and Circuits'),
(10, 'Data Structures and Algorithms'),
(11, 'Computer-Aided Engineering Design'),
(12, 'Control Systems'),
(13, 'Data Communication and Computer Networks'),
(14, 'Microprocessor Systems and Interfacing'),
(15, 'Software Engineering Concepts'),
(16, 'French'),
(17, 'Business Communication Workshop'),
(18, 'Internet of Things'),
(19, 'VLSI Design'),
(20, 'Digital Image Processing'),
(21, 'Game Development'),
(22, 'Machine Learning'),
(23, 'Computer Architecture'),
(24, 'Entrepreneurship');

INSERT INTO Students VALUES
(1, 'Ali', 'Khan', 1),
(2, 'Ahmed', 'Raza', 2),
(3, 'Sara', 'Ali', 3),
(4, 'Fatima', 'Ahmed', 4),
(5, 'Usman', 'Khan', 1);

INSERT INTO subject_teacher VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 3),
(5, 5, 4),
(6, 6, 1),
(7, 7, 2),
(8, 8, 3),
(9, 9, 4),
(10, 10, 1),
(11, 11, 2),
(12, 12, 3),
(13, 13, 4),
(14, 14, 1),
(15, 15, 2),
(16, 16, 3),
(17, 17, 4);

INSERT INTO Marks VALUES
(1, 1, 1, '2023-10-01', 85),
(2, 1, 2, '2023-10-02', 90),
(3, 2, 3, '2023-10-03', 78),
(4, 3, 4, '2023-10-04', 88),
(5, 4, 5, '2023-10-05', 92),
(6, 5, 6, '2023-10-06', 80);





SELECT s.first_student_name + ' ' + s.last_student_name AS student_name, 
       sub.title AS subject_name, 
       m.marks AS obtained_marks,
       CASE 
           WHEN m.marks >= 90 THEN 'A'
           WHEN m.marks >= 80 THEN 'B'
           WHEN m.marks >= 70 THEN 'C'
           WHEN m.marks >= 60 THEN 'D'
           ELSE 'F'
       END AS grade
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
JOIN Subjects sub ON m.subject_id = sub.subject_id
JOIN Subject_Teacher st ON sub.subject_id = st.subject_id
JOIN Teachers t ON st.teacher_id = t.teacher_id
WHERE t.first_teacher_name = 'Zaid' AND t.last_teacher_name = 'Ahmed';



INSERT INTO Marks VALUES
(7, 3, 7, '2023-10-07', 85); -- Student ID 3 now has marks in Subject 7
