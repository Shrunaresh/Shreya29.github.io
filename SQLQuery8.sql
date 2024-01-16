--Defining the table
create table business_city (
							business_date date,
							city_id int
							);
select * from business_city;
--Data Insertion and Population
insert into business_city values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),
(cast('2021-02-03' as date),19) ,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12);

--Utilizing a SQL query to track the annual growth of new cities in given network that is considered as a critical metric for any growing business. 
select [year] , count(new_city) as new_cities from (
select datepart(year,business_date) as [year] , row_number() over(partition by city_id order by datepart(year,business_date)) as new_city 
from business_city 
) t
where new_city = 1
group by year
--Here the Subquery uses the ROW_NUMBER window function to assign a unique row number to each record within the same city_id partition,
--ordered by the year of business date. The outer query then filters only those rows where the row number is equal to 1, indicating the 
--first occurrence of a city in a given year. Finally, it groups the results by year and counts the number of new cities in each year.