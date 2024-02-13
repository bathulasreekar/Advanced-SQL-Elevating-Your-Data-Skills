ANY & ALL
salary =450 >ANY (300, 400,500) -> 300 or 400 or 500  
salary = 450 >ALL (300, 400,500) -> 300 and 400 and 500  
Write a query find the employee details and departments 

-- who belong to the location 1700   employee, department , 1700
select * from departments
select employee_id, department_id from employees where department_id =ANY
(select department_id from departments where location_id=1700)

Employee earning salary more than minimum of all  the dept.

select employee_id, salary from employees where salary >ALL 
(select min(salary) from employees group by department_id)

-- Write query selects the department with the highest average salary using sub query
select department_id, avg(salary) sal from employees group by department_id
having avg(salary)>=ALL
(select avg(salary) from employees group by department_id)

-- Department name with highest employee count
Accounts 45
select department_name, count(*) cn from employees 
join departments using(department_id)
group by department_id order by cn desc limit 1


or
select department_name, count(*) cn from employees 
join departments using(department_id)
group by department_id
having cn>=ALL
(select count(*) cn from employees group by department_id)

or -- Derived table 
select department_name, count(*) cn from employees 
join departments using(department_id)
group by department_id
having cn=
(select count(*)cn from employees group by department_id order by cn desc limit 1


2nd highest salary  17000

select employee_id, salary from employees order by salary desc limit 2,1 17000

select * from employees where salary=(
 select max(salary) from employees where salary <>(
 select max(salary) from employees));

select * from employees
where salary = (select salary from employees order by salary desc limit 10,1)

salary, bonus +5000

select employee_id, salary, salary+5000 bonus from employees > bonus 15000

select employee_id, salary, salary+5000 bonus from employees
where salary+5000>15000

select employee_id, salary, salary+5000 bonus from employees
having bonus>15000

select * from
(select employee_id, salary, salary+5000 bonus from employees)t1
where bonus>15000

CTE - common Expression Table
with t1 as
(select employee_id, salary, salary+5000 bonus from employees)
select * from t1 where bonus>15000

Display the count of mangers and clerks across the departments
-- job_id   count
-- Manager   40
-- clerk     23

select 

-- Display employee name along with manger name
select first_name emp_name, (select first_name from employees e1 where
e1.employee_id=e2.manager_id) mgr_name from employees e2 

-- Display dept id and name 
select distinct(department_id) ,
( select department_name from departments d1 where d1.department_id = e2.department_id) 
dept_name from employees e2 ;

Windows Functions/Adavanced functions OLAP

-- Ranking
-- Aggregation
-- Analytical

over(partition/Group by, order, Frame- slicing-frame/module) 
over()
Row_number()

select row_number() over() "S.NO", employee_id, department_id, salary from employees

select employee_id, department_id, salary, 
rank() over(order by salary desc) rnk,
dense_rank() over(order by salary desc) dnr,
percent_rank() over(order by salary) pnr,
round(cume_dist() over(order by salary),2) cnr
 from employees 
 
 Latest hired date and employee details
 select * from 
 (select employee_id, first_name, hire_date,
 dense_rank() over(order by hire_date desc) hr from employees)t
 where hr=1
 
 Cumulative Distribution

select employee_id, first_name, department_id, 
sum(salary) over(partition by department_id order by salary)from employees


first_value & Last_value
Ntile


