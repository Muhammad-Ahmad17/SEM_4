CREATE DATABASE VSCODE;
USE  VSCODE;
/*	CREATION OF TABLES	*/
create table books(
	BookID int primary key,
	Title varchar(50),
	PublishedYear int
);

/*	ALTER THE TABLE	*/

-- BY ADDING ATTRIBUTES ==> add
alter table books 
add Author varchar(50)

-- BY DROPING ATTRIBUTES ==> drop 
alter table books 
drop column PublishedYear

-- BY ADDING ATTRIBUTES WHICH NEVER BE NULL ==> add , not null 
alter table books 
add Seasons varchar(50) not null

/*CHANGING DATA TYPE OF ATTRIBUTE*/
alter table books 
alter column Seasons int /* not null */ -- MENTION AGAIN IF ALTERING DATATYPE


/*	INSERTING DATA INTO TABLES	*/
-- DEFAULT SEQUENCE
insert into books
values (1,'Introduction to SQL','Ahmad',02)
-- CUSTOMISED SEQUENCE
insert into books (Title,Author,BookID,Seasons)
values ('Advance Database','Zexu',2,06)
-- OPTIONAL ATTRIBUTES SELECTIONS 
insert into books (Title,BookID)
values ('Advance Database',3)

select * from books

/*-------------------------------------------------------------------------*/
-- ADD PRICING ATTRIBUE AND UPDATE EXISTING COLOUNM
ALTER TABLE books
ADD Price DECIMAL(5, 2);

--
update books
set Price = 19.99
where BookID = 1

update books
set Price = 11.99
where BookID = 2

update books
set Price = 91.99
where BookID = 3

-- adding new book
insert into books
values (4,'Introduction to SQL','Ahmad',02,59.54)
--
/*-------------------------------------------------------------------------*/

/*	MORE ABOUT SELECT	*/

-- all data 
select * from books
-- specific data 
select Title from books
-- specific data after some maniplation
select Price/2 from books
select max (Price) from books
-- distinct (remove duplicate)
select distinct Title from books
-- count 
select count (BookID) from books
-- sum
select sum (Price) from books
-- average
select avg (Price) from books
select * from books
-- top x 
select top(2) * from books

--concatinate tw attribute like first and last name (if any one of the attribute is null the overall result is null)
select Title + '_' + Author from books

/*	AS(for changing name)	*/
select Title + '_' + Author as newName from books



DROP TABLE books;
