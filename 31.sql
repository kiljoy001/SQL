use Northwind;
Select * from Orders;
select ShipCountry, EmployeeID, sum(freight) as total from Orders group by ShipCountry, EmployeeID union
select ShipCountry, EmployeeID, sum(freight) as total from orders group by EmployeeID, ShipCountry;
select ShipCountry, EmployeeID, sum(freight) as total from Orders group by ShipCountry, EmployeeID;
select CompanyName, City, Country, ContactName from customers where Country = 'USA'
select productname, unitprice from Products where unitprice + 10 > 50
select * from [Order Details]
select unitprice, quantity, (UnitPrice * Quantity) as total from [Order Details] where discount > .05
use Pubs
select * from employee
select job_id, count(job_id) from employee group by job_id
select * from sales
select ord_num, sum(qty) as 'books orderd', stor_id from sales group by ord_num, stor_id