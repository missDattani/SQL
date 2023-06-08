USE PD326PoojaDattani;

	--create table employee detail--

CREATE TABLE Employee_Details(
	EMP_IDNO INT PRIMARY KEY,
	EMP_FNAME VARCHAR(250) NOT NULL,
	EMP_LNAME VARCHAR(250),
	EMP_DEPT INT
);

	--insert records into employee detail--

INSERT INTO Employee_Details VALUES(127323,'Michale','Robbin',57);
INSERT INTO Employee_Details VALUES(526689,'Carlos','Snares',63);
INSERT INTO Employee_Details VALUES(843795,'Enric','Dosio',57);
INSERT INTO Employee_Details VALUES(328717,'Jhon','Snares',63);
INSERT INTO Employee_Details VALUES(444527,'Joseph','Dosni',47);
INSERT INTO Employee_Details VALUES(659831,'Zanifer','Emily',47);
INSERT INTO Employee_Details VALUES(847674,'Kuleswar','Sitaraman',57);
INSERT INTO Employee_Details VALUES(748681,'Henrey','Gabriel',47);
INSERT INTO Employee_Details VALUES(555935,'Alex','Manuel',57);
INSERT INTO Employee_Details VALUES(539569,'George','Mardy',27);
INSERT INTO Employee_Details VALUES(733843,'Mario','Saule',63);
INSERT INTO Employee_Details VALUES(631548,'Alan','Snappy',27);
INSERT INTO Employee_Details VALUES(839139,'Maria','Foster',57);

	--Retrieve data from employee detail--

SELECT * FROM Employee_Details;

	--create table employee department--

CREATE TABLE employee_department(
	DPT_CODE INT PRIMARY KEY,
	DPT_NAME VARCHAR(250) NOT NULL,
	DPT_ALLOTMENT INT 
);

	--insert records into employee detail--

INSERT INTO employee_department VALUES(57,'IT',65000);
INSERT INTO employee_department VALUES(63,'Finance',15000);
INSERT INTO employee_department VALUES(47,'HR',240000);
INSERT INTO employee_department VALUES(27,'RD',55000);
INSERT INTO employee_department VALUES(89,'QC',75000);

	--Retrieve data from employee detail--

SELECT * FROM employee_department;

	--alter table employee detail to add foreign key--

ALTER TABLE Employee_Details
ADD FOREIGN KEY (EMP_DEPT) REFERENCES employee_department(DPT_CODE);

	--create table company master--

CREATE TABLE company_master(
	COM_ID INT PRIMARY KEY,
	COM_NAME VARCHAR(250) NOT NULL
);

	--insert records into company master--

INSERT INTO company_master VALUES(11,'Samsung');
INSERT INTO company_master VALUES(12,'iBall');
INSERT INTO company_master VALUES(13,'Epsion');
INSERT INTO company_master VALUES(14,'Zebronics');
INSERT INTO company_master VALUES(15,'Asus');
INSERT INTO company_master VALUES(16,'Frontech');

	--Retrieve data from company master--

SELECT * FROM company_master;

	--create table item master--

CREATE TABLE item_master(
	PRO_ID INT PRIMARY KEY,
	PRO_NAME VARCHAR(250) NOT NULL,
	PRO_PRICE DECIMAL(10,2),
	PRO_COM INT  FOREIGN KEY REFERENCES company_mast(COM_ID)
);

	--insert records into company master--

INSERT INTO item_master VALUES(101,'Mother Board',3200,15);
INSERT INTO item_master VALUES(102,'Key Board',450,16);
INSERT INTO item_master VALUES(103,'ZIP drive',250,14);
INSERT INTO item_master VALUES(104,'Speaker',550,16);
INSERT INTO item_master VALUES(105,'Monitor',5000,11);
INSERT INTO item_master VALUES(106,'DVD drive',900,12);
INSERT INTO item_master VALUES(107,'CD drive',800,12);
INSERT INTO item_master VALUES(108,'Printer',2600,13);
INSERT INTO item_master VALUES(109,'Refill cartridge',350,13);
INSERT INTO item_master VALUES(110,'Mouse',250,12);

	--Retrieve data from company master--

SELECT * FROM item_mast;

	--create table orders--

CREATE TABLE order_detail(
	ord_no INT PRIMARY KEY,
	purch_amt DECIMAL(10,2),
	ord_date DATE,
	customer_id INT NOT NULL,
	salesman_id INT
);

	--insert records into orders--

INSERT INTO order_detail VALUES(70001,150.5,'2012-10-05',3005,5002);
INSERT INTO order_detail VALUES(70009,270.65,'2012-09-10',3001,5005);
INSERT INTO order_detail VALUES(70002,65.26,'2012-10-05',3002,5001);
INSERT INTO order_detail VALUES(70004,110.5,'2012-08-17',3009,5003);
INSERT INTO order_detail VALUES(70007,948.5,'2012-09-10',3005,5002);
INSERT INTO order_detail VALUES(70005,2400.6,'2012-07-27',3007,5001);
INSERT INTO order_detail VALUES(70008,5760,'2012-09-10',3002,5001);
INSERT INTO order_detail VALUES(70010,1983.43,'2012-10-10',3004,5006);
INSERT INTO order_detail VALUES(70003,2480.4,'2012-10-10',3009,5003);
INSERT INTO order_detail VALUES(70012,250.45,'2012-06-27',3008,5002);
INSERT INTO order_detail VALUES(70011,75.29,'2012-08-17',3003,5007);
INSERT INTO order_detail VALUES(70013,3045.6,'2012-04-25',3002,5001);

	--Retrieve data from orders--

SELECT * FROM order_detail;

	--create table salesman--

CREATE TABLE salesman_detail(
	salesman_id INT PRIMARY KEY,
	name VARCHAR(250) NOT NULL,
	city VARCHAR(250),
	commission DECIMAL(5,2)
);

	--insert records into salesman--
	
INSERT INTO salesman_detail VALUES(5001,'James Hoog','New York',0.15);
INSERT INTO salesman_detail VALUES(5002,'Nail Knite','Paris',0.13);
INSERT INTO salesman_detail VALUES(5005,'Pit Alex','London',0.11);
INSERT INTO salesman_detail VALUES(5006,'Mc Lyon','Paris',0.14);
INSERT INTO salesman_detail VALUES(5007,'Paul Adam','Rome',0.13);
INSERT INTO salesman_detail VALUES(5003,'Lauson Hen','San Jose',0.12);

	--Retrieve data from salesman--

SELECT * FROM salesman_detail;

	--create table customer--

CREATE TABLE customer_detail(
	customer_id INT PRIMARY KEY,
	cust_name VARCHAR(250) NOT NULL,
	city VARCHAR(250),
	grade INT,
	salesman_id INT FOREIGN KEY REFERENCES salesman(salesman_id)
);

	--insert records into customer--
	
INSERT INTO customer_detail VALUES(3002,'Nick Rimando','New York',100,5001);
INSERT INTO customer_detail VALUES(3007,'Brad Davis','New York',200,5001);
INSERT INTO customer_detail VALUES(3005,'Graham Zusi','California',200,5002);
INSERT INTO customer_detail VALUES(3008,'Julian Green','London',300,5002);
INSERT INTO customer_detail VALUES(3004,'Fabian Johnson','Paris',300,5006);
INSERT INTO customer_detail VALUES(3009,'Geoff Cameron','Berlin',100,5003);
INSERT INTO customer_detail VALUES(3003,'Jozy Altidor','Moscow',200,5007);
INSERT INTO customer_detail(customer_id,cust_name,city,salesman_id) VALUES(3001,'Brad Guzan','London',5005);

	--Retrieve data from customer--
	
SELECT * FROM customer_detail;

	--alter orders table to add foreign key on customer_id and salesman_id--

ALTER TABLE order_detail
ADD CONSTRAINT FK_Sid
FOREIGN KEY (salesman_id) REFERENCES salesman_detail(salesman_id);

ALTER TABLE order_detail
ADD CONSTRAINT FK_Cid
FOREIGN KEY (customer_id) REFERENCES customer_detail(customer_id);


	--1. Write a SQL statement to prepare a list with salesman name, customer name and their cities for the salesmen and customer who belongs to the same city-->>

SELECT S.name AS "Salesman",
C.cust_name, C.city 
FROM salesman_detail S,customer_detail C 
WHERE S.city=C.city;

	--2. Write a SQL statement to make a list with order no, purchase amount, customer name and their cities for those orders which order amount between 500 and 2000 -->>

SELECT O.ord_no AS "OrderNo", O.purch_amt AS "PurchaseAmount",C.cust_name, C.city
FROM order_detail O,customer_detail C 
WHERE O.customer_id=C.customer_id AND O.purch_amt BETWEEN 500 AND 2000;

SELECT O.ord_no AS "OrderNo", O.purch_amt AS "PurchaseAmount",C.cust_name, C.city
FROM order_detail O
INNER JOIN customer_detail C ON O.customer_id=C.customer_id
WHERE O.purch_amt BETWEEN 500 AND 2000;

	--3. Write a SQL statement to know which salesman are working for which customer.-->>

SELECT C.cust_name AS "Customer Name", S.name AS "Salesman"
FROM customer_detail C 
INNER JOIN salesman_detail S 
ON C.salesman_id=S.salesman_id;

	--4. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who gets a commission from the company is more than 12% -->>

SELECT C.cust_name AS "Customer Name", S.name AS "Salesman", S.commission 
FROM customer_detail C 
INNER JOIN salesman_detail S 
ON C.salesman_id=S.salesman_id 
WHERE S.commission>.12;

SELECT C.cust_name AS "Customer Name", S.name AS "Salesman", S.commission 
FROM customer_detail C 
LEFT JOIN salesman_detail S 
ON C.salesman_id=S.salesman_id 
WHERE S.commission>.12;


	--5. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who does not live in the same city where their customer lives, and gets a commission is above 12% -->>

SELECT C.cust_name AS "Customer Name", C.city, S.name AS "Salesman", S.city, S.commission  
FROM customer_detail C 
INNER JOIN salesman_detail S 
ON C.salesman_id=S.salesman_id 
WHERE S.commission>.12 AND C.city<>S.city;

SELECT C.cust_name AS "Customer Name", C.city, S.name AS "Salesman", S.city, S.commission  
FROM customer_detail C , salesman_detail S 
WHERE C.salesman_id=S.salesman_id AND S.commission>.12 AND C.city<>S.city;

	--6. Write a SQL statement to find the details of a order i.e. order number, order date, amount of order, which customer gives the order and which salesman works for that customer and how much commission he gets for an order. -->>

SELECT O.ord_no, O.ord_date, O.purch_amt, C.cust_name AS "Customer Name", S.name AS "Salesman", S.commission 
FROM order_detail O 
INNER JOIN customer_detail C 
ON O.customer_id=C.customer_id 
INNER JOIN salesman_detail S 
ON O.salesman_id=S.salesman_id;

	--7. Write a SQL statement to make a join on the tables salesman, customer and orders in such a form that the same column of each table will appear once and only the relational rows will come. -->

SELECT * FROM order_detail O 
INNER JOIN customer_detail C ON O.customer_id=C.customer_id
INNER JOIN salesman_detail S ON O.salesman_id=S.salesman_id;

	--8. Write a SQL statement to make a list in ascending order for the customer who works either through a salesman or by own. -->>

SELECT C.cust_name, S.name AS "Salesman" 
FROM customer_detail C
LEFT JOIN salesman_detail S 
ON C.salesman_id=S.salesman_id 
ORDER BY C.customer_id;

	--9. Write a SQL statement to make a list in ascending order for the customer who holds a grade less than 300 and works either through a salesman or by own. -->>

SELECT C.cust_name, C.grade, S.name AS "Salesman" 
FROM customer_detail C
LEFT JOIN salesman_detail S 
ON C.salesman_id=S.salesman_id 
WHERE C.grade < 300 
ORDER BY C.customer_id;

	--10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to find that either any of the existing customers have placed no order or placed one or more orders. -->>

SELECT C.cust_name, C.city, O.ord_no, O.ord_date,O.purch_amt AS "Order Amount" 
FROM customer_detail C 
LEFT JOIN order_detail O 
ON C.customer_id=O.customer_id 
ORDER BY O.ord_date;


	--11. Write a SQL statement to make a report with customer name, city, order number, order date, order amount salesman name and commission to find that either any of the existing customers have placed no order or placed one or more orders by their salesman or by own. -->>

SELECT C.cust_name, C.city, O.ord_no, O.ord_date, O.purch_amt AS "Order Amount", S.name, S.commission 
FROM customer_detail C 
LEFT JOIN order_detail O
ON C.customer_id=O.customer_id 
LEFT JOIN salesman_detail S
ON S.salesman_id=O.salesman_id;

	--12. Write a SQL statement to make a list in ascending order for the salesmen who works either for one or more customer or not yet join under any of the customers. -->>

SELECT C.cust_name, S.name AS "Salesman"
FROM customer_detail C
RIGHT JOIN salesman_detail S
ON S.salesman_id=C.salesman_id 
ORDER BY S.salesman_id;

	--13. Write a SQL statement to make a list for the salesmen who works either for one or more customer or not yet join under any of the customers who placed either one or more orders or no order to their supplier. -->>

SELECT C.cust_name, C.city, C.grade, S.name AS "Salesman", O.ord_no, O.ord_date, O.purch_amt 
FROM customer_detail C
RIGHT JOIN salesman_detail S
ON S.salesman_id=C.salesman_id 
RIGHT JOIN order_detail O
ON O.customer_id=C.customer_id;

	--14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.-->>

SELECT C.cust_name, C.city, C.grade, S.name AS "Salesman", O.ord_no, O.ord_date, O.purch_amt 
FROM customer_detail C 
RIGHT JOIN salesman_detail S 
ON S.salesman_id=C.salesman_id 
LEFT JOIN order_detail O
ON O.customer_id=C.customer_id 
WHERE O.purch_amt>=2000 AND C.grade IS NOT NULL;

	--15 . Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for those customers from the existing list who placed one or more orders or which order(s) have been placed by the customer who is not on the list. -->>

SELECT C.cust_name, C.city, O.ord_no, O.ord_date,O.purch_amt AS "Order Amount" 
FROM customer_detail C
FULL OUTER JOIN order_detail O 
ON C.customer_id=O.customer_id;

	--16 . Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who is neither in the list not have a grade. -->>

SELECT C.cust_name, C.city, O.ord_no, O.ord_date,O.purch_amt AS "Order Amount" 
FROM customer_detail C
FULL OUTER JOIN order_detail O 
ON C.customer_id=O.customer_id
WHERE C.grade IS NOT NULL;

	--17 . Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa.

SELECT * FROM salesman_detail 
CROSS JOIN customer_detail;

	--18 . Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for that customer who belongs to a city.-->>

SELECT * FROM salesman_detail S
CROSS JOIN customer_detail C
WHERE S.city IS NOT NULL;

	--19 . Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who belongs to a city and the customers who must have a grade. -->>

SELECT * FROM salesman_detail S
CROSS JOIN customer_detail C
WHERE S.city IS NOT NULL AND C.grade IS NOT NULL;

	--20 . Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who must belong a city which is not the same as his customer and the customers should have an own grade. -->>

SELECT * FROM salesman_detail S
CROSS JOIN customer_detail C
WHERE S.city IS NOT NULL AND C.grade IS NOT NULL
AND S.city <> C.city;

	--21 . Write a SQL query to display all the data from the item_mast, including all the data for each item's producer company. -->>

SELECT * FROM item_master I
INNER JOIN company_master C
ON I.PRO_COM = C.COM_ID;

	--22 . Write a SQL query to display the item name, price, and company name of all the product  -->>

SELECT I.PRO_NAME, I.PRO_PRICE, C.COM_NAME FROM item_master I
INNER JOIN company_master C
ON I.PRO_COM = C.COM_ID;

	--23 . Write a SQL query to display the average price of items of each company, showing the name of the company. -->>
	
SELECT AVG(I.PRO_PRICE) AS average_price, C.COM_NAME FROM item_master I
INNER JOIN company_master C
ON I.PRO_COM = C.COM_ID
GROUP BY C.COM_NAME;

	--24 . Write a SQL query to display the names of the company whose products have an average price larger than or equal to Rs. 350.-->>

SELECT AVG(I.PRO_PRICE) AS average_price, C.COM_NAME FROM item_master I
INNER JOIN company_master C
ON I.PRO_COM = C.COM_ID
GROUP BY C.COM_NAME
HAVING AVG(PRO_PRICE) >= 350;

	--25 . Write a SQL query to display the name of each company along with the ID and price for their most expensive product. -->>

SELECT C.COM_ID, C.COM_NAME, I.PRO_PRICE 
FROM item_master I, company_master C
WHERE I.PRO_COM = C.COM_ID AND I.PRO_PRICE = (SELECT MAX(I.PRO_PRICE) FROM item_master I WHERE I.PRO_COM = C.COM_ID);

	--26 . Write a query in SQL to display all the data of employees including their department -->>

SELECT E.*, D.* 
FROM emp_details E
INNER JOIN emp_department D
ON E.EMP_DEPT = D.DPT_CODE;

	--27 . Write a query in SQL to display the first name and last name of each employee, along with the name and sanction amount for their department. -->>

SELECT E.EMP_FNAME AS "First Name", E.EMP_LNAME AS "Last Name", D.DPT_NAME AS "Department", D.DPT_ALLOTMENT AS "Sanction Amount" 
FROM emp_details E
INNER JOIN emp_department D
ON E.EMP_DEPT = D.DPT_CODE;

	--28 . Write a query in SQL to find the first name and last name of employees working for departments with a budget more than Rs. 50000. -->>

SELECT E.EMP_FNAME AS "First Name", E.EMP_LNAME AS "Last Name", D.DPT_NAME AS "Department", D.DPT_ALLOTMENT AS "Sanction Amount" 
FROM emp_details E
INNER JOIN emp_department D
ON E.EMP_DEPT = D.DPT_CODE
WHERE D.DPT_ALLOTMENT > 50000;

	--29 . Write a query in SQL to find the names of departments where more than two employees are working. -->>

SELECT D.DPT_NAME AS "Department"
FROM emp_details E
INNER JOIN emp_department D
ON E.EMP_DEPT = D.DPT_CODE
GROUP BY D.DPT_NAME
HAVING COUNT(*) > 2;

	--30 . Write a query to display all the orders from the orders table issued by the salesman 'Paul Adam' -->>

SELECT o.* FROM order_detail o
LEFT JOIN salesman s
ON o.salesman_id = s.salesman_id
WHERE s.name = 'Paul Adam';

	--31 . Write a query to display all the orders for the salesman who belongs to the city London. -->>

SELECT o.* FROM order_detail o
LEFT JOIN salesman s
ON o.salesman_id = s.salesman_id 
WHERE s.city = 'London';

	--32 . Write a query to find all the orders issued against the salesman who may works for customer whose id is 3007. -->>

SELECT o.* FROM order_detail o
LEFT JOIN salesman_detail s
ON o.salesman_id = s.salesman_id 
WHERE o.customer_id = 3007;

	--33 . Write a query to display all the orders which values are greater than the average order value for 10th October 2012. -->>

SELECT * FROM order_detail 
WHERE purch_amt > 
(SELECT AVG(purch_amt) FROM order_detail
WHERE ord_date = '2012-10-10');

	--34 . Write a query to find all orders attributed to a salesman in New york. -->>

SELECT *
FROM order_detail
WHERE salesman_id IN
(SELECT salesman_id FROM salesman_detail 
WHERE city ='New York');

	--35 . Write a query to count the customers with grades above New York's average -->>

SELECT grade, COUNT(*) AS "num_of_customer"
FROM customer_detail
GROUP BY grade
HAVING grade >
(SELECT AVG(grade) FROM customer_detail 
WHERE city = 'New York');

	--36 . Write a query to display all the customers with orders issued on date 17th August, 2012 -->>

SELECT O.*, C.cust_name
FROM order_detail O,
customer_detail C
WHERE O.customer_id = C.customer_id AND O.ord_date = '2012-08-17';

	--37 . Write a query to find the name and numbers of all salesmen who had more than one customer. 

SELECT salesman_id,name 
FROM salesman_detail S
WHERE 1 < (SELECT COUNT(*) FROM customer_detail C
WHERE C.salesman_id = S.salesman_id);

	--38 . Write a query to find all orders with order amounts which are above-average amounts for their customers. -->>

SELECT * FROM order_detail O1
WHERE O1.purch_amt > 
(SELECT AVG(purch_amt) FROM order_detail O2
WHERE O2.customer_id = O1.customer_id);

	--39 . Write a queries to find all orders with order amounts which are on or above-average amounts for their customers.  

SELECT * FROM order_detail O1
WHERE O1.purch_amt >= 
(SELECT AVG(purch_amt) FROM order_detail O2
WHERE O2.customer_id = O1.customer_id);

	--40 . Write a query to find the sums of the amounts from the orders table, grouped by date, eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date -->>

SELECT ord_date, SUM (purch_amt) AS "total_amount"
FROM order_detail O1
GROUP BY ord_date
HAVING SUM (purch_amt) >
(SELECT 1000.00 + MAX(purch_amt) 
FROM order_detail O2 
WHERE O1.ord_date = O2.ord_date);

	--41 . Write a query to extract the data from the customer table if and only if one or more of the customers in the customer table are located in London. -->>

SELECT * 
FROM customer_detail 
WHERE EXISTS (SELECT * FROM customer_detail
WHERE city = 'London');

	--42 . Write a query to find the salesmen who have multiple customers. -->>

SELECT * FROM salesman_detail S
WHERE salesman_id IN
(SELECT DISTINCT salesman_id FROM customer_detail C1
WHERE EXISTS (SELECT * FROM customer_detail C2 
WHERE C1.salesman_id = C2.salesman_id AND C1.cust_name <> C2.cust_name));	


	--43 . Write a query to find all the salesmen who worked for only one customer -->>

SELECT * FROM salesman_detail S
WHERE salesman_id IN
(SELECT DISTINCT salesman_id FROM customer_detail C1
WHERE NOT EXISTS (SELECT * FROM customer_detail C2 
WHERE C1.salesman_id = C2.salesman_id AND C1.cust_name <> C2.cust_name));

	--44 . Write a query that extract the rows of all salesmen who have customers with more than one orders. -->>

SELECT * FROM salesman_detail S
WHERE EXISTS
(SELECT * FROM customer_detail C
WHERE S.salesman_id = C.salesman_id AND 1 < (SELECT COUNT(*) FROM order_detail O WHERE O.customer_id = C.customer_id));

	--45 . Write a query to find salesmen with all information who lives in the city where any of the customers lives. -->>

SELECT * FROM salesman_detail
WHERE city = ANY
(SELECT city FROM customer_detail);

	--46 . Write a query to find all the salesmen for whom there are customers that follow them. -->>

SELECT * FROM salesman_detail
WHERE city IN
(SELECT city FROM customer_detail);

	--47 . Write a query to display the salesmen which name are alphabetically lower than the name of the customers. -->>

SELECT * FROM salesman_detail S
WHERE EXISTS
(SELECT * FROM customer_detail C
WHERE S.name < C.cust_name );

	--48 . Write a query to display the customers who have a greater gradation than any customer who belongs to the alphabetically lower than the city New York. -->>

SELECT * FROM customer_detail
WHERE grade > ANY
(SELECT grade FROM customer_detail
WHERE city < 'New York');

	--49 . Write a query to display all the orders that had amounts that were greater than at least one of the orders on September 10th 2012. -->>

SELECT * FROM order_detail
WHERE purch_amt > ANY 
(SELECT purch_amt FROM order_detail
WHERE ord_date = '2012-09-10');

	--50 . Write a query to find all orders with an amount smaller than any amount for a customer in London. -->>

SELECT * FROM order_detail
WHERE purch_amt < ANY
(SELECT purch_amt FROM order_detail, customer_detail 
WHERE order_detail.customer_id = customer_detail.customer_id AND city = 'London');

	--51 . Write a query to display all orders with an amount smaller than any amount for a customer in London.-->>

SELECT * FROM order_detail
WHERE purch_amt < ANY
(SELECT purch_amt FROM order_detail, customer_detail 
WHERE order_detail.customer_id = customer_detail.customer_id AND city = 'London');

	--52 . Write a query to display only those customers whose grade are, in fact, higher than every customer in New York.  -->>

SELECT * FROM customer_detail
WHERE grade > ALL
(SELECT grade FROM customer_detail WHERE city = 'New York');

	--53 . Write a query to find only those customers whose grade are, higher than every customer to the city New York. -->>
	
SELECT * FROM customer_detail
WHERE grade > ALL
(SELECT grade FROM customer_detail WHERE city = 'New York');

	--54 . Write a query to get all the information for those customers whose grade is not as the grade of customer who belongs to the city London -->>

SELECT * FROM customer_detail
WHERE NOT grade = ALL
(SELECT grade FROM customer_detail WHERE city = 'London');

	--55 . Write a query to find all those customers whose grade are not as the grade, belongs to the city Paris. -->>

SELECT * FROM customer_detail
WHERE grade NOT IN
(SELECT grade FROM customer_detail WHERE city = 'Paris');

	--56 . Write a query to find all those customers who hold a different grade than any customer of the city Dallas. -->>

SELECT * FROM customer
WHERE NOT grade = ANY
(SELECT grade FROM customer_detail WHERE city = 'Dallas');

	--57 . Write a SQL query to find the average price of each manufacturer's products along with their name. -->>

SELECT AVG(I.PRO_PRICE) AS "average_price", C.COM_NAME AS "Company" 
FROM item_master I, company_master C
WHERE I.PRO_COM = C.COM_ID
GROUP BY C.COM_NAME;

	--58 . Write a SQL query to display the average price of the products which is more than or equal to 350 along with their names. -->>

SELECT AVG(I.PRO_PRICE) AS "average_price", C.COM_NAME AS "Company" 
FROM item_master I, company_master C
WHERE I.PRO_COM = C.COM_ID
GROUP BY C.COM_NAME
HAVING AVG(I.PRO_PRICE) >= 350;

	--59 . Write a SQL query to display the name of each company, price for their most expensive product along with their Name. -->>

SELECT C.COM_NAME, I.PRO_NAME , I.PRO_PRICE 
FROM company_master C, item_master I
WHERE C.COM_ID = I.PRO_COM AND I.PRO_PRICE =
(SELECT MAX(I.PRO_PRICE) FROM item_master I 
WHERE I.PRO_COM = C.COM_ID);
