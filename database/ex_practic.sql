Use tessst
go

drop table concerte
drop table bands
drop table guests
drop table tents
drop table caterers
go

create table caterers
	(catid int primary key identity(1,1),
	name varchar(58),
	cataddress varchar(100),
	veg bit)

create table tents
	(tentid int primary key identity(1,1),
	name varchar(58),
	capacity integer,
	catid int foreign key references caterers(catid))
	
create table guests
	(guestid int primary key identity(1,1),
	name varchar(58),
	age integer,
	tentid int foreign key references tents(tentid))
	
create table bands
	(bandid int primary key identity(1,1),
	name varchar(58),
	genre varchar(100),
	fee integer)

create table concerte
	(
	tentid int foreign key references tents(tentid),
	bandid int foreign key references bands(bandid),
	starttime time,
	endtime time,
	primary key(tentid,bandid))

go



insert caterers(name,cataddress,veg) values ('c1','a2',1),('c1','a2',0)
insert tents(name,capacity,catid) values ('t1',100,1),('t2',100,1),('t3',100,2)
insert bands(name,genre,fee) values ('phe','rocl',2000),('met','rock',3000),('gg','rocl',5000)
insert concerte(tentid,bandid,starttime,endtime) values (1,1,'10:00','11:00'),(1,2,'11:00','12:00 PM'),
														(1,3,'13:00','14:00'),(2,2,'14:00','17:00'),
														(3,2,'13:00','14:00'),(3,3,'14:00','17:00')



go
create proc handleconcerte @f int, @t time, @f1 int
as
	if not exists(select * from bands where fee >@f)
		update bands
		set fee=fee+@f1
	else
		delete
		from concerte
		where bandid in ( select bandid from bands where fee>@f)
				and endtime<@t
go

exec handleconcerte @f=250000, @t='18:00',@f1=2233

go
drop view expensive
create view expensive
as
	select name
	from tents where tentid in (select c.tentid
								from concerte c inner join bands b on c.bandid = b.bandid
								group by c.tentid
								having sum(b.fee) >=300000)

go
create function gettents(@c int, @veg bit)
returns table
as
	return select name
	from tents t
	where t.catid in (select catid from caterers where veg = @veg)
		and t.tentid in (select tentid
						from concerte
						group by tentid
						having count(*) >= @c) 
go

select * from gettents(2,0)

go
select * from tents
select * from bands
select * from concerte
select * from caterers

select * from expensive
