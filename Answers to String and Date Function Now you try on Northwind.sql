
Use Northwind
go
/*  String and date function practice answer... Goes w/ ppt 6 or
string and date function separate ppt */

select * from employees

--Print the first initial of all employees and the complete last name (concatenate in one column)
--Print the birthdate of all employees as string data:  “December 13, 1954”
select substring(firstname,1,1) + '., ' + lastname 'First initial and last name',
datename(mm,birthdate) + ' ' + datename(dd,birthdate) + ', ' + datename(yy, birthdate) 'Your birthdate in string format'
	from employees

--Print the difference in days between the employees’ birthdates and today
--Print the day of the week it was when the employee was born.
--Use “getdate()” for current date
select 
	FirstName, 
	substring(LastName,1,1), 
	datename(mm,birthdate) + ' ' + datename(dd,birthdate) + ' ' + datename(yy, birthdate), 
	datediff(dd, birthdate,getdate()) 'Difference between birthday and today (in days)',
	'You were born on a ' + ' ' + datename(dw,birthdate)
from employees


/* What day was Colie born */
select 'You were born on a ' + ' ' + datename(dw,'10/25/1927')
