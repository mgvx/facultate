-- 1
Begin Transaction

Select * from Terrorists 
where id between 1000 and 2000

waitfor delay '00:00:10'

Select * from Terrorists 
where id between 1000 and 2000

Commit Transaction