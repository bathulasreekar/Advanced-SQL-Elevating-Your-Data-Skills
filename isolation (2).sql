
set autocommit=0;
use trans;

set transaction isolation level read uncommitted; -- Dirty Read
start transaction;
select * from cust1;
commit;

set transaction isolation level read committed;
start transaction;
select * from cust1;
commit;

set transaction isolation level repeatable read;
start transaction;
select * from cust1; -- image/copy
commit;

set transaction isolation level serializable; write lock
start transaction;
select * from cust1;
insert into cust1 values( 9, 25000,'zzz');
commit;
















