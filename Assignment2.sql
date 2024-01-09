-- Assignment #2 

select *
from petowners;

select*
from pets;

select *
from proceduresdetails;


select*
from procedureshistory;

-- Q1 proceduresdetails
select po.Name as owner_name, p.Name as pet_name
from petowners as po
left join pets as p
on p.ownerid=po.ownerid;


-- Q2

select po.Name as owner_name, p.Name as pet_name
from pets as p
left join petowners as po
on p.ownerid=po.ownerid;


-- Q3

select po.Name as owner_name , p.Name as pet_name
from pets as p
left join petowners as po
on p.ownerid=po.ownerid
UNION 
select po.Name as owner_name, p.Name as pet_name
from petowners as po
left join pets as p
on p.ownerid=po.ownerid;

-- Q4

SELECT po.Name AS owner_name, p.Name AS pet_name, pd.description AS procedure_description, pd.price
FROM pets AS p
inner JOIN petowners AS po ON p.ownerid = po.ownerid
LEFT JOIN procedureshistory AS ph ON ph.PetID = p.PetID
LEFT JOIN proceduresdetails AS pd ON pd.ProcedureType = ph.ProcedureType and ph.proceduresubcode=pd.proceduresubcode;


-- Q5
select po.Name as owner_name, count(p.kind) as number_of_dogs
from petowners as po
join pets as p on p.ownerid=po.ownerid
where p.kind = "Dog"
group by po.Name;


-- Q6
select p.Name as pet_name,  ph. petid as pet_id, ph.proceduretype
from pets as p
left join procedureshistory as ph
on p.petid=ph.petid
where ph.petid is NULL;

-- Q7

select Name as pet_name, max(Age) as oldest_pet_age_in_years
from pets 
group by pet_name
order by oldest_pet_age_in_years desc
limit 1;

-- Q8
select p.Name, p.PetID, pd. Price
from pets as p
left join  procedureshistory as ph on ph.PetID= p.PetID
left join proceduresdetails as pd on pd.procedureType= ph.ProcedureType and ph.proceduresubcode=pd.proceduresubcode
where  pd.Price > (Select avg(pd2.Price) from proceduresdetails as pd2);
 

-- Q9

select p.Name, p.PetID, pd.ProcedureType, pd.proceduresubcode, pd.description 
from pets as p
left join  procedureshistory as ph on ph.PetID= p.PetID
left join proceduresdetails as pd on pd.procedureType= ph.ProcedureType and ph.proceduresubcode=pd.proceduresubcode
where p.Name = 'Cuddles';


-- Q10

select po. Name, sum(pd.price) as Total_cost 
from petowners as po
left join pets as p on p.ownerid=po.ownerid
left join procedureshistory as ph on ph.petid= p.petid
left join proceduresdetails as pd on pd.proceduretype=ph.proceduretype 
and pd.proceduresubcode=ph.proceduresubcode
group by po.Name
having sum(pd.price) > (SELECT avg(pd2.price)
 from proceduresdetails as pd2); 

 
 
 -- Q11
 
 select p.Name, ph.PetID, ph.proceduretype
from pets as p
left join  procedureshistory as ph on ph.PetID= p.PetID
where ph.proceduretype= 'VACCINATIONS';

-- Q12

select po.Name, ph.proceduretype
from petowners as po left join pets as p on p.ownerid= po.ownerid
join  procedureshistory as ph on ph.petid= p.PetID and 
 ph.proceduretype= 'EMERGENCY';
 
 -- Q13
 
select po.Name as owner_name, sum(pd. price) as Total_cost
from petowners as po left join pets as p on p.ownerid= po.ownerid
left join  procedureshistory as ph on ph.PetID= p.petid
left join proceduresdetails as pd on pd.proceduretype=ph.proceduretype and pd.proceduresubcode=ph.proceduresubcode
group by po.Name;


-- Q14

select kind, count(*) as Number_of_pets
from pets
group by kind;

-- Q15

select kind, gender, count(*) as number_of_pets 
from pets
group by kind, gender;

-- Q16

select kind, avg(age) as Avg_age
from pets
group by kind
having count(*) > 5;

-- Q17

select ProcedureType, avg(Price) as Avg_cost 
from proceduresdetails 
group by ProcedureType, Price
Having Avg(price) > 50;


-- Q18

select PETID, NAME, Age,
case
when age < 3 then 'Young'
when  age <= 8 and age >= 3 then 'Adult'
else 'Senior'
end as pets_classification
from pets;

-- Q19

select po.ownerid, po. Name, sum(pd.price) as total_spending,
case 
when sum(pd.price)< 100 then 'Low Spender' 
when sum(pd.price) >=100 and sum(pd.price) <=500 then 'Moderate Spender'
else 'High Spender'
end as label
from petowners as po 
left join pets as p on po.ownerid=p.ownerid
inner join procedureshistory as ph on p.PetID=ph.PetID
inner join proceduresdetails as pd on ph.proceduretype=pd.proceduretype
group by po.ownerid, po.Name, pd. price;

-- Q20 

select Name, Gender,
case when Gender = 'Female' then 'Girl'
else 'Boy'
end as custom_label
from pets;

-- Q21
select p.Name, count(ph.petid) as number_of_procedures,
case
when count(ph.petid) >=1 and count(ph.petid)<=3 then 'Regular'
when count(ph.petid) >=4 and count(ph.petid) <= 7 then 'Frequent'
when count(ph.petid) > 7 then 'Super User'
else 'No procedures'
end as status_label
from pets as p left  join procedureshistory as ph on p.petid=ph.petid 
group by p.name;

-- Q22

select Name, kind, Age,
rank() over(partition by kind order by Age asc)as pets_rank
from pets;

-- Q23

select Name, kind, Age,
dense_rank() over(order by Age asc)as pets_rank
from pets;

-- Q24

select petid, name,
lead(name) over ( order by Name asc) as next_pet_name,
lag(name) over (order by name asc) as previous_pet_name
from pets ;

-- Q25

select name, avg(age) over (partition by kind) as Avg_age
from pets;

-- Q26

WITH pets as ( select Name, Age, Kind from pets)
select Name, Age, Kind
from pets
where Age > 5;
