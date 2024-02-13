  -- Disable autocommit mode
 set autocommit=0;
 
use trans;
-- Session 2 Read Data - No Locks
start transaction;
 select * from cust1;
  commit;
 
 -- user2 share mode
 start transaction;
 select * from cust1 lock in share mode;
 commit;
 
 -- user2 - write mode (session 1 previous is still on)
 start transaction;
 select * from cust1 for update;
 commit;
 
 start transaction;
 select * from cust1 lock in share mode;
  update cust1 set name='AAA' where id=3;
 commit;

 -- views
 select * from cust1;
 