create database delete1
use delete1


create table employee(
	emp_id INT, 
	emp_name VARCHAR(20),
	emp_department VARCHAR(20)
);

insert into employee 
values (1,'ali',1),(2,'ahamd',2);

insert into department 
values (1,1),(2,2)


alter table employee
add constraint fk_empDep foreign key (emp_department) references department(dep_name)

alter table employee 
alter column emp_id INT NOT NULL
alter table employee
add constraint pk_empId PRIMARY KEY (emp_id)


select * from employee

select * from department

select emp_name,count(*)   from employee
group by emp_department



alter table employee 
alter column emp_department INT NOT NULL;
--------------------------------------------------
create table department(
	dep_id INT,
	dep_name VARCHAR(20)
);

alter table department 
alter column dep_id INT NOT NULL;

alter table department
add constraint fk_depID PRIMARY KEY (dep_id);


alter table department
drop constraint fk_depID 

alter table department 
alter column dep_name INT NOT NULL;

alter table department
add constraint pk_depname PRIMARY KEY (dep_name);
