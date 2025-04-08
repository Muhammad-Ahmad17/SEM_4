--||||||||||||||||||||||||||||||||||||||||||||||||||
use DEL;
create table hotel (
	hotelNo int,
	hotelName varchar(50),
	city varchar(20)
);
alter table hotel 
alter column hotelNo int not null;

alter table hotel 
add constraint pk_hotelNo primary key(hotelNo);

--||||||||||||||||||||||||||||||||||||||||||||||||||

create table room (
	roomNo int ,
	[type] varchar(20) ,
	price int ,
	hotelNo int 
);
alter table room
alter column roomNo int not null
alter table room
alter column hotelNo int not null;

alter table room 
add constraint pk_roomNo primary key(roomNo);
alter table room 
add constraint fk_hotelNo foreign key(hotelNo) references hotel(hotelNo) on delete no action;

--||||||||||||||||||||||||||||||||||||||||||||||||||

create table booking (hotelNo int, guestNo int, dateFrom date, dateTo date, roomNo int);
alter table booking alter column hotelNo integer Not Null;
alter table booking alter column guestNo integer Not Null;
alter table booking alter column dateFrom date Not Null;
alter table booking add primary key(hotelNo, guestNo, dateFrom);

alter table booking add constraint fk_bookingHotel Foreign key(hotelNo) references hotel(hotelNo) on delete no action;

--||||||||||||||||||||||||||||||||||||||||||||||||||

create table guest (guestNo int, guestName varchar(100), guestAddress varchar(500));
alter table guest alter column guestNo int Not Null;
alter table guest add primary key(guestNo);

alter table booking add constraint fk_boookingGuest Foreign key(guestNo) references guest(guestNo) on delete no action;

--||||||||||||||||||||||||||||||||||||||||||||||||||


--Q3_B
--a
select * 
from room
where price < 50
--b
select r.[type] , r.price
from room r
join hotel h on h.hotelNo = r.hotelNo
where h.hotelName = 'Ritz Hotel';

--Q4
--a
select * 
from room 
where price < 900
		and
	([type] = 'Double' 
		or 
	[type] = 'Family')

--b
select count (*) hotels from hotel 

--c
UPDATE r 
SET Price = Price * 1.1
from room r
join hotel h on h.hotelNo = r.hotelNo
WHERE h.hotelName = 'Avari Hotel'

--d 
insert into hotel 
values
(4, 'New Hotel', 'New Location');
insert into room 
values
(7, 'single' , 45 , 4),
(8, 'double' , 95 , 4);

--e
select avg (price) [avg price] from room 

--f
SELECT 
    g.guestName,
    r.roomNo,
    r.type,
    r.price
FROM Hotel h
JOIN Room r ON h.hotelNo = r.hotelNo
JOIN Booking b ON r.hotelNo = b.hotelNo AND r.roomNo = b.roomNo
JOIN Guest g ON b.guestNo = g.guestNo
WHERE h.hotelName = 'Hilton Hotel';

-- g 






















INSERT INTO Hotel VALUES 
(1, 'Avari Hotel', 'Lahore'),
(2, 'Ritz Hotel', 'Karachi'),
(3, 'Hilton Hotel', 'Islamabad');


INSERT INTO Guest VALUES 
(101, 'Ali Khan', 'Lahore'),
(102, 'Sara Malik', 'Karachi'),
(103, 'John Doe', 'Islamabad');


INSERT INTO Room (roomNo, hotelNo, type, price) VALUES 
(1, 1, 'Single', 60),   -- roomNo, hotelNo, type, price
(2, 1, 'Double', 45),
(3, 2, 'Single', 30),
(4, 2, 'Family', 35),
(5, 3, 'Suite', 80),
(6, 3, 'Double', 50);


INSERT INTO Booking (hotelNo, roomNo, guestNo, dateFrom, dateTo)
VALUES 
(1, 1, 101, '2024-10-01', '2024-10-03'),
(2, 1, 102, '2024-10-02', '2024-10-05'),
(3, 1, 103, '2024-10-03', '2024-10-04');

select * from hotel 
select * from guest
select * from room 
select * from booking;