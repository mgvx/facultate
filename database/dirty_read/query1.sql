--1

select * from Terrorists

Begin Tran
update Terrorists set name = 'RENAMED'
where id = 26

Waitfor Delay '00:00:10'
Rollback transaction