--Create a table cars 
create table cars
(
	model_id		int primary key,
	model_name		varchar(100),
	color			varchar(100),
	brand			varchar(100)
);

--Insert values to the tables
insert into cars values(1,'Leaf', 'Black', 'Nissan');
insert into cars values(2,'Leaf', 'Black', 'Nissan');
insert into cars values(3,'Model S', 'Black', 'Tesla');
insert into cars values(4,'Model X', 'White', 'Tesla');
insert into cars values(5,'Ioniq 5', 'Black', 'Hyundai');
insert into cars values(6,'Ioniq 5', 'Black', 'Hyundai');
insert into cars values(7,'Ioniq 6', 'White', 'Hyundai');

--Check the table contents
select * from cars;
--1) Delete Duplicate values from the table
--Solution 1
delete from cars
where model_id not in (select min(model_id) 
						from cars 
						group by model_name, brand);
--Now checking the table
select * from cars;


--Solution 2
delete from cars
where model_id not in (select model_id
						from (select *
						, row_number() over(partition by model_name, brand order by model_id) as rn
						from cars) x
						where x.rn > 1);


