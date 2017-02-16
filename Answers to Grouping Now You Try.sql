--1.  Use Pubs to find the average prices of books by type and 
--only report those types whose average is over $5.00.

use PubsKarenFall2016
go
 
--Return the total quantity of books ordered on each order number along with the store id 
select * from sales

select stor_id, ord_num, sum(qty) from sales
group by stor_id, ord_num
with cube


select * from titles

select type,avg(price) 'Average Price' from titles
group by type
having avg(price) > 5.00

--2.  Use Pubs find the total number of employees in every job 
--classification except Chief Executive Officer.

select * from jobs
select * from employee


select job_id,count(*) from employee
	group by job_id
	having job_id  != 2
	order by job_id




--3.  Using the Northwind database
--Which managers have more than four people reporting to them 
--(Hint:  Use the employees table)
use NorthwindKarenFall2016
go

select employeeid, firstname, lastname, reportsto from employees
order by reportsto

select reportsto,count(*) from employees
	group by reportsto
	having count(reportsto) > 4