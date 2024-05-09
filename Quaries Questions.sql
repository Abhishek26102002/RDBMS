 DROP DATABASE `classicmodels`;

CREATE DATABASE IF NOT EXISTS `classicmodels`;

SHOW DATABASES;

USE `classicmodels`;

DROP TABLE IF EXISTS `offices`;

CREATE TABLE `offices` (
  `officeCode` varchar(10) NOT NULL,
  `city` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50),
  `state` varchar(50),
  `country` varchar(50) NOT NULL,
  `postalCode` varchar(15) NOT NULL,
  `territory` varchar(10) NOT NULL,
  PRIMARY KEY (`officeCode`)
);

SHOW TABLES; -- showing table

INSERT INTO `offices` 

(officeCode,city,phone,addressLine1,addressLine2,state,country,postalCode,territory) VALUES 

('1','San Francisco','+1 650 219 4782','100 Market Street','Suite 300','CA','USA','94080','NA'),


SELECT * FROM `offices`;

DESCRIBE `offices`;

select officeCode , city from offices;

-- Q.Add some more entires into the offices table, using just the required (NOT NULL) columns.
INSERT INTO `offices` 
(officeCode,city,phone,addressLine1,country,postalCode,territory) VALUES 
('8','kolkata','+91 8080808080','MCKV institute of E','india','743126','Howrah');

SELECT * FROM `offices`;

-- Q2. Explore what happens if you don't provide a value for a column marked as not null.
-- Ans. ERROR 1048 (23000) at line 60: Column 'territory' cannot be null

-- Q3. Try adding an entry with a primary key matching the an existing entry.
-- Ans. ERROR 1062 (23000) at line 69: Duplicate entry '8' for key 'offices.PRIMARY'

-- Q4. Retrieve and display just the city and phone number information for each office.
select city , phone from offices;

-- Create a new office location and add some employees for the new location.
-- (Done Already see kolkata officecode 8 and in employees john wick employeeNumber - 0001)

-- Where Clause
SELECT firstName ,lastName ,employeeNumber FROM `employees` WHERE `jobTitle`="Sales Rep";
SELECT firstName ,lastName ,employeeNumber FROM `employees` WHERE `jobTitle`="Sales Rep" and officeCode="1";

-- delete
delete FROM offices WHERE officeCode="aaa";

-- update
update employees set reportsTo="1002" WHERE `jobTitle`="Sales Rep" and officeCode="1";

SELECT firstName ,lastName ,reportsTo FROM `employees` WHERE `jobTitle`="Sales Rep" and officeCode="1";

-- List the customers in the United States with a credit limit higher than \$1000.
SELECT customerName , customerNumber from customers WHERE country="USA" and creditLimit >= "1000";

-- List the employee codes for sales representatives of customers in Spain, France and Italy.
SELECT salesRepEmployeeNumber from customers WHERE country IN ("Spain" , "France" , "Italy");

-- Make another query to list the names and email addresses of those employees.
SELECT firstName , lastName , email from employees where employeeNumber IN(1370 , 1337);


-- Change the job title "Sales Rep" to "Sales Representative"
update employees SET jobTitle="Sales Representative" where jobTitle= "Sales Rep";
SELECT * from employees WHERE jobTitle="Sales Representative";

-- *Delete the entries for Sales Representatives working in London.
delete from employees WHERE officeCode = "7" and jobTitle = "Sales Representative"; /*(NOT WORKING)*/

-- Show a list of employees who are not sales representatives
SELECT firstName ,lastName ,employeeNumber FROM `employees` WHERE `jobTitle` <> "Sales Rep";
/*or*/
SELECT firstName ,lastName ,employeeNumber FROM `employees` WHERE `jobTitle` ! ="Sales Rep"; /*same as upper*/

-- Show a list of customers with "Toys" in their name
SELECT customerName, country from Customers where customerName LIKE "%Toys%" ; 
-- Imp
-- for starts with any alphabate LIKE "a%"
-- for end                       LIKE "%b"

-- List the 5 most expensive products from the "Planes" product line
select productLine ,buyPrice , MSRP from Products order by MSRP  desc limit 5;

-- Identify the products that are about to run out of stock (quantity in stock < 1000)
select productLine ,productName , quantityInStock from Products where quantityInStock<1000 ;

-- List 10 products in the "Motorcycles" category with the lowest buy price and more than 1000 units in stock
select productLine , buyPrice , quantityInStock from products where quantityInStock>1000 order by buyPrice desc limit 10;


-- add new col hierdOn in Employee table
alter table employees add hiredOn date;

-- updates the value i.e putting specific col.
update employees set hiredOn="2020-12-09" where jobTitle="Sales Rep" and officeCode="4";

--EXERCISE: Add, remove and modify one column in each of the tables created above.
-- add
alter table employees add hiredOn date;
--remove
alter table employees drop column hiredOn;
--Renaming a column:
ALTER TABLE employees RENAME COLUMN hiredOn TO joining;
-- Changing the data type of a column:
ALTER TABLE employees MODIFY COLUMN joining INT;
-- What happens when you rename primary key
ALTER TABLE employees RENAME COLUMN employeeNumber TO employeeNum;
-- Runnes

--or remove a column that is a primary key?
alter table employees drop column employeeNum;
-- ERROR 1829 (HY000): Cannot drop column 'employeeNum': needed in a foreign key constraint 'employees_ibfk_1' of table 'employees'

-- Prepare a list of offices sorted by country, state, city. (ASC|DESC) asc for accending order and desc for decending
select * from offices order by country ASC;
select * from offices order by state ASC;
select * from offices order by city ASC;
-- How many employees are there in the company?
select count(*) from employees;
-- What is the total of payments received?
select sum(amount) from payment;
-- List the product lines that contain 'Cars'.
select * from productLines where productline LIKE "%Cars%" ;
-- Report total payments for October 28, 2004.
select sum(amount) from payments where paymentDate =2004-10-28;
-- Report those payments greater than \$100,000.
select * from payments where amount>100000;
-- List the products in each product line.
select productLine from productLines ;
-- How many products in each product line?
select count(*) from productLines;
-- What is the minimum payment received?
-- ???
-- List all payments greater than twice the average payment.
-- ???
-- What is the average percentage markup of the MSRP on buyPrice?
-- ???
-- How many distinct products does ClassicModels sell?
-- ???
-- Report the name and city of customers who don't have sales representatives?
-- ???
-- What are the names of executives with VP or Manager in their title? Use the CONCAT function to combine the employee's first name and last name into a single field for reporting.
-- ???
-- Which orders have a value greater than $5,000?
-- ???

-- QUESTION: Report the total number of payments received before October 28, 2004.
SELECT COUNT(*) FROM payments WHERE paymentDate<"2004-10-28";
SELECT * FROM payments WHERE paymentDate<"2004-10-28";

select distinct customerNumber from payments where paymentDate<"2004-10-28";
select count(distinct customerNumber) from payments where paymentDate<"2004-10-28";

select * from customers where customerNumber in(select distinct customerNumber from payments where paymentDate<"2004-10-28");

-- EXERCISE: Retrieve details of all the customers in the United States who have made payments between April 1st 2003 and March 31st 2004.
select * from customers where country="USA" in(select customerNumber from Payments where paymentDate>"2003-04-01" and paymentDate<"2004-03-31");

--  Find the total number of payments made each customer before October 28, 2004.
select customerNumber , count(*) as NumOfPayments from Payments where paymentDate<"2004-10-28" group by customerNumber; 

-- QUESTION: Find the total amount paid by each customer payment before October 28, 2004.
select customerNumber , SUM(amount) as TotalPaidAmount from Payments where paymentDate<"2004-10-28" group by customerNumber; 

-- EXERCISE: Determine the total number of units sold for each product
select productCode , sum(quantityOrdered) from orderdetails group by productCode; 

-- QUESTION: Find the total no. of payments and total payment amount for each customer for payments made before October 28, 2004.
select customerNumber , count(*) as NumOfPayments, SUM(amount) as TotalPaidAmount from Payments where paymentDate<"2004-10-28" group by customerNumber; 

-- min max and avg
select customerNumber, count(*) as timesPurchase , sum(amount) as TotalSum , min(amount) as MinPurchase , max(amount) as MaxPurchase , avg(amount) as AvgPurchase from payments where paymentDate<"2004-10-28" group by customerNumber;

-- QUESTION: Retrieve the customer number for 10 customers who made the highest total payment before October 28th 2004.
select customerNumber , sum(amount) as TotalPayment from payments where paymentDate<"2004-10-28" group by  customerNumber order by TotalPayment DESC limit 10;

-- offset skips the results 10 represent how many u want to skip
select customerNumber , sum(amount) as TotalPayment from payments where paymentDate<"2004-10-28" group by  customerNumber order by TotalPayment DESC limit 10 offset 10;

-- QUESTION: Display the full name of point of contact each customer in the United States in upper case, along with their phone number, sorted by alphabetical order of customer name.
-- UCASE for uppercase string
-- LCASE  for lower case String
/*step 1 :*/ select customerName, UCASE(contactFirstName),LCASE(contactLastName) from customers where country="USA";
/*step 2 :*/select customerName,CONCAT(contactFirstName,contactLastName) from customers where country="USA";
/*step 3 :*/select customerName,UCASE(CONCAT(contactFirstName," ",contactLastName)) from customers where country="USA";
/*step 4 :*/select customerName,UCASE(CONCAT(contactFirstName," ",contactLastName)) as ContactName from customers where country="USA";
/*step 5 :*/select customerName,UCASE(CONCAT(contactFirstName," ",contactLastName)) as FullName, phone from customers where country="USA" order by customerName asc;

-- QUESTION: Display a paginated list of customers (sorted by customer name), with a country code column.
-- The country is simply the first 3 letters in the country name, in lower case.
--                          SUBSTRING(col_name, to , from) || index starts with * 1 * NOT `0`
select customerName ,LCASE( SUBSTRING(country,1,3)) as CountryCode from customers order by customerName limit 10 ;

-- QUESTION: Display the list of the 5 most expensive products in the "Motorcycles" product line 
-- with their price (MSRP) rounded to dollars.
--                               ROUND(col_name,noOFDeciman);
select productcode ,productName, ROUND(MSRP) as price from products where productLine="Motorcycles" order by price DESC limit 5 ;


-- ARITHIMATIC OPERATION

-- QUESTION: Display the product code, product name, buy price, sale price and profit margin percentage
-- ((MSRP - buyPrice)*100/buyPrice) for the 10 products with the highest profit margin. Round the profit margin to 2 decimals.
select productcode, productname,buyPrice,MSRP, ROUND(((MSRP-buyPrice)*100/buyPrice),2) as Profit_Margin_percentage from products order by Profit_Margin_percentage DESC limit 10;

-- QUESTION: List the largest single payment done by every customer in the year 2004, ordered by the transaction value (highest to lowest).
select customernumber , max(amount) as LargestPayment from payments  where YEAR(paymentdate)=2004 group by customernumber order by LargestPayment DESC limit 10;


 -- QUESTION: Show the total payments received month by month for every year.
 select year(paymentdate) as YEAR_of_pay ,
month(paymentdate) as MONTH_of_pay,
concat("$ ",format(sum(amount),2)) as revenue 
from payments 
group by YEAR_of_pay, MONTH_of_pay 
order by YEAR_of_pay,MONTH_of_pay ASC 
limit 10;
 
-- for date formate use DATE_FORMATE()
-- ref : https://jovian.com/outlink?url=https%3A%2F%2Fwww.w3schools.com%2Fsql%2Fsql_dates.asp || https://jovian.com/outlink?url=https%3A%2F%2Fwww.w3schools.com%2Fsql%2Ffunc_mysql_date_format.asp
 
 select year(paymentdate) as YEAR_of_pay ,
date_format((paymentdate),'%M') as MONTH_of_pay,
month(paymentdate) as MONTH_of_pay_in_num,
concat("$ ",format(sum(amount),2)) as revenue 
from payments 
group by YEAR_of_pay, MONTH_of_pay ,MONTH_of_pay_in_num
order by YEAR_of_pay,MONTH_of_pay_in_num ASC 
limit 10;

-- to hide details  of order by
 select year(paymentdate) as YEAR_of_pay ,
date_format((paymentdate),'%M') as MONTH_of_pay,
concat("$ ",format(sum(amount),2)) as revenue 
from payments 
group by YEAR_of_pay, MONTH_of_pay ,month(paymentdate)
order by YEAR_of_pay,month(paymentdate) ASC 
limit 10;

-- Show the full office address and phone number for each employee.
select employeeNumber, firstname,lastname,offices.phone ,offices.addressline1 from employees join offices on offices.officecode=employees.officecode limit 10; 

-- Show the full office address and phone number for each employee.
select employeeNumber, firstname,lastname,
concat(extension," ",phone) as employeePhn,
offices.addressline1 
from employees join offices 
on offices.officecode=employees.officecode limit 10; 






