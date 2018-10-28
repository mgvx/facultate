/*
	terrorists groups and leaders
*/
use Terrorism
select g.name, t.name
from Terrorists as t 
inner join Groups as g on g.id = t.group_id
where t.group_leader = 1
/*
	how many members each group has ordered by number
*/
use Terrorism
select g.name, count(*) as members
from Terrorists as t 
inner join Groups as g on g.id = t.group_id
group by g.name
order by members desc
/*
	terrorists acts commited by each terrorist in attacks after year 2000
*/
use Terrorism
select distinct t.name as terrorist, a.participation as act, i.attack_type as attack
from Terrorists as t
inner join Attacks as a on t.id = a.terrorist_id
inner join Incidents as i on a.incident_id = i.id
where i.date  >= '2000-01-01'
/*
	media publication of incidents and terrorists that participated
*/
use Terrorism
select i.attack_type as attack, s.publication, s.media_type as outlet, t.name as terrorist
from Terrorists as t
inner join Attacks as a on t.id = a.terrorist_id
inner join Incidents as i on a.incident_id = i.id
inner join Sources as s on s.incident_id = i.id
where s.publication is not null
/*
	popular crimes during attacks
*/
use Terrorism
select a.participation, count(a.participation) as times
from Attacks as a
inner join Incidents as i on a.incident_id = i.id
group by a.participation
having count(a.participation) > 1
order by times desc
/*
	most attacked country
*/
use Terrorism
select Top 1 (i.country), count(i.country) as incidents
from Incidents as i
inner join Attacks as a on a.incident_id = i.id
inner join Terrorists as t on t.id = a.terrorist_id
group by i.country
/*
	groups whose members spend dollars
*/
use Terrorism
select distinct g.name
from Terrorists as t
inner join Spendings as s on t.id = s.terrorist_id
inner join Groups as g on g.id = t.group_id
where s.currency = 'dollar'
/*
	Terorrists who spend the most
*/
use Terrorism
select t.name, sum(s.sum) as spending
from Terrorists as t
inner join Spendings as s on t.id = s.terrorist_id
group by t.name
having sum(s.sum) > 500
order by spending desc
/*
	Organization Motivation behind most shooting attacks
*/
use Terrorism
select g.motivation
from Groups as g
inner join Terrorists as t on g.id = t.group_id
inner join Attacks as a on t.id = a.terrorist_id
inner join Incidents as i on i.id = a.incident_id
where i.attack_type = 'shooting'
group by g.motivation
having count(*) > 1