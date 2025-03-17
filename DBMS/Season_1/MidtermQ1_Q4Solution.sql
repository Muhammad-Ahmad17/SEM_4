create database midterm;

use midterm;

--Question 2 Solution Starts here ---
create table hotel (hotelNo int, hotelName varchar(100), city varchar(100));
alter table hotel alter column hotelNo integer Not Null;
alter table hotel add primary key(hotelNo);

create table room (roomNo int, hotelNo int, type varchar(100), price int);
alter table room alter column roomNo integer Not Null;
alter table room alter column hotelNo integer Not Null;
alter table room add primary key(roomNo,hotelNo);


create table booking (hotelNo int, guestNo int, dateFrom date, dateTo date, roomNo int);
alter table booking alter column hotelNo integer Not Null;
alter table booking alter column guestNo integer Not Null;
alter table booking alter column dateFrom date Not Null;
alter table booking add primary key(hotelNo, guestNo, dateFrom);

create table guest (guestNo int, guestName varchar(100), guestAddress varchar(500));
alter table guest alter column guestNo int Not Null;
alter table guest add primary key(guestNo);

alter table room add constraint fk_room_hotel Foreign key(hotelNo) references hotel(hotelNo) on delete no action;
alter table booking add constraint fk_booking_hotel Foreign key(hotelNo) references hotel(hotelNo) on delete no action;
alter table booking add constraint fk_booking_guest Foreign key(guestNo) references guest(guestNo) on delete no action;

--Question 2 Solution ends here---------------------------------------------------------------------------------------------------

--Question 4 Solution starts here---------------------------------------------------------------------------------------------------

--A
select h.hotelName,h.city,r.roomNo, r.type, r.price from room r 
join hotel h on h.hotelNo=r.hotelNo
where r.price <40 
order by r.price asc;

--B
select count(hotelNo) from hotel;

--C
update r 
set r.price =1.1 * r.price
from room r
join hotel h on h.hotelNo=r.hotelNo 
where h.hotelName='Avari Hotel'

--D
insert into hotel values (101, 'new hotel', 'lahore');
insert into room values (1,101,'Single', 20), (2,101,'Double', 40);
--E
select avg(price) as average_Price from room;

--F 
select g.guestName, r.roomNo, r.type, r.price
from room r
join hotel h on h.hotelNo=r.hotelNo and h.hotelName='Hilton Hotels'
left join booking b on h.hotelNo = b.hotelNo
left join guest g on g.guestNo=b.guestNo

--G
select r.roomNo as RoomNo_in_HiltonHotel,r.type,r.price 
from room r
join hotel h on r.hotelNo=h.hotelNo and h.hotelName = 'Hilton Hotels'
left join booking b on b.hotelNo=h.hotelNo 
where b.dateFrom is NULL

--H
select sum(r.price) as totalIncome
from booking b
join room r on b.roomNo = r.roomNo and b.hotelNo = r.hotelNo
join hotel h on h.hotelNo = b.hotelNo
where h.hotelName = 'Ritz Hotels' 
  and getdate() between b.dateFrom and b.dateTo;


--I
alter table guest add phoneNo varchar(100)

--J
select distinct h.hotelName
from hotel h
join room r on h.hotelNo = r.hotelNo
where r.price < (select avg(price) from room);

-------Q4 solution ends here----------------------------------------------------------------------------
