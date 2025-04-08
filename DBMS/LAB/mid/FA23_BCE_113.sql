create database mid_exam
use mid_exam

create table students(
	student_id int primary key,
	name varchar(30) not null,
	department varchar(30) not null,
	enrollment_date date
)
---
create table courses(
	course_id int primary key,
	course_name varchar(30) not null,
	credit_hours int not null
)
----

create table enrollments (
	student_id int unique not null,
	course_id int unique not null
)
--altering for adding foriegn key constraint 
alter table enrollments
add constraint fk_student_id foreign key (student_id) references students(student_id)

alter table enrollments
add constraint fk_course_id foreign key (course_id) references courses(course_id)

-- TASK1 
	-- a
 insert into students 
values
(1,'Ahmad','CS','04-08-2021'),
(2,'Ali','EE','04-08-2021'),
(3,'Hassan','CE','04-08-2021'),
(4,'Usman','SE','04-08-2021');

insert into courses
values
(1,'DIP',4),
(2,'Databases',3),
(3,'DSA',3),
(4,'OOP',4)

insert into enrollments
values
(1,3),
(2,4),
(3,1),
(4,2)

select * from students
select * from courses
select * from enrollments


	-- b
	update students 
	set name = 'updatedName'
	where department = 'CS' 
			and 
		enrollment_date = '2022-01-01'
	
	-- c
	truncate table courses
	where credit_hours < 3;

	
-- TASK2
	--a
select avg(credit_hours) [average credit_hours]
from courses;
	--b
select getdate() [current system date];
	--c
select upper(course_name) [upper course_name] 
from courses


-- TASK3
	-- a
select name 
from students
where name like 's%' -- change s to a for compatibale records
	--b
select * 
from students 
where enrollment_date between '2021-01-01' and '2023-12-31';
	--c
select *
from students 
where department = 'CS'
			or
	department = 'EE'
	--d
select course_id,course_name 
from courses
where course_name like '%data%' 


-- TASK4
	--a
alter table students 
add email varchar(34) 

alter table students
add constraint uk_email unique(email)

	--b
create table departments (
	dept_id int primary key,
	dept_name varchar(30) unique not null
)
alter table students
add constraint fk_dept_name foreign key (department) references departments(dept_name)

--TASK5
	-- a
select s.name , c.course_name
from students s
join enrollments e on e.student_id = s.student_id
join courses c on c.course_id = e.course_id

	-- b
select s.name , c.course_name
from students s
left join enrollments e on e.student_id = s.student_id
join courses c on c.course_id = e.course_id
	-- c
select max(c.course_id) [multiple enroll of courses]
from students s
left join enrollments e on e.student_id = s.student_id
join courses c on c.course_id = e.course_id
group by c.course_id having count(*) > 1

--TASK6
--a
select * from students 
where student_id > (
		select avg(student_id) from students
)

--b
select name from students group by department having count(*) > 1

--c
select course_name from courses 
group by department having count(*) > 1

