set autocommit=0;

drop table cust1              

use trans;
create table cust1 (
id int,
balance int
);

desc cust1

select * from cust1;
-- rollback & commit;

start transaction; 
insert into cust1 values ( 1, 40000), (2,35000);
insert into cust1 values (3,23000);
commit;
rollback;


save point

-- save point 

select * from cust1;

start transaction;
delete from cust1;
commit;

-- savepoint
start transaction;
savepoint s1;
insert into cust1 values ( 1, 40000), (2,35000);
savepoint s2;
insert into cust1 values (3,70000), (4,45000);
savepoint s3;
insert into cust1 values (5,27000); -error

-- Rollback to any of the savepoint

rollback to s1;
release savepoint s1;
commit;


-- Isolation read uncommit
delete from cust1;
commit;
use trans;
start transaction;
insert into cust1 values ( 1, 40000);
 insert into cust1 values (2,35000);
 insert into cust1 values (3,50000);
 commit;
 
 start transaction;
 insert into cust1 values (4, 34000);
 commit;
 
select * from cust1;

-- serialisable
start transaction;
select * from cust1;
insert into cust1 values (7, 43000);
commit;

set transaction isolation level read uncommitted; 
start transaction;
select * from cust1;
commit;

start transaction;
insert into cust1 values (101, 23000);
commit;



delete from cust1;
commit;
-- 

delete from cust1;
commit;

set autocommit=0;
use trans;
start transaction;
select * from cust1;

insert into cust1 values (1,70000);
insert into cust1 values (2,35000);
commit;

delete from cust1;

 insert into cust1 values (8, 43000);
 commit;
 delete  from cust1;
 
