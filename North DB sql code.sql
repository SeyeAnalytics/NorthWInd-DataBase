--SQL ASSESSMENT

/*QUESTION 1
The company wants to reward its Sales Representatives staff only. 
For this to happen, we would need to know the staff name, 
the total amount of money the staff has handled during a customer transaction 
and the department this staff belongs to. 
(Remember, we want just the sales Rep staff).
Please, help the Finance department to generate 
a summary table that shows the full name (last + first name combined), 
the total amount of transaction, and the title of these employees.
Put this output in a view.
*/

Create view sales_Representative as
with Sales_Representatives as(
select initcap(firstname || '  ' || lastname) as staff_names, title, UnitPrice
from Employees 
left join Orders
using (employeeid)
left join order_details
using (orderid) 
)
select staff_names, title, sum(UnitPrice) as "Total amount of money"  
from Sales_Representatives
where title = 'Sales Representative'
group by staff_names, title
order by "Total amount of money" asc;


/*
Question 2
The board of directors are interested
in seeing the volume of transactions this business has made.
Your mission: In the operation year, 
give a breakdown of the total number
of orders by year and by month.
*/



select extract (Year from orderdate) as Year,
	   extract (month from orderdate) as Month,
	   (select count(orderid)
	   from order_details
	   where orderid = c.orderid ) as "Number of Orders"
	   
from orders	as c
order by 1,2 desc




/*
Question 3.
The company is doing well in terms of revenue.
The directors are planning to expand 
their customer base in some countries. 
Generate a ranked table from the customers
table that displays the customer id, company name, 
city, country, total quantity, and the ranked value.
This rank table should be partitioned by country.
*/



select customerid, 
	   companyname,
	   city, country,
	   rank()
	   
 	   over ( partition  by country order by customerid) as rank_nos
from company_revenue







/*
Question 4.
There have been some concerns with some of our suppliers.
The management would like to know the MVP
(most valuable players) suppliers and the ones that can be replaced.
Return a table that shows the name of the company, 
the contact’s name and the average quantity 
these companies have done for the company.
*/



select companyname, contactname,(
		
				select count(Quantityperunit) as Average_Qty
				from products
				where supplierid = c.supplierid)
from suppliers as C
order by 3 asc

--We can't get the average Qty since the column(Quantityperunit has both integer and text characters)

select companyname, contactname,Quantityperunit as Average_Qty
from suppliers as S
left join Products
using (Supplierid) 





