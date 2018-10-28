--1

Begin Transaction
Select * from Terrorists where id = 26

waitfor delay '00:00:10'
Select * from Terrorists where id = 26
Commit Transaction