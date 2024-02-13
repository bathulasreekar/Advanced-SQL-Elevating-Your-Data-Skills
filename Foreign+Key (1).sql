-- Restrict/No Action/Cascade/Set Null
use trans;
create table parent
( id int primary key,
name varchar(10)
);

create table child
( id int,
dept varchar(10),
salary int,
Foreign key(id) references parent(id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

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

-- Restrict /No Action
delete from parent where id=101;
update parent set id=107 where id=103;
-- CASCADE 
drop table child;
create table child
( id int,
dept varchar(10),
salary int,
Foreign key(id) references parent(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Delete and update will get cascade in child table

delete from parent where id=102;
update parent set id=109 where id =103;

select * from parent; select * from child;

-- ON DELETE set null ON UPDATE set null
--