-- task-00

use ahmad_db

create table studentRecord(
	Name varchar(50),
	regNo int primary key,
	Courses varchar(50),
	courseCode int,
	offeredBy varchar(50)
);

-- task-01
--single record with default sequence
insert into studentRecord
values ('Ali' ,01 ,'DIP' ,1001 ,'Mr. A')
--multiple record with default sequence
insert into studentRecord
values ('Basit', 02 ,'DBMS', 1002, 'Mr. X'),
	   ('Akram', 03 ,'OS' , 1003, 'Mr. Y'),
	   ('Asad' ,04 ,'DBMS', 1002 ,'Mr. X'),
	   ('Zeeshan', 05 ,'DIP', 1001, 'Mr. A'),
	   ('Muneer', 06, 'OS', 1003 ,'Mr. Y'),
	   ('Shafqat', 07 ,'NM', 1004 ,'Mr. H'),
	   ('Ahsan' ,08, 'OS', 1003, 'Mr. Y' ),
	   ('Ikram', 09 ,'DIP' , null,null)

-- single record with customized sequence
insert into studentRecord(Name,regNo)
values ('Hassan', 10)


-- task-02
-- update apna record
-- set (nmae='newnaem', ...)
-- where id is x
update studentRecord
set Courses = 'DIP',courseCode  = 1001, offeredBy = 'Mr. A'
where name = 'Ikram';

update studentRecord
set Courses = 'DSP',courseCode = 1005,offeredBy = 'Mr. Z'
where name = 'Hassan';

-- task-03
delete from studentRecord
where Name in ('Akram', 'Ahsan');

delete from studentRecord
WHERE courseCode = 1001;

-- task-04
SELECT DISTINCT Courses,courseCode,offeredBy FROM studentRecord

-- task-05
SELECT * FROM studentRecord ORDER 
BY Name DESC 

select * from studentRecord
