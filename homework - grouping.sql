use northwind
select companyname, contactname, contacttitle from customers where country like 'USA';

select productname from products where UnitsInStock = 0;
select productname from products where productname like '%tofu%';
select orderid from orders where ShippedDate like '%1996%' and shipcountry like 'USA';