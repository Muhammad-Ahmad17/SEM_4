use superhero;



use DEL


-- TASK 1 Which super hero Weighs the Most
select superhero_name, weight_kg from superhero
where weight_kg = (select max(weight_kg) from superhero);

select top 1 superhero_name, weight_kg from superhero
order by weight_kg

--  TASK 2 WHICH SUPER HERO HAS SECOND HIGHEST WEIGHT
select superhero_name, weight_kg 
from superhero
where weight_kg = (
    select max(weight_kg)
    from superhero
    where weight_kg < (
        select max(weight_kg)
        from superhero
        )
);


-- TASK 3 REAL NAMES OF SUPER HEROS INCLUDE 'batman' in ther super hero name
select  full_name from superhero
where superhero_name like '%batman%'

--TASK 4 GENDER OF Bruce Wayne
select superhero_name,g.gender from superhero
join gender g on superhero.gender_id= g.id
where full_name = 'Bruce Wayne';-- Abe Sapien

-- TASK 5 AVG HEIGHT OF SUPERHEROS
SELECT avg(height_cm) FROM superhero

-- TASK 6 COUNT OF TALLER THEN AVERAGE SUPERHEROS
select count(superhero_name) from superhero
where height_cm > ( SELECT avg(height_cm) FROM superhero )

-- TASK 7 COMIC NAME. REAL NAME , HEIGHT OF THOSE TALLER THEN AVGEAGE STORED ALPHABETICALLY
select superhero_name,full_name,height_cm from superhero
where height_cm > ( SELECT avg(height_cm) FROM superhero )
order by (superhero_name);

-- TASK 8  HAIR COLOUR EYE COLOUR SKIN COLOUR OF THOSE HAVING SUPERMAN IN THEIR SUPERHERO NAME
select C.COLOUR, superhero_name FROM superhero S
JOIN colour C ON S.hair_colour_id = C.id
where superhero_name like '%superman%'

-- TASK 9 SUPERPOWERS OF Brce Wayne
select s.superhero_name, power_name from superpower
join hero_power on hero_power.power_id = superpower.id
join superhero s on s.id = hero_power.hero_id
where s.full_name = 'Bruce Wayne'

-- TASK 10 ATTRIBUTES AND VALUE / SCORES OF 'batman II'
select s.superhero_name e, a.attribute_name, attribute_value from hero_attribute
join attribute a on hero_attribute.hero_id  = a.id
join superhero s on s.id = hero_attribute .hero_id
where s.superhero_name = '3-D Man';

select * from superhero

-- Task 11 additional data for publisher --------- alter and add attributes in publisher table
Alter table  publisher
add Complete_address varchar(50),
    street_no int,block varchar(50),
    city varchar(50),
    postal_code int;

-- TASK 12 MULTIPLE PHONE NUMBERS FOR ONE PUBLISHER ----CREATE TABLE PHINE NUMBER
CREATE TABLE PHONE_NUMBERS (
 ID INT,
 PH_NUMBER INT UNIQUE,
 CONSTRAINT  FK_PUBLISHER_ID FOREIGN KEY ID  REFERENCES publisher(ID)
 );


