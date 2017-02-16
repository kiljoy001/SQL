--For orders with inventory (in stock) over 50 units:
--Return the customer company name, contact name 
--and phone,the name of the product, the total dollar amount of the order 
--and any discount that may be applied.
--Sort the output by total order amount

select companyname,contactname,phone,productname,(od.unitprice * quantity), discount, UnitsInStock
from products p inner join [order details] od
	on p.productid = od.productid
	inner join orders o 
	on o.orderid = od.orderid
	inner join customers c
	on o.customerid = c.customerid
	where unitsinstock > 50
	order by 5 desc


	--Show a list of all titles and the percentage of 
	--royalty the author would receive if the year-to-date sales doubled.

	select * from titles
	select * from roysched

	select title, r.royalty, ytd_sales, lorange, hirange, (ytd_sales * 2)
	from titles t inner join roysched r
	on t.title_id = r.title_id
	where (ytd_sales * 2) between lorange and hirange



