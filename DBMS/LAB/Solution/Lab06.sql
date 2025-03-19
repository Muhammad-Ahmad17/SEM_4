create database lab_06
use lab_06

-----------------------------------TASK 1----------------------
-- Subjets
create table Subjects(
	subject_id int primary key,
	title varchar(50) not null
);
-- Teacher
create table Teachers(
	teacher_id int primary key,
	first_teacher_name varchar(15) not null,
	last_teacher_name varchar(15)
);
-- group
create table Groups(
	group_id int primary key,
	group_name varchar(15) not null
);
-- teacher - subject
create table subject_teacher(
	subject_id int foreign key references Subjects(subject_id),
	teacher_id int foreign key references Teachers(teacher_id),
	group_id int foreign key references Groups(group_id)
	);
-- Students
create table Students(
	student_id int primary key,
	first_student_name varchar(15) not null,
	last_student_name varchar(15),
	group_id int foreign key references Groups(group_id)
);
-- Marks
create table Marks(
	marks_id int primary key,
	student_id int foreign key references Students(student_id),
	subject_id int foreign key references Subjects(subject_id),
	datte Date,
	marks int not null
);
	

-----------------------------------TASK 3----------------------
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


INSERT INTO Subject_Teacher VALUES
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


-----------------------------------TASK 4----------------------
SELECT * FROM Subjects;
SELECT * FROM Students;
SELECT * FROM Groups;

SELECT * FROM Teachers;
SELECT * FROM Subject_Teacher;
SELECT * FROM Marks;



-----------------------------------TASK 5----------------------
select first_student_name + ' ' + last_student_name as student_teacher_names from Students
UNION
select first_teacher_name + ' ' + last_teacher_name from Teachers

-----------------------------------TASK 6----------------------
--inner join
SELECT s.first_student_name + ' ' + s.last_student_name  as students_of_BCE_group, g.group_name
FROM Students s
JOIN Groups g ON s.group_id = g.group_id
WHERE g.group_name = 'BCE';

--
select first_student_name + ' ' + last_student_name students_of_BCE_group  from Students 
where group_id = (select group_id from Groups where group_name = 'BCE');

-----------------------------------TASK 7----------------------
SELECT DISTINCT t.first_teacher_name + ' ' + t.last_teacher_name AS teacher_name 
FROM Teachers t
JOIN Subject_Teacher st ON t.teacher_id = st.teacher_id
JOIN Groups g ON st.group_id = g.group_id
WHERE g.group_name = 'BEE-E';
--WHERE g.group_id = '1';
--
SELECT DISTINCT t.first_teacher_name + ' ' + t.last_teacher_name AS teacher_name
FROM Teachers t
WHERE t.teacher_id IN (
    SELECT st.teacher_id
    FROM Subject_Teacher st
    WHERE st.group_id = (
        SELECT group_id FROM Groups WHERE group_name = 'BEE-E'
    )
);
-----------------------------------TASK 8----------------------
SELECT DISTINCT s.first_student_name + ' ' + s.last_student_name AS student_name, 
                sub.title AS subject_name
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
JOIN Subjects sub ON m.subject_id = sub.subject_id
JOIN Subject_Teacher st ON sub.subject_id = st.subject_id
JOIN Teachers t ON st.teacher_id = t.teacher_id
WHERE t.first_teacher_name = 'Abbas' AND t.last_teacher_name = 'Javed';
---
SELECT DISTINCT s.first_student_name + ' ' + s.last_student_name AS student_name, 
                sub.title AS subject_name
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
JOIN Subjects sub ON m.subject_id = sub.subject_id
WHERE sub.subject_id IN (
    SELECT subject_id FROM Subject_Teacher
    WHERE teacher_id = (SELECT teacher_id FROM Teachers WHERE first_teacher_name = 'Abbas' AND last_teacher_name = 'Javed')
);

-----------------------------------TASK 9----------------------
SELECT DISTINCT sub.title AS subject_studied
FROM Subjects sub
JOIN Marks m ON sub.subject_id = m.subject_id
JOIN Students s ON m.student_id = s.student_id
WHERE s.first_student_name = 'Ali';
--
SELECT DISTINCT title AS subject_studied
FROM Subjects
WHERE subject_id IN (
    SELECT subject_id
    FROM Marks
    WHERE student_id = (
        SELECT student_id FROM Students WHERE first_student_name = 'Ali'
    )
);


-----------------------------------TASK 10----------------------
SELECT sub.title AS subject_name, m.marks AS obtained_marks
FROM Subjects sub
JOIN Marks m ON sub.subject_id = m.subject_id
JOIN Students s ON m.student_id = s.student_id
WHERE s.first_student_name = 'Ali';

-----------------------------------TASK 11----------------------
SELECT t.first_teacher_name + ' ' + t.last_teacher_name AS teacher_name, 
       sub.title AS subject_name, 
       m.marks AS obtained_marks
FROM Teachers t
JOIN Subject_Teacher st ON t.teacher_id = st.teacher_id
JOIN Subjects sub ON st.subject_id = sub.subject_id
JOIN Marks m ON sub.subject_id = m.subject_id
JOIN Students s ON m.student_id = s.student_id
WHERE s.first_student_name = 'Ali';

-----------------------------------TASK 12----------------------
SELECT DISTINCT sub.title AS subject_name
FROM Subjects sub
JOIN Subject_Teacher st ON sub.subject_id = st.subject_id
JOIN Teachers t ON st.teacher_id = t.teacher_id
WHERE t.first_teacher_name = 'Arsla' AND t.last_teacher_name = 'Khan';


-----------------------------------TASK 13----------------------
SELECT s.first_student_name + ' ' + s.last_student_name AS student_name
FROM Students s
JOIN Groups g ON s.group_id = g.group_id
WHERE g.group_name = 'BEE-T';

-----------------------------------TASK 14----------------------
SELECT t.first_teacher_name + ' ' + t.last_teacher_name AS teacher_name
FROM Teachers t
LEFT JOIN Subject_Teacher st ON t.teacher_id = st.teacher_id
WHERE st.subject_id IS NULL;

-----------------------------------TASK 15----------------------
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
