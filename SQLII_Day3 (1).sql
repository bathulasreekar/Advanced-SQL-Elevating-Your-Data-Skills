Windows functions - Ranking, Aggregate and anlaytical
Aggregate function 
select department_id, sum(salary) from employees group by department_id
select employee_id, first_name, department_id,salary, sum(salary)  from employees

select employee_id, first_name, department_id,salary, 
count(employee_id) over(partition by department_id) sum_dept_sal,
max(salary) over(partition by department_id) max_sal
 from employees


Analytical function
Lead() and Lag()

select employee_id, department_id,salary, 
lead(salary) over(partition by department_id order by salary desc) lead_value from employees

1.	Write a Query to List the employee name,
 first designation and next promoted designation of all the employees in the company.
 select * from
(select first_name, j.job_id first_desig,
lead(j.job_id) over(partition by j.employee_id order by start_date asc) promoted_desig
from employees e join job_history j
on e.employee_id =j.employee_id) t
where promoted_desig is not NULL

select * from 
 (select first_name, j.job_id first_desig,
lead(j.job_id) over(partition by j.employee_id order by start_date asc) promoted_desig
from employees e join job_history j
on e.employee_id =j.employee_id) temp
where promoted_desig is not NULL
or

CTE
with temp as
(select first_name, j.job_id first_desig,
lead(j.job_id) over(partition by j.employee_id order by start_date asc) promoted_desig
from employees e join job_history j
on e.employee_id =j.employee_id)
select * from temp where promoted_desig is not NULL

 First_value()  and Last_value()
 
 select employee_id, salary,department_id, 
 first_value(salary) over(partition by department_id order by salary desc) from employees
 
 over() 1. partition, order by slicing
 Framing/slicing
 
 select employee_id, salary,department_id, 
 last_value(salary) over(partition by department_id order by salary desc 
 rows BETWEEN current row and unbounded following) from employees
 
 - rows BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW - Default slicing
  - rows BETWEEN CURRENT ROW and unbounded following - 
  rows BETWEEN UNBOUNDED PRECEDING and unbounded following
  ROWS BETWEEN 3 PRECEDING AND 2 FOLLOWING
 
 select department_id, employee_id, salary, 
  sum(salary)  over(partition by department_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) 
 from employees
 
 Ntile(3)
 
 select * from
 (select employee_id, salary,
 ntile(5) over(order by salary desc) groupp from employees) temp
 where groupp=1

 select *,
 ntile(8) over() from students
 
 
Write a query to find out list of  ‘IT_PROG’ are moderately paid in the organisation

select * from (select *, ntile(3) over(order by salary desc) ran
from employees
where job_id like '%it_prog%') tem
where ran = 2;
or
WITH T AS 
(SELECT EMPLOYEE_ID,JOB_ID,SALARY,
NTILE(5) OVER(ORDER BY SALARY DESC) GROUPP
FROM EMPLOYEES
WHERE JOB_ID LIKE 'IT%')
SELECT * FROM T WHERE GROUPP=4 ;
or

select * from 
(SELECT EMPLOYEE_ID,JOB_ID,SALARY,
NTILE(5) OVER(ORDER BY SALARY DESC) GROUPP
FROM EMPLOYEES) t
WHERE JOB_ID LIKE 'IT%' and groupp=4

create table temp(
emp_id int primary key,
name varchar(20) not null
email varchar(20) unique 
c1 not null unique
c2 not null unique
age check>18


primary key = not null  + unique 

Foreign key refercing pK

Banking

Master Table customer details -  Parent PK Loan 5000000 
Transaction table child FK EMI 5 yrs 


-- Restrict/No Action/Cascade/Set Null
drop table child
drop table parent

use trans;
create table parent
( id int primary key,
name varchar(10)
);

create table child
( id int,
dept varchar(10),
salary int,
Foreign key(id) references parent(id) 
);
desc child



 --ON DELETE RESTRICT ON UPDATE RESTRICT

insert into parent values
( 100, 'AAA'),
(101, 'BBB'),
(102, 'CCC'),
(103, 'DDD'),
(104, 'EEE');

insert into child values
(101, 'MKT', 5000),
(101, 'MKT', 5000),
(102, 'sales', 5500),
(102, 'sales', 5500),
(103, 'IT', 5000);

select * from parent;
select * from child;

-- Restrict /No Action

delete from parent where id=104;
update parent set id=107 where id=101;


-- CASCADE 
drop table child;
create table child
( id int,
dept varchar(10),
salary int,
Foreign key(id) references parent(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Delete and update will get cascade in child table

delete from parent where id=102;
update parent set id=109 where id =103;

select * from parent; select * from child;

-- ON DELETE set null ON UPDATE set null
--





 
 
 
 