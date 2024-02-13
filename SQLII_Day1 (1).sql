Sub queries
Windows function /advanced analytical functions
Data constraaints, ACID, Normalisation
Transaction processing
Views
query execution order - select from where order by group by 
Employees earning salary more than Neena
use hr;
Employees who are earning more than the avg salary organsiation

select * from employees where salary >
(select avg(salary) from employees)
Employees who are earning equal to the avg salary of all of the department

4500 >ANY (3000, 4000, 5000, 6000) or T T F F 
4500 >=ALL (3000, 4000, 5000, 6000) and T T F F 
in / =ANY
>ANY >ALL
select * from employees where salary >=ALL
(select avg(salary) from employees group by department_id)


Select the name of employees who belong to Marketing department
hr - 
employees departments

select * from employees where department_id =
(select department_id from departments where department_name='marketing')

Display the name ( first name and last name ), 
salary, department id for 
those employees who earns salary 
which is the smallest salary of all the departments

select * from employees e1 where salary <=
(select min(salary) minn from employees e2 where e1.department_id=e2.department_id)


Display all the information of the employees 
who does not work in these departments 
whose manager id within the range 100 and 200. 

select * from employees where department_id not in 
(select department_id from employees where manager_id between
145 and 200 and department_id is not null)

select * from employees where department_id not  in 
(select department_id from employees where manager_id between
100 and 200)


select employee_id, first_name, salary from employees e1 where salary> 
(select avg(salary) from employees e2 )

        - correlated subquery 
        30              100         5000
select department_id, employee_id, salary from employees e1
 where salary >  
(select avg(salary) from employees e2 where e1.department_id=e2.department_id) 
                                                   

2.	Display the employee name( first name and last name ) 
and hiredate for all employees 
in the same department as Clara. 
Exclude Clara.

select * from employees where department_id = 
(Select department_id from employees where first_name='clara')
and first_name<>'clara'
or 
select * from employees where department_id = 80
and first_name<>'clara'



4.	Write a query to display the employee id, name ( first name and last name ), 
salary, department name and city for all the employees (use joins)

who gets the salary as the maximum salary 
earn by the employee who joined in the year 1997

select employee_id, department_name, salary, city from employees e
join departments d using(department_id)
join locations l using(location_id) where salary =
(select max(salary) from employees where year(hire_date)=1997)



Exercise:
5.	Write a query in SQL to display the first and last name, salary, and department ID for those employees 
who earn less than the average salary, of Laura’s department

6.	Write the name of all the managers

7.	Write query selects the department with the highest average salary 

8.	Write a query find the employee details and departments who belong to the location 1700

9.	Second highest salary employees