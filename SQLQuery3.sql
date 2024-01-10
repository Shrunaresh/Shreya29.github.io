create table employee
(
	id 			int primary key,
	name 		varchar(100),
	dept 		varchar(100),
	salary 		int
);
select * from employee;

insert into employee values(1, 'Alexander', 'Admin', 6500);
insert into employee values(2, 'Leo', 'Finance', 7000);
insert into employee values(3, 'Robin', 'IT', 2000);
insert into employee values(4, 'Ali', 'IT', 4000);
insert into employee values(5, 'Maria', 'IT', 6000);
insert into employee values(6, 'Alice', 'Admin', 5000);
insert into employee values(7, 'Sebastian', 'HR', 3000);
insert into employee values(8, 'Emma', 'Finance', 4000);
insert into employee values(9, 'John', 'HR', 4500);
insert into employee values(10, 'Kabir', 'IT', 8000);

--DISPLAY THE HIGHEST AND LOWEST SALARY OF EMPLOYEES DEPARTMENT WISE
select *
, max(salary) over(partition by dept order by salary desc) as highest_sal
, min(salary) over(partition by dept order by salary desc
					range between unbounded preceding and unbounded following) as lowest_sal
from employee;

