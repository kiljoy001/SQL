use pubs;
select title from titles where ytd_sales is null;
select fname, lname, minit from employee where pub_id = 1756; 
select stor_name from stores where zip not like '9%' and state != 'WA';
select title, price, advance from titles where price > (advance * .2);
select title, price from titles where title like '%computer%';
select distinct state from stores;
select au_fname, au_lname from authors where au_lname like '%-%' or au_lname like '%r%';
select avg(price) from titles where pub_id = '0877';
select max(advance) from titles union select AVG(advance) from titles;
select * from sales;
select max(hire_date) from employee;
select qty from sales where ord_date > year('1992') union select avg(price) from titles where pub_id = '0877';
go

use Northwind
select count(ShipVia), ShipVia from Orders group by ShipVia;
select * from Orders;
select * from [Order Details];
select avg(Quantity), orderID from [Order Details] as average group by OrderID;
select * from Orders where DATEDIFF(day,RequiredDate, ShippedDate) > 5;
select * from employees;
select top 1 lastname, firstname from [dbo].[Employees] order by BirthDate ;
