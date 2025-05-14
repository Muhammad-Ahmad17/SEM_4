	-- FA23-BCE-113 --
   -- Muhammad Ahmad --
	-- Assignment 2 --

use superhero

-- 1.	Which superhero weighs the most?								        (1)
select 
	id , 
	superhero_name,
	weight_kg
from 
	superhero 
where 
	weight_kg = (
		select max(weight_kg) from superhero  
	);
	  
-- 2.	Which superhero has the second highest weight?									(2)
select 
	id , 
	superhero_name,
	weight_kg
from 
	superhero 
where 
	weight_kg = (
		select max(weight_kg) from superhero where 
		weight_kg < (
			select max(weight_kg) from superhero
		)
	);
	  
-- 3.	What are the real names of all characters that include 'batman' in their superhero name		        (2)
select 
	full_name [real name], 
	superhero_name [superhero name]
from 
	superhero
where 
	superhero_name like '%batman%'
	
-- 4.	What is the gender of Bruce Wayne?								        (3)

select 
	s.full_name [real name], 
	s.superhero_name [superhero name],
	g.gender
from 
	superhero s
join 
	gender g on g.id = s.gender_id
where
	--s.superhero_name = 'Bruce Wayne'
	s.full_name = 'Bruce Wayne'

-- 5.	What is the average height of all superhero characters included in the database			        (2)
select 
	avg(height_cm) [avg height(cms)]
from 
	superhero
	
-- 6.	Provide the count of superhero characters who are taller than average				        (3)
select 
	count(*) as [total count] 
from 
	superhero
where 
	height_cm > (
		select avg(height_cm) [avg height(cms)] from superhero
	)
	
-- 7.  Provide superhero’s  comic names and real names along with the height of superhero characters who are taller than average, sorted alphabetically (a-z)							        (4)
select 
	superhero_name [superhero name],
	full_name [real name], 
	height_cm
from 
	superhero
where 
	height_cm > (
		select avg(height_cm) [avg height(cms)] from superhero
	)
order by 
	superhero_name;

-- 8.	Provide the hair color, eye color and skin color of all characters that have 'Superman' in their superhero name

select 
	superhero_name [superhero name],
	c1.colour [eye colour],
	c2.colour [hair colour],
	c3.colour [skin colour]
from
	superhero s
join 
	colour c1 on c1.id = s.eye_colour_id
join 
	colour c2 on c2.id = s.hair_colour_id
join 
	colour c3 on c3.id = s.skin_colour_id
where
	superhero_name like '%Superman%'

--  9.	What are the superpowers of Bruce Wayne?
select sp.power_name from superhero s
join hero_power hp on hp.hero_id = s.id
join superpower sp on sp.id =hp.power_id
where --superhero_name = 'Bruce Wayne'
	 full_name = 'Bruce Wayne'
	 
-- 10.	What are the attributes and their values/scores for the superhero named 'batman II'		        (2)
--values/scores == ?
select distinct a.attribute_name from superhero s
join hero_attribute ha on ha.hero_id = s.id
join attribute a on a.id = ha.attribute_id	
where superhero_name like '%batman II%'

-- 11.	Some additional data for the publisher needs to be maintained that includes a complete address including street number, block, city and postal code. Explain the  changes would be necessary to be made to the given ERD. Write SQL statements to implement the changes.						        (4)

alter table publisher
add street_number int ,
	[block] varchar(20),
	city varchar(20),
	postal_code int 

select * from publisher

-- 12.	Another requirement has popped up for publisher data. Make changes so that multiple phone numbers can be maintained for publishers. Explain the changes that would be necessary to be made to the given ERD. Write SQL statements to implement the changes.							        (4)


alter table publisher
add phone_id int UNIQUE

create table phones(
	id int primary key,
	phone_number int 
)

SELECT * FROM phones

alter table phone
add constraints fk_phone_id foreign key (id) references publisher(phone_id)

-- note: 
	-- since we already inserted data in superhero so we dont add not null
	-- constraint on phone_id thats why we are unable to make foreign key
	-- relation 