select COUNT(product_id), brand_id
from BikeStores.production.products
group by brand_id;

select * from BikeStores.production.brands;
select * from BikeStores.production.categories;
select * from BikeStores.production.products;
select * from BikeStores.production.stocks;

select * from BikeStores.sales.customers;
select * from BikeStores.sales.order_items;
select * from BikeStores.sales.orders;
select * from BikeStores.sales.staffs;
select * from BikeStores.sales.stores;

select count(store_id), state
from BikeStores.sales.stores
group by state;

select first_name, last_name, email, phone
from BikeStores.sales.customers
order by first_name ASC;

select ss.store_name, sst.first_name, sst.last_name, sst.email
from BikeStores.sales.staffs sst
join BikeStores.sales.stores ss ON sst.store_id=ss.store_id;

ALTER TABLE BikeStores.sales.staffs
ADD Salary INT(20);

UPDATE BikeStores.sales.customers
SET  phone= '4282365223'
WHERE customer_id = 1;

UPDATE BikeStores.sales.staffs
SET Salary= '5200'
WHERE staff_id = 1;
UPDATE BikeStores.sales.staffs
SET Salary= '4800'
WHERE staff_id = 2;
UPDATE BikeStores.sales.staffs
SET Salary= '5100'
WHERE staff_id = 3;
UPDATE BikeStores.sales.staffs
SET Salary= '5420'
WHERE staff_id = 4;
UPDATE BikeStores.sales.staffs
SET Salary= '5280'
WHERE staff_id = 5;
UPDATE BikeStores.sales.staffs
SET Salary= '4750'
WHERE staff_id = 6;
UPDATE BikeStores.sales.staffs
SET Salary= '4340'
WHERE staff_id = 7;
UPDATE BikeStores.sales.staffs
SET Salary= '3920'
WHERE staff_id = 8;
UPDATE BikeStores.sales.staffs
SET Salary= '3000'
WHERE staff_id = 9;
UPDATE BikeStores.sales.staffs
SET Salary= '3500'
WHERE staff_id = 10;

---Aggregate Functions
select avg(Salary)
from BikeStores.sales.staffs;

select count(manager_id)
from BikeStores.sales.staffs;

select manager_id, first_name, last_name, staff_id
from BikeStores.sales.staffs
order by manager_id ASC;

UPDATE BikeStores.sales.staffs
SET manager_id= '3'
WHERE staff_id = 1;

ALTER TABLE BikeStores.sales.stores
ADD cost INT;
UPDATE BikeStores.sales.stores
SET cost= '1000'
WHERE store_id = 1;
UPDATE BikeStores.sales.stores
SET cost= '520'
WHERE store_id = 2;
UPDATE BikeStores.sales.stores
SET cost= '3200'
WHERE store_id = 3;
UPDATE BikeStores.sales.stores
SET cost= '2000'
WHERE store_id = 4;
UPDATE BikeStores.sales.stores
SET cost= '3000'
WHERE store_id = 5;
UPDATE BikeStores.sales.stores
SET cost= '950'
WHERE store_id = 6;

select sum(Salary)
from BikeStores.sales.staffs;

select pb.brand_name, pp.product_name, pp.product_name
from BikeStores.production.brands pb
join BikeStores.production.products pp ON pb.brand_id= pp.brand_id;

--Fetch staffs who earn more than the average salary of all employees
with average_salary as 
		(select avg(Salary) as avg from BikeStores.sales.staffs)
select *
from BikeStores.sales.staffs sst, average_salary avg
where sst.Salary> avg

--Complex queries
--Find Stores hose sales were better than the average sales across all the stores

1) Total Sales across each store

select ss.store_id, sum(cost) as total_sales_per_store
from BikeStores.sales.stores ss
group by ss.store_id


2) Average of all the sales across all the stores

select avg(total_sales_per_store) as avg_sales_of_all_stores
from (select ss.store_id, sum(cost) as total_sales_per_store
		from BikeStores.sales.stores ss
		group by ss.store_id) x

3) Find the stores who total sales is greater than the average sales of all the stores

with Total_sales(store_id, total_sales_per_store) as 
		(select ss.store_id, sum(cost) as total_sales_per_store
		from BikeStores.sales.stores ss
		group by ss.store_id), 
		avg_sales(avg_sales_of_all_stores) as 
		(select avg(total_sales_per_store) as avg_sales_of_all_stores
		from Total_sales)
select * 
from Total_sales ts
join avg_sales av
ON ts.total_sales_per_store>av.avg_sales_of_all_stores;


--SubQuery Usage
select *
from (select ss.store_id, sum(cost) as total_sales_per_store
		from BikeStores.sales.stores ss
		group by ss.store_id) total_sales
join (select avg(total_sales_per_store) as avg_sales_of_all_stores
		from (select ss.store_id, sum(cost) as total_sales_per_store
				from BikeStores.sales.stores ss
				group by ss.store_id) x) avg_sales
	ON total_sales.total_sales_per_store>avg_sales.avg_sales_of_all_stores;

--Find Employees whose salary is more than the average salary earned by all the employees
1) Find the average salary of all employees
2) Filter the employees based no the above result

select avg(Salary) from BikeStores.sales.staffs;

select * 
from BikeStores.sales.staffs
where Salary>(select avg(Salary) from BikeStores.sales.staffs)

--Find the employees who earn the highest salary in each department.
select store_id,max(Salary)
from BikeStores.sales.staffs
group by store_id

select distinct store_name from BikeStores.sales.stores;

--Find Stores whose sales where better than the average sales across all stores
1) Find the total sales for all stores
2) Find the average sales for all stores
select avg(total_sales)
from (select store_name, sum(cost) as total_sales
		from BikeStores.sales.stores
		group by store_name) x
3) Compare 1 & 2

select *
from (select store_name, sum(cost) as total_sales
		from BikeStores.sales.stores
		group by store_name) sales
join (select avg(total_sales) as sales
	from (select store_name, sum(cost) as total_sales
			from BikeStores.sales.stores
			group by store_name) x) as avg_sales
	ON sales.total_sales>avg_sales.sales;

--nested Subqueries 
WITH sales as (select store_name, sum(cost) as total_sales
		from BikeStores.sales.stores
		group by store_name)
select *
from sales
join (select avg(total_sales) as sales
	from sales x) avg_sales
	ON sales.total_sales>avg_sales.sales;

ALTER TABLE BikeStores.sales.stores
ADD quantity INT;
UPDATE BikeStores.sales.stores
SET quantity= '25'
WHERE store_id = 1;
UPDATE BikeStores.sales.stores
SET quantity= '33'
WHERE store_id = 2;
UPDATE BikeStores.sales.stores
SET quantity= '40'
WHERE store_id = 3;
UPDATE BikeStores.sales.stores
SET quantity= '18'
WHERE store_id = 4;
UPDATE BikeStores.sales.stores
SET quantity= '49'
WHERE store_id = 5;
UPDATE BikeStores.sales.stores
SET quantity= '44'
WHERE store_id = 6;


ALTER TABLE BikeStores.sales.stores
ADD department varchar(255);
UPDATE BikeStores.sales.stores
SET department= 'Sales'
WHERE store_id = 1;
UPDATE BikeStores.sales.stores
SET department= 'Sales'
WHERE store_id = 2;
UPDATE BikeStores.sales.stores
SET department= 'HR'
WHERE store_id = 3;
UPDATE BikeStores.sales.stores
SET department= 'Finance'
WHERE store_id = 4;
UPDATE BikeStores.sales.stores
SET department= 'Finance'
WHERE store_id = 5;
UPDATE BikeStores.sales.stores
SET department= 'Marketing'
WHERE store_id = 6;

--Using subquery in Having clause
--Find the stores who have sold more unites than the average unites sold by all stores.
select store_name, sum(quantity)
from BikeStores.sales.stores 
group by store_name
having sum(quantity) > (select avg(quantity) from BikeStores.sales.stores)

select max(salary) as max_salary from BikeStores.sales.staffs

ALTER TABLE BikeStores.sales.staffs
ADD department varchar(255);
UPDATE BikeStores.sales.staffs SET department= (select department from BikeStores.sales.stores
where BikeStores.sales.staffs.store_id=BikeStores.sales.stores.store_id)
--Window Functions
select *,
max(Salary) over() as max_salary
from BikeStores.sales.staffs

select *,
max(Salary) over(partition by department) as max_salary
from BikeStores.sales.staffs

--Fetch the first 2 employees from each department to join the company
select * from (select *,
row_number() over(partition by department order by staff_id) as rn
from BikeStores.sales.staffs) x
where x.rn<3;

--fetch the top employee in each deparmtent with the highest salary
select * from(select *,
rank() over(partition by department order by salary desc) as highest
from BikeStores.sales.staffs) k
where k.highest<2

--Write a query to display if the salary of an employee is higher, lower or equal to the previous employee.
select bst.*,
lag(Salary) over(partition by department order by staff_id) as prev_emp_salary,
lead(Salary) over(partition by department order by staff_id) as next_emp_salary
from BikeStores.sales.staffs bst

select bst.*,
lag(Salary) over(partition by department order by staff_id) as "prev_emp_salary",
case when bst.Salary > lag(Salary) over(partition by department order by staff_id) then 'Higher than previous employee'
		when bst.Salary < lag(Salary) over(partition by department order by staff_id) then 'Less than previous employee'
		when bst.Salary > lag(Salary) over(partition by department order by staff_id) then 'Higher than previous employee'
		end sal_range
from BikeStores.sales.staffs bst

select last_name
from BikeStores.sales.staffs
where last_name= 'Vargas'

select * from BikeStores.sales.stores

--Write a query to retrieve the most expensive Store_name
select max(cost) as Highest, store_name
from BikeStores.sales.stores
group by store_name


CREATE TABLE CUSTOMERS (
   ID INT NOT NULL,
   NAME VARCHAR (20) NOT NULL,
   AGE INT NOT NULL,
   ADDRESS CHAR (25),
   SALARY DECIMAL (18, 2),       
   PRIMARY KEY (ID)
);

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (1, 'Ramesh', 32, 'Ahmedabad', 2000.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (2, 'Khilan', 25, 'Delhi', 1500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (3, 'kaushik', 23, 'Kota', 2000.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (4, 'Chaitali', 25, 'Mumbai', 6500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (5, 'Hardik', 27, 'Bhopal', 8500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (6, 'Komal', 22, 'MP', 4500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (7, 'Muffy', 24, 'Indore', 10000.00 );

select * from dbo.



