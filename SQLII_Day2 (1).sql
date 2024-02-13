-- Exercises - Day 1
5.	Write a query in SQL to display the first and last name, salary, and department ID
 for those employees who earn less than the average salary, of Laura’s department

SELECT first_name, last_name, salary, department_id FROM employees WHERE salary < 
(SELECT AVG(salary) FROM employees ) AND department_id =
 (SELECT department_id FROM employees WHERE first_name = 'Laura');

6.	Write the name of all the managers
SELECT first_name, last_name 
FROM employees WHERE employee_id IN (SELECT manager_id FROM employees);

7.	Write query selects the department with the highest average salary 
SELECT department_id, AVG(SALARY) 
FROM EMPLOYEES GROUP BY department_id 
HAVING AVG(SALARY)>=ALL 
(SELECT AVG(SALARY) FROM EMPLOYEES GROUP BY department_id);

8.	Write a query find the employee details and departments who belong to the location 1700
SELECT first_name, last_name,department_id 
FROM employees WHERE department_id= ANY
(SELECT DEPARTMENT_ID FROM departments WHERE location_id=1700);

9.	Second highest salary employees
select max(salary) from employees where salary<(select max(salary) from employees) 

- subquery Type Single, multiple correlated 
- Single Relation operators >, <, <> etc
- Multiple row -> IN , NOT IN, >ANY, >ALL Exisist
- Correlated sub query
Day 2

select * from employees where exists
(select 1 from employees where department_id=80)


Display the name & department ID of all departments that has 
at least one employee with salary greater than 10,000.using IN & Exists 

select  department_name, department_id from departments where department_id in 
(select department_id from employees where salary>10000) 
or
select  department_name, department_id from departments d where department_id in 
(select department_id from employees e where salary>10000 and d.department_id=e.department_id) 
or
select  department_name, department_id from departments d where exists 
(select department_id from employees e where salary>10000 and d.department_id=e.department_id) 

-- Select clause 
1.	Display employee_id, dept id and department_name 
select employee_id, department_id, 
(select department_name from departments d where d.department_id=e.department_id) dept_name
from employees e
or
select employee_id, department_id, department_name from employees e
join departments d using(department_id)

Display employee name along with manger name

select first_name emp_name,
 (select first_name from employees e1 where e1.employee_id=e2.manager_id) mgr_name
 from employees e2
select * from employees

-- From clause 

select salary , bonus (salary+5000) and select records whose bonus >15000

select salary, salary+5000  from employees 
having bonus>15000

Derived Table/Inline Table

select * from 
(select salary, salary+5000 bonus from employees) t
where bonus>15000

-- CTE common table Expression
with t as
(select salary, salary+5000 bonus from employees) 
select * from t where bonus>15000

Display the count of mangers and clerks across the departments

Jobs_id	 Count 
-------  ----
Manager	  10
Clerk	   5

select job_id from employees

filter out only job_id like mgr or clerk t1 
case when name like mgr manager
case when name like clerk clerk t2
count group by cat count(*)

select category, count(*) from
(select *,
case
when job_id like '%Clerk%' then  'Clerk'
when job_id like '%mgr%' then  'manager' end as category
from
(select job_id from employees where job_id like '%clerk%'
or job_id  like '%mgr%') t1)t2
group by category

or

select job_id,count(*) from (select * from employees where job_id like '%mgr%' ) t1
union 
select job_id,count(*) from (select * from employees where job_id like '%clerk%') t2;

Windows Function / Advanced Functions

over(partition by, group by framing) 

Ranking
Aggregation
Analytical

row_number()

select row_number() over() "S.No", employee_id, first_name from employees

20th to 30th record
select * from
(select row_number() over() "S.No", employee_id, first_name from employees) t
where `S.No` between 20 and 30

Rank()
select * from 
(select dense_rank() over(order by salary desc) rnk, salary, employee_id, first_name from employees)t
where rnk=8
2nd highest salary
8th highest salary

Dense_rank()

select row_number() over() sno,
rank()over(order by salary desc) rnk,
dense_rank() over(order by salary desc) drnk, 
salary, employee_id, first_name 
from employees

percent_rank() 0- 1 percentile percentage 
95 % out of 100
95 % posiitioning with in the cohort

select rank()over(order by salary desc) rnk,
percent_rank()over(order by salary) percent,
salary, employee_id, first_name 
from employees


