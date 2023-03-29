-- PART A
drop table if exists accounts;
create table if not exists accounts(
	id int not null primary key,
	name varchar(225),
	credit int,
	currency varchar(16)
);

insert into accounts(id, name, credit, currency) values
	(1, 'azamat', 1000, 'RUB'),
	(2, 'ikram', 1000, 'RUB'),
	(3, 'amir', 1000, 'RUB');
	
begin;
update accounts set credit = credit - 500 where id = 1;
update accounts set credit = credit + 500 where id = 3;
savepoint t1;
update accounts set credit = credit - 700 where id = 2;
update accounts set credit = credit + 700 where id = 1;
savepoint t2;
update accounts set credit = credit - 100 where id = 2;
update accounts set credit = credit + 100 where id = 3;
savepoint t3;
select * from accounts;
rollback;

-- PART B

alter table accounts drop column if exists bankname;
alter table accounts add column bankname varchar(225);

update accounts set bankname='SberBank' where id in (1, 3);
update accounts set bankname='Tinkoff' where id = 2;

insert into accounts values (4, 'fees', 0, 'RUB');
	
begin;
update accounts set credit = credit - 500 where id = 1;
update accounts set credit = credit - 30 where  id = 1 and bankname != (select bankname from accounts where id = 3);
update accounts set credit = credit + 30 where id = 4 and (select bankname from accounts where id = 1) != (select bankname from accounts where id = 3);
update accounts set credit = credit + 500 where id = 3;
savepoint t1;--
update accounts set credit = credit - 700 where id = 2;
update accounts set credit = credit - 30 where  id = 2 and bankname != (select bankname from accounts where id = 1);
update accounts set credit = credit + 30 where id = 4  and (select bankname from accounts where id = 2) != (select bankname from accounts where id = 1);
update accounts set credit = credit + 700 where id = 1;
savepoint t2;--
update accounts set credit = credit - 100 where id = 2;
update accounts set credit = credit - 30 where  id = 2 and bankname != (select bankname from accounts where id = 3);
update accounts set credit = credit + 30 where id = 4  and (select bankname from accounts where id = 2) != (select bankname from accounts where id = 3);
update accounts set credit = credit + 100 where id = 3;
savepoint t3;--
select * from accounts;
rollback;

-- PART C

drop table if exists ledger;
create table if not exists ledger(
	id int not null primary key,
	from_id int,
	to_id int,
	fee int,
	amount int,
	date timestamp
);

create function calc_fee(id1 integer, id2 integer)
	returns integer as $$
	begin
		if(select bankname from accounts where id = id1) != (select bankname from accounts where id = id2) then
			return 30;
		else
			return 0;
		end if;
	end;
	$$
	language plpgsql;


begin;
update accounts set credit = credit - 500 where id = 1;
update accounts set credit = credit - 30 where  id = 1 and bankname != (select bankname from accounts where id = 3);
update accounts set credit = credit + 30 where id = 4 and (select bankname from accounts where id = 1) != (select bankname from accounts where id = 3);
update accounts set credit = credit + 500 where id = 3;
insert into ledger values(1, 1, 3, calc_fee(1, 3), 500, now());
savepoint t1;--
update accounts set credit = credit - 700 where id = 2;
update accounts set credit = credit - 30 where  id = 2 and bankname != (select bankname from accounts where id = 1);
update accounts set credit = credit + 30 where id = 4  and (select bankname from accounts where id = 2) != (select bankname from accounts where id = 1);
update accounts set credit = credit + 700 where id = 1;
insert into ledger values(2, 2, 1, calc_fee(2, 1), 700, now());
savepoint t2;--
update accounts set credit = credit - 100 where id = 2;
update accounts set credit = credit - 30 where  id = 2 and bankname != (select bankname from accounts where id = 3);
update accounts set credit = credit + 30 where id = 4  and (select bankname from accounts where id = 2) != (select bankname from accounts where id = 3);
update accounts set credit = credit + 100 where id = 3;
insert into ledger values(3, 2, 3, calc_fee(2, 3), 100, now());
savepoint t3;--
select * from ledger;

rollback;