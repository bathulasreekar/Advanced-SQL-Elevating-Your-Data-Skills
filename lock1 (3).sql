 -- Disable autocommit mode
 set autocommit=0;
 
use trans;
show tables;
select * from cust1;
delete from cust1;
alter table cust1 add name varchar(20);
select * from cust1;
insert into cust1 values ( 1, 40000, 'AAA');
 insert into cust1 values (2,35000, 'BBB');
 insert into cust1 values (3,50000, 'CCC');
 rollback;
 commit;
 
 -- session 1 - Read Data No locks
 start transaction;
 select * from cust1;
 insert into cust1 values (5,50000, 'CCC');
  commit;
 
-- user 1 - Lock in share mode
 start transaction;
 select * from cust1 lock in share mode;
  insert into cust1 values (6,50000, 'CCC'); 
 commit;


 -- user 1 write mode
  start transaction;
  select * from cust1 for update;
  insert into cust1 values (60,50000, 'CCC');
 commit;
 
 -- user 1 update query
 start transaction;
 select * from cust1;
 update cust1 set name='BBB' where id=3;
 commit;

select * from cust1;
delete  from cust1;
commit;
rollback;

---- ISOLATION

start transaction;
insert into cust1 values ( 1, 40000, 'AAA');
 insert into cust1 values (2,35000, 'BBB');
 insert into cust1 values (3,50000, 'CCC');
commit;

start transaction;
select * from cust1;
 insert into cust1 values (4,45000, 'DDD');
commit;

start transaction;
select * from cust1;
insert into cust1 values (750,45000, 'DDD');
update cust1 set id=5 where id=750
delete from cust1
commit;

select * from cust1;
start Transaction;
create view simple_view as select * from cust1; 
 show tables;
 select * from simple_view;
 
 

