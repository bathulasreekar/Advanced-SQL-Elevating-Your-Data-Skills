Sub queries
Windows functions
Data constraints
Normalisation
Transaction proessing
Views


Write a query to display the employee id, 
employee name (first name and last name ) 
for all employees who earn more than the average salary of an organisation.

select employee_id, first_name, salary from employees where salary in
(select min(salary) from employees group by department_id)

List the employees reporting to payam

select employee_id, first_name from employees where manager_id =
(select employee_id from employees where first_name='payam')

list the name of the employees, paid more than 'neena' 

select employee_id, first_name from employees where salary > 
(select salary from employees where first_name='neena')


2nd highest salary
select * from employees order by salary desc limit 2,1 -- 2 rows 2nd highest and 3rd hig
or
select max(salary) from employees where salary != 
(select max(salary) from employees);
or
select max(salary) from hr.employees
where salary < ( select max(salary)
					from hr.employees);
                    
Write a query to display the employee id, name ( first name and last name ), salary, 
department name and city for all the employees 
who gets the salary more than the maximum salary earn by the employee who joined in the year 1997

select employee_id, first_name, salary, department_name, city
 from employees e join departments d using(department_id)
 join locations l using(location_id)
 where salary > 
 (select max(salary) from employees where year(hire_date)=1997)
 
 or
 
select employee_id, first_name, salary, department_name, city
from employees e, departments d, locations l
where salary >((select max(salary) from employees where year(hire_date)=1997)
and e.department_id=d.department_id and d.location_id=l.location_id

List the employees those belong to location 1700

select employee_id, first_name  from employees where department_id in
(select department_id from departments where location_id=1700 )

select * from employees;
select * from departments;

Write the name of all the managers 
  select employee_id, first_name from employees where manager_id in
  (select employee_id from employees)
  
select employee_id, first_name,manager_id from employees
-- Exsist -- correlated subquery

Write query department_di where atleast one employee is working

select distinct e.department_id from departments d , employees e
where e.department_id=d.department_id

select department_id from departments
-- correlated sub query

select department_id from departments d where exists
(select department_id from employees e where e.department_id=d.department_id) 


select * from employees where exists 
(select 1 from departments)

Where - filter out the individual records
having - filter out the aggregated records

select salary, salary+5000 sal from employees 
having 
List department 50000

select sum(salary) sum_of_sal from employees group by department_id
having sum(salary)>50000

Employees earning more than avg salary of his own department

select employee_id, salary from employees e1 where salary in (450)
(select avg(salary) from employees e2 where e1.department_id=e2.department_id)


90 300   90 450
90 200
90 400
60 500     60 500
60 500
