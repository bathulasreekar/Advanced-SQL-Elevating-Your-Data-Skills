
Windows Function - over() - 
Rank, Aggregate analytical

select employee_id, first_name, department_id, count(*) from employees
group by department_id

select employee_id, first_name, department_id, count(*) over(partition by department_id) cnt
from employees

rank, dense_rank, percent_rank, cume_dist, count() sum()

Lead() Lag() function Lead - Next value Lag - previous value

select department_id, salary, lead(salary) over(partition by department_id) Next_val, lag(salary) over(partition by department_id) pre_val
from employees
 
 -- Average difference of hire_Date for each department
 
select hire_date from employees where department_id=50
diff between hire_date and next hire_date
step 1 Lead Hire_date for all the records
step 2 Find the diff between hire_date and the lead date
step 3 Find the average dates for each department

avg(no_of_days)

select department_id, avg(no_of_days) avg_days from 
(select *, datediff(hire_date,next_date) no_of_days from 
(select department_id, hire_date, 
lead(hire_date) over(partition by department_id order by hire_date desc) 
next_date from employees) t ) tt
group by department_id 

First_value() Last_value() - frame data

over() partition, order by , Frame

Max salary each dept

Rows BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW Default

select department_id, salary, 
last_value(salary) over(partition by department_id order by salary 
Rows BETWEEN UNBOUNDED PRECEDING AND unbounded following) from employees

	running total salary every department
    
    1 3000 3000     
    2 2000  5000  
    3 1000  6000
    1
     
    
    select department_id, salary, sum(salary) 
    over(partition by department_id rows between 2 preceding and 2 following
     )
    from employees
    
    ntile()
    
    select salary, ntile(3) over(order by salary) from employees where department_id=60
  
  capstone project 40/10  4


 -- find out how many ‘IT_PROG’ are moderately paid in the office.
 
 select * from job_history
 
 ntile(3) over() from employees 

select employee_id, job_id, salary, ntile(3) over(order by salary desc)
from employees
where job_id = 'IT_PROG';

Data Integrity/Constraints

default 
primary - Not null & unique 
not null - Blanks NULL
unique - No duplicacy
check age>18 country 
foreign key reference ()

Foreign key primary key - reference 
drop table  child, parent;

use trans;

create table parent
( id int primary key,
name varchar(10)
);

create table child
( id int,
dept varchar(10),
salary int,
Foreign key(id) references parent(id) ON DELETE set null ON UPDATE set null) 

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

update parent set id=200 where id=103

delete from parent where id=102

-- ON DELETE CASCADE ON UPDATE 












