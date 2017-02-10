use Sales1979
select * from products
select * from [sales detail]
select * from orders
insert into [Sales Detail] values(2,'ACI','WI089',10)
insert into [Sales Detail] values(2,'REI','RL450',80)
select orderno, sum((price * quantity))  from [sales detail] inner join products on [sales detail].productid = products.productid group by orderno
alter table [sales detail] alter column total money not null
update dbo.[sales detail] set [sales detail].total = price * quantity from [sales detail] inner join products on [sales detail].productid = products.productid
select * from [sales detail]
create trigger update_total on dbo.[sales detail]
	after insert, update
	as
	update dbo.[sales detail] set [sales detail].total = price * quantity from [sales detail] inner join products on [sales detail].productid = products.productid