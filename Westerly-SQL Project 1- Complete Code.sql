#Creating database
Create database Westerly;
#Creating the tables by Data import wizard
#Checking the table
Select * from continents;
#Creating the all the other Tables by using Data import wizrd 
Select * from orderdetailes;
Select * from orders;
Select * from Products;
Select * from salesemployees;
Select * from shippers;
Drop table employees;
select * from salesemployees;

#Q1.Retrieve all orders with their OrderID, CustomerID, EmployeeID, OrderDate, and ShippedDate.
	Select OrderID,CustomerID,EmployeeID,OrderDate,ShippedDate from Orders;

#Q2.Get a list of all customers with their CompanyName, ContactName, City, and Country.
	Select  CustomerID,CompanyName,ContactTitle,City,Country from Customers;

#Q3.Display the details of all products, including ProductID, ProductName, QuantityPerUnit, and UnitPrice.
	Select ProductID,ProductName,QuantityPerUnit,UnitPrice from Products;

#Q4.Add a column Salary to the SalesEmployees and Assign Salaries in the following order Sales Representative=3000,Sales Manager=5000 and Vice President Sales=8000.
	Alter table salesemployees
	Add Salary Int;
	Select * from salesemployees; 
	SET SQL_SAFE_UPDATES=0;
	Select * from salesemployees;
	Update salesemployees Set Salary=8000 Where Title="Vice President Sales";
	Select * from salesemployees;
	Update salesemployees Set Salary=5000 Where Title="Sales Manager";
	Update salesemployees Set Salary=3000 Where Title="Sales Representative";
#Q5.Give the Annual income of All the  Employees if the given income is monthly.
	Select EmployeeName,Salary*12 As Annual_Income from salesemployees;

#Q6.Show the Increased Salary As New Salary along with the employee name if the salary is increased by 12%.
	Select EmployeeName,Salary+Salary*0.12 As New_Salary from salesemployees;

#Q7.Calculate total number of orders placed
	Select Count(distinct(OrderID)) from Orders;

#Q8.Find the total revenue generated from all orders.
	Select Sum(UnitPrice*Quantity*Discount) from orderdetailes;

#Q9.Determine the average order value.alter
	Select avg(UnitPrice*Quantity*Discount) As Average_Order_Value from orderdetailes;

#Q10.Calculate the total quantity of each product sold.
	Select ProductID,Sum(Quantity) As Total_Quantity From orderdetailes group by ProductID;

#Q11.Retrieve orders that were shipped after a Jan,2014;
	Select OrderID from Orders where ShippedDate>"31/01/2014";

#Q12.Display customers from a USA.
	Select CustomerID from Customers where country="USA";

#Q13.Sort products by their unit price in descending order.
	Select ProductName,UnitPrice from Products Order by UnitPrice desc;

#Q14.Find the total number of orders placed by each customer.
	Select CustomerID,Count(OrderID) from Orders group by CustomerID;

#Q15.Calculate the total revenue generated from orders for each discount.
	Select (UnitPrice*Quantity) from Orderdetailes where OrderID in
		(Select OrderID from Orders Group by CustomerID);
#Q16.Determine the average quantity of products ordered per order.
	Select OrderID,Avg(Quantity) from orderdetailes group by OrderID;

#Q17.Retrieve orders containing products Where the Category name is Beverages
	Select OrderID,ProductID from orderdetailes where ProductID in
		(Select ProductID from Products Where CategoryID in
			(Select CategoryID from Categories Where CategoryName="Beverages"));
        
#Q18.Identify discontinued products that have been ordered.
	Select ProductName from Products Where Discontinued=1 and  ProductID in
		(Select ProductID from orderdetailes Where OrderID is not null);
    
#Q.19Find Customers where the customer's city matches the employee's city.
	Select CustomerID,City from Customers Where Customers.City in
		(Select SalesEmployees.City from SalesEmployees);
#Q.20Check for any orders with missing CustomerID or EmployeeID.
	Select OrderID From Orders Where CustomerID is not null or EmployeeID is not null;

#Q.21Check the number of orders shipped in between Nov-2013 and Feb-2014
	Select * from Orders Where ShippedDate between '2013-11-1' and '2014-02-28';

#Q.22 Retrive all the company names starting with letter N
		Select * from Customers Where ContactName Like "A%";
	Select * from salesemployees;
	SET SQL_SAFE_UPDATES=0;
	Update salesemployees Set ReportsTo=null Where EmployeeName="Andrew Fuller";
	Update orders Set RequiredDate=null Where OrderID=10260;
	Update orders Set Freight=null Where OrderID=10300;
	Update orderdetailes Set Discount=null Where OrderID=10369;
	Update Products Set QuantityPerUnit=null Where ProductID=49;
	Update Products Set QuantityPerUnit=null Where ProductID=69;
	Select * from  Customers;

#23.Identify ProductName and all the possible Chances of Discounts that can be given
	Select Distinct ProductName,Discount from Products CROSS JOIN orderdetailes;

#24.Showcase the company name and their required date of Delivery of the Product
	Select CompanyName,RequiredDate From Customers Inner Join Orders on Customers.CustomerID=Orders.CustomerID;

#25.Showcase the shipper company name and required date of Delivery of the Product
	Select CompanyName,RequiredDate from shippers
	 Inner join Orders	on shippers.ShipperID=orders.CustomerID;
 
#26.Give the customer id and their respective productid
	 Select CustomerID,ProductID from orders
	 inner join orderdetailes on Orders.OrderID=orderdetailes.OrderID;
 
#27.Provide contact names of the companies that have not mentioned the required date.
	 Select ContactName,RequiredDate from Customers left join Orders on
	 Customers.CustomerID=Orders.CustomerID;
 
#28.What is the name of the shipment company where the Freight volume is null
	 Select CompanyName,Freight from shippers left join orders on 
	 shippers.ShipperID=orders.ShipperID where freight is null;
 
#29.Give the orderids and respective employees handling the orders who don't need report to anybody
	 Select orders.OrderID,salesemployees.EmployeeName from Orders right join salesemployees on 
	 Orders.EmployeeID=salesemployees.EmployeeID;
 
#30.Show all the orderID and respective required date by Customer
	 Select OrderID,RequiredDate from salesemployees left outer join orders on
	 salesemployees.EmployeeID=Orders.EmployeeID;
 
#31.FInd out the total revenue generated from product,where the productID=77?
	Select sum(unitprice*quantity) as Total_Revenue from orderdetailes where ProductID=77;

#32.Call out the orderdetailes using stores procedure
	call Order_Detailes;

#33.Show all the Orders handled by a particular EmployeeID?
	call orders_by_employee(5);
	call orders_by_employee(8);
	call orders_by_employee(3);
	call orders_by_employee(2);
	call orders_by_employee(1);

#34.Show the   Max detailes Salary report using stoerd procedure
	call get_employee_info(@max_salary);
	Select @max_salary as Maximum_Salary_Given;

#35.Show the Amount generated by Products by giving input through ProductID
	call amount_product(50);
	call amount_product(72);
	call amount_product(30);
	call amount_product(11);
 
#36.Employee ID and respective Salary by stored procedure
	Call salary_information(@salary_is,8);
	Select @salary_is as Salary;

#37.Create net sales using Views
	Create View net_sales_by_product As
	Select ProductID,Sum(UnitPrice*Quantity) from orderdetailes group by ProductID Order by ProductID; 
	Select * from net_sales_by_product;

	Create View net_sales_by_order As
	Select OrderID,Sum(UnitPrice*Quantity) from orderdetailes group by OrderID Order by OrderID;
	Select * from net_sales_by_order;


