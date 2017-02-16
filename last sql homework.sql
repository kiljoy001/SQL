use sales1979
go
create table Customers
(
CustomerNo char(4) check (CustomerNo like '[0-9][0-9][0-9][0-9]')constraint cno_constraint primary key,
Company varchar(50) not null,
CustomerRep char(3) check (CustomerRep like '[0-9][0-9][0-9]'),
CreditLimit money default('20000.00')
)
go
create table Salesreps
(
EmployeeNo char(3) check (EmployeeNo like '[0-9][0-9][0-9]') constraint eno_constraint primary key,
FirstName varchar(25) not null,
LastName varchar(25) not null,
Age int,
SalesRepOffice char(2) not null,
Title varchar(50),
HireDate date not null,
Manager char(3) not null,
Quota money,
Sales money not null
)
go
create table Offices
(
Office char(2) check(Office like '[0-9][0-9]') constraint office_pk primary key,
City varchar(25) not null,
Region varchar(10) not null,
Manager char(3) check (Manager like '[0-9][0-9][0-9]') not null,
Target money,
Sales money not null
)
go
create table Orders
(
OrderNo int Identity(1,1) constraint ordno_pk primary key,
OrderDate date not null,
CustomerNo char(4) not null,
SalesRep char(3) not null
)
go
create table Products
(
ManufacturerID char(3) check(ManufacturerID like '[A-z][A-z][A-z]'),
ProductId char(5) check(ProductId like '[A-z][A-z][0-9][0-9][0-9]'),
primary key (ManufacturerID, ProductId),
Description varchar(50) not null,
Price money not null,
QtyOnHand int not null
)
go
alter table customers add constraint crep_fk foreign key (CustomerRep) references Salesreps
alter table salesreps add constraint sroffice_fk foreign key (SalesRepOffice) references Offices(office)
alter table salesreps add constraint srmanagers_fk foreign key (Manager) references salesreps(EmployeeNo)
alter table offices add constraint Omanager_fk foreign key(Manager) references Salesreps(EmployeeNo)
alter table Orders add constraint Ordcust_fk foreign key (Customerno) references customers(customerno)
alter table Orders add constraint Osalesrep_fk foreign key (SalesRep) references Salesreps(EmployeeNo)
go
create table [Sales Detail]
(
OrderNo int foreign key(OrderNo) references Orders(orderno),
ManufacturerID char(3) check(ManufacturerID like '[A-z][A-z][A-z]'),
ProductID char(5) check(ProductId like '[A-z][A-z][0-9][0-9][0-9]'),
primary key(OrderNo, ProductID, ManufacturerID),
--to create the foreign key, all parts of the primary key need to present, hence the addition of the manufacuturer's column 
foreign key(ManufacturerID, ProductID) references products(ManufacturerID, ProductId)
)
go
-- Disable all the constraint in database
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"
insert into Salesreps values('001', 'Scott','Guyton',36,01,'Corperate Executive Officer',GETDATE(),'001',0,0)
insert into Salesreps values('002', 'Chanh','Norsouvanh',37,01,'Corperate Financial Officer',GETDATE(),'001',0,0)
insert into Products values('rsw','sg001','Shadow Gears game software', 19.00, 500000)
insert into Products values('ine','cn001','Cisco Certified Networking Lab',250.00, 1000)
insert into Orders values(getdate(), 0001, '001')
insert into Orders values(getdate(), 0002, '001')
insert into Offices values('01', 'Seattle', 'US-NW', '001','2000000.00', '0')
insert into Offices values('02', 'Honolulu','US-PACIFIC','002','2500000.00','0')
insert into Customers values('hic1','Hawaiian Island Creations','001','0')
insert into Customers values('gmst','GameStop Renton','001','0')
-- Enable all the constraint in database
EXEC sp_msforeachtable "ALTER TABLE ? CHECK CONSTRAINT all"
insert into Products values('REI','RL450','Ratchet Link','79.00',210)
insert into Products values('BIC','PL672','Plate','180.00',345)
insert into Products values('ACI','WI089','Size 1 Widget','55.00',78)
update Products set price = (price *.10)+ price where ManufacturerID like 'ACI'
update Products set price = price - 10 where ProductId like 'PL%'
select * from Products where ProductId like 'PL%'
insert into Salesreps values('102', 'Alberto','Thorium',56,'02','Software Architect','1990-10-28','001',0,0)
insert into Salesreps values('301', 'John','Patel',45,'02','Account Manger','1990-12-25','301',0,0)
insert into Salesreps values('420', 'Winston', 'McIntosh',year('1944') - year(getdate()),'02','Account Manager', '1990-03-15','301',0,0)
select * from Salesreps
insert into Salesreps values('666', 'Stormlung', 'Aether',year(getdate()) - Year('1980-06-21'),'02','Account Manager', '1989-03-15','301',0,0)
print year(getdate()) - Year('1980-06-21')
insert into Salesreps values('256', 'Han', 'Cathode',year(getdate()) - Year('1944-06-21'),'02','Sales Representative', '1989-02-15','301',0,0)
insert into Salesreps values('415', 'Kyle', 'Reese', year(getdate()) - Year('1950-02-13'), '01','Sales Representative', '1978-01-28','002',0,0)
delete from salesreps where year(HireDate) < year('1990')
go
create trigger update_quota on dbo.Salesreps 
	after insert
	as 
	declare @inserted int
	select @inserted = count(*) from inserted
	if @inserted > 0
		begin
			declare @quota money
			select @quota = quota from Salesreps
			if @quota not between '100000.00' and '50000.00'
				rollback tran
		end
select * from Salesreps
select * from inserted
alter table [Sales Detail] alter column quantity int not null
go
create trigger insert_or_update_sale_credit_limit on dbo.[Orders]
	after insert, update
	as
	declare @inserted int
	select @inserted = count(*) from inserted
	if @inserted > 0
		begin
			declare @total money, @customer_limit money
			select @customer_limit = creditlimit from customers
			select @total = [Sales Detail].total from [sales detail]
			if @total > @customer_limit
				begin
					rollback transaction
				end
		end
go
drop trigger insert_or_update_sale_credit_limit
go

create proc delete_company
	@comp_name varchar(50)
	as
	set nocount on
	delete from Customers where company = @comp_name
	IF not EXISTS(select Orders.CustomerNo from Customers, Orders where company = @comp_name)
		delete from orders where not exists (select Orders.CustomerNo from Customers, Orders where company = @comp_name)