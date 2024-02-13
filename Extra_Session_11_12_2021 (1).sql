use hr;
select * from employees;

select department_id,count(*) from employees;-- Error 
-- SQL 
select department_id,count(*) from employees
group by department_id;-- logically correct 

select department_id,count(*) over() from employees;
-- overall tables
#################################################
-- windows/groups /bucket 
-- window function / group by - will not reduce / will reduce 
-- row_number/rank/dense_rank (number value)
###################################################
use complaints;
select * from complaints_data;
-- vodafone 
-- latest complaint of every customer who raised the complaint 
-- 100000 

select * from (
select complaint_id,cust_id,complaint_date,complaint_r1,
row_number() over(partition by cust_id order by complaint_date desc ) output
from complaints_data)t where output=1;
-- tagging of recent/older transaction
################################################
-- lag/lead comparison 
use hr;

select department_id,avg(diff1) from (
select first_name,department_id,hire_date,
lag(hire_date) over(partition by department_id) output ,
datediff(hire_date,lag(hire_date) 
over(partition by department_id))/365 diff1
from employees)t group by department_id order by avg(diff1) desc;
select department_id,job_id,count(*),
(select count(*) from employees where department_id=90) col2
from employees where department_id=90
group by department_id,job_id;

select department_id, job_id, 
count(*) over(partition by job_id) total_emp_jobwise,
count(*) over(partition by department_id) total_emp_depwise
from employees
where department_id = 90;-- partial
############################################################
-- rows,column,pivot table (summary)
###########################################################
-- joins/subquery,windows function
-- trasaction TCL (sql developer)/isolation level/lock(DBA)
-- connect with DB / backend /architecture 
############################################################
-- TCL - Transaction 
-- all the things dml,ddl-autocommit ,dcl etc.
###########################################################
-- autocommit enabled
set autocommit=0;
create table trunc(sid int);
insert into trunc values (1),(2);
commit;-- save
select * from trunc;
insert into trunc values (3),(4);
rollback;
#############################################
insert into trunc values (3),(4);
insert into trunc values (5),(6);
select * from trunc;
create table trunc1(sid int);-- DDL autocommit
rollback;
###############################################
-- locks are there exclusive (nothing is possible not dml,select )
-- and shared locks(select see the data, dml not)
################################################
set autocommit=0;
select * from trunc;
select * from trunc where sid=5 for update;-- exclusive lock 
select * from trunc;
commit;
set autocommit=0;
use hr;
select * from trunc;
insert into trunc values(11);
-- 7 - 10 seconds (log off) 
/*what are locks
types of locks
multi user (locks)
definition of isolation level (read committed,read uncoomitted,
serialozable,repeatable read)
-- dql select , ddl ,dml,tcl ,good to know*/
select salary ,
sum(salary) over(order by salary desc
rows between unbounded preceding and current row) 
from employees;
-- cummulative















