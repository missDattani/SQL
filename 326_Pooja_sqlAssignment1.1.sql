		--ASSIGNMENT-1--

USE PD326PoojaDattani;

	--create table employee detail--

CREATE TABLE emp_details(
	EMP_IDNO INT PRIMARY KEY,
	EMP_FNAME VARCHAR(250) NOT NULL,
	EMP_LNAME VARCHAR(250),
	EMP_DEPT INT
);

	--insert records into employee detail--

INSERT INTO emp_details VALUES(127323,'Michale','Robbin',57);
INSERT INTO emp_details VALUES(526689,'Carlos','Snares',63);
INSERT INTO emp_details VALUES(843795,'Enric','Dosio',57);
INSERT INTO emp_details VALUES(328717,'Jhon','Snares',63);
INSERT INTO emp_details VALUES(444527,'Joseph','Dosni',47);
INSERT INTO emp_details VALUES(659831,'Zanifer','Emily',47);
INSERT INTO emp_details VALUES(847674,'Kuleswar','Sitaraman',57);
INSERT INTO emp_details VALUES(748681,'Henrey','Gabriel',47);
INSERT INTO emp_details VALUES(555935,'Alex','Manuel',57);
INSERT INTO emp_details VALUES(539569,'George','Mardy',27);
INSERT INTO emp_details VALUES(733843,'Mario','Saule',63);
INSERT INTO emp_details VALUES(631548,'Alan','Snappy',27);
INSERT INTO emp_details VALUES(839139,'Maria','Foster',57);


	--Retrieve data from employee detail--

SELECT * FROM emp_details;


	--create table employee department--

CREATE TABLE emp_department(
	DPT_CODE INT PRIMARY KEY,
	DPT_NAME VARCHAR(250) NOT NULL,
	DPT_ALLOTMENT INT 
);

	--insert records into employee detail--

INSERT INTO emp_department VALUES(57,'IT',65000);
INSERT INTO emp_department VALUES(63,'Finance',15000);
INSERT INTO emp_department VALUES(47,'HR',240000);
INSERT INTO emp_department VALUES(27,'RD',55000);
INSERT INTO emp_department VALUES(89,'QC',75000);

	--Retrieve data from employee detail--

SELECT * FROM emp_department;

	--alter table employee detail to add foreign key--

ALTER TABLE emp_details
ADD FOREIGN KEY (EMP_DEPT) REFERENCES emp_department(DPT_CODE);

	--create table company master--

CREATE TABLE company_mast(
	COM_ID INT PRIMARY KEY,
	COM_NAME VARCHAR(250) NOT NULL
);
	
	--insert records into company master--

INSERT INTO company_mast VALUES(11,'Samsung');
INSERT INTO company_mast VALUES(12,'iBall');
INSERT INTO company_mast VALUES(13,'Epsion');
INSERT INTO company_mast VALUES(14,'Zebronics');
INSERT INTO company_mast VALUES(15,'Asus');
INSERT INTO company_mast VALUES(16,'Frontech');

	--Retrieve data from company master--

SELECT * FROM company_mast;

	--create table item master--

CREATE TABLE item_mast(
	PRO_ID INT PRIMARY KEY,
	PRO_NAME VARCHAR(250) NOT NULL,
	PRO_PRICE DECIMAL(10,2),
	PRO_COM INT  FOREIGN KEY REFERENCES company_mast(COM_ID)
);

	--insert records into company master--

INSERT INTO item_mast VALUES(101,'Mother Board',3200,15);
INSERT INTO item_mast VALUES(102,'Key Board',450,16);
INSERT INTO item_mast VALUES(103,'ZIP drive',250,14);
INSERT INTO item_mast VALUES(104,'Speaker',550,16);
INSERT INTO item_mast VALUES(105,'Monitor',5000,11);
INSERT INTO item_mast VALUES(106,'DVD drive',900,12);
INSERT INTO item_mast VALUES(107,'CD drive',800,12);
INSERT INTO item_mast VALUES(108,'Printer',2600,13);
INSERT INTO item_mast VALUES(109,'Refill cartridge',350,13);
INSERT INTO item_mast VALUES(110,'Mouse',250,12);

	--Retrieve data from company master--

SELECT * FROM item_mast;

	--create table orders--

CREATE TABLE orders(
	ord_no INT PRIMARY KEY,
	purch_amt DECIMAL(10,2),
	ord_date DATE,
	customer_id INT NOT NULL,
	salesman_id INT
);

	--insert records into orders--

INSERT INTO orders VALUES(70001,150.5,'2012-10-05',3005,5002);
INSERT INTO orders VALUES(70009,270.65,'2012-09-10',3001,5005);
INSERT INTO orders VALUES(70002,65.26,'2012-10-05',3002,5001);
INSERT INTO orders VALUES(70004,110.5,'2012-08-17',3009,5003);
INSERT INTO orders VALUES(70007,948.5,'2012-09-10',3005,5002);
INSERT INTO orders VALUES(70005,2400.6,'2012-07-27',3007,5001);
INSERT INTO orders VALUES(70008,5760,'2012-09-10',3002,5001);
INSERT INTO orders VALUES(70010,1983.43,'2012-10-10',3004,5006);
INSERT INTO orders VALUES(70003,2480.4,'2012-10-10',3009,5003);
INSERT INTO orders VALUES(70012,250.45,'2012-06-27',3008,5002);
INSERT INTO orders VALUES(70011,75.29,'2012-08-17',3003,5007);
INSERT INTO orders VALUES(70013,3045.6,'2012-04-25',3002,5001);

	--Retrieve data from orders--

SELECT * FROM orders;

	--create table salesman--

CREATE TABLE salesman(
	salesman_id INT PRIMARY KEY,
	name VARCHAR(250) NOT NULL,
	city VARCHAR(250),
	commission DECIMAL(5,2)
);

	--insert records into salesman--
	
INSERT INTO salesman VALUES(5001,'James Hoog','New York',0.15);
INSERT INTO salesman VALUES(5002,'Nail Knite','Paris',0.13);
INSERT INTO salesman VALUES(5005,'Pit Alex','London',0.11);
INSERT INTO salesman VALUES(5006,'Mc Lyon','Paris',0.14);
INSERT INTO salesman VALUES(5007,'Paul Adam','Rome',0.13);
INSERT INTO salesman VALUES(5003,'Lauson Hen','San Jose',0.12);

	--Retrieve data from salesman--

SELECT * FROM salesman;

	--create table customer--

CREATE TABLE customer(
	customer_id INT PRIMARY KEY,
	cust_name VARCHAR(250) NOT NULL,
	city VARCHAR(250),
	grade INT,
	salesman_id INT FOREIGN KEY REFERENCES salesman(salesman_id)
);

	--insert records into customer--
	
INSERT INTO customer VALUES(3002,'Nick Rimando','New York',100,5001);
INSERT INTO customer VALUES(3007,'Brad Davis','New York',200,5001);
INSERT INTO customer VALUES(3005,'Graham Zusi','California',200,5002);
INSERT INTO customer VALUES(3008,'Julian Green','London',300,5002);
INSERT INTO customer VALUES(3004,'Fabian Johnson','Paris',300,5006);
INSERT INTO customer VALUES(3009,'Geoff Cameron','Berlin',100,5003);
INSERT INTO customer VALUES(3003,'Jozy Altidor','Moscow',200,5007);
INSERT INTO customer(customer_id,cust_name,city,salesman_id) VALUES(3001,'Brad Guzan','London',5005);

	--Retrieve data from customer--
	
SELECT * FROM customer;


	--alter orders table to add foreign key on customer_id and salesman_id--

ALTER TABLE orders
ADD CONSTRAINT FK_salesmanId
FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id);

ALTER TABLE orders
ADD CONSTRAINT FK_customerId
FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

	--(1) Write a SQL statement to find the total purchase amount of all orders. --->>>>>
SELECT SUM(purch_amt) AS total_purchase_amount FROM orders;

	--(2) Write a SQL statement to find the average purchase amount of all orders ---->>>>
SELECT AVG(purch_amt) AS average_purchase_amount FROM orders;

	--(3) Write a SQL statement to find the number of salesmen currently listing for all of their customers --->>>
SELECT COUNT(DISTINCT salesman_id) AS num_of_listed_salesman FROM customer;

	--(4) Write a SQL statement to know how many customer have listed their names. -->>>
SELECT COUNT(customer_id) AS num_customers FROM customer;

	--(5) Write a SQL statement find the number of customers who gets at least a gradation for his/her performance -->>
SELECT COUNT(*) AS num_customer_with_garde FROM customer WHERE grade IS NOT NULL;

	--(6) Write a SQL statement to get the maximum purchase amount of all the orders -->>
SELECT MAX(purch_amt) AS Max_purchase_amount FROM orders;

	--(7) Write a SQL statement to get the minimum purchase amount of all the orders -->>
SELECT MIN(purch_amt) AS Min_purchase_amount FROM orders;

	--(8) Write a SQL statement which selects the highest grade for each of the cities of the customers -->>
SELECT city, MAX(grade) AS highest_grade FROM customer GROUP BY city;

	--(9) Write a SQL statement to find the highest purchase amount ordered by the each customer with their ID and highest purchase amount. -->>>
SELECT customer_id, MAX(purch_amt) AS highest_purchase_amount FROM orders
GROUP BY customer_id;

	--(10) Write a SQL statement to find the highest purchase amount ordered by the each customer on a particular date with their ID, order date and highest purchase amount. -->>
SELECT customer_id, ord_date, MAX(purch_amt) AS highest_purchase_amount FROM orders 
GROUP BY customer_id, ord_date;

	--(11) Write a SQL statement to find the highest purchase amount on a date '2012-08-17' for each salesman with their ID.-->>>
SELECT salesman_id, MAX(purch_amt) AS highest_purchase_amount FROM orders
WHERE ord_date = '2012-08-17'
GROUP BY salesman_id;

	--(12) Write a SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have highest purchase amount in a day is more than 2000. -->>>
SELECT customer_id,ord_date,MAX(purch_amt) AS highest_purchase_amount FROM orders 
GROUP BY customer_id, ord_date
HAVING MAX(purch_amt) > 2000; 

	--(13) Write a SQL statement to find the highest purchase amount with their ID and order date, for those customers who have a higher purchase amount in a day is within the range 2000 and 6000 --->>>
SELECT customer_id,ord_date,MAX(purch_amt) AS highest_purchase_amount FROM orders
GROUP BY customer_id, ord_date
HAVING MAX(purch_amt) BETWEEN 2000 AND 6000;

	--(14) Write a SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have a higher purchase amount in a day is within the list 2000, 3000, 5760 and 6000 --->>
SELECT customer_id,ord_date,MAX(purch_amt) AS highest_purchase_amount FROM orders
GROUP BY customer_id, ord_date
HAVING MAX(purch_amt) IN(2000,3000,5760,6000);

	--(15) Write a SQL statement to find the highest purchase amount with their ID, for only those customers whose ID is within the range 3002 and 3007. -->>
SELECT customer_id, MAX(purch_amt) AS highest_purchase_amount FROM orders
GROUP BY customer_id
HAVING customer_id BETWEEN 3002 AND 3007;

	--(16) Write a SQL statement to display customer details (ID and purchase amount) whose IDs are within the range 3002 and 3007 and highest purchase amount is more than 1000. -->>
SELECT customer_id, MAX(purch_amt) AS highest_purchase_amount FROM orders
WHERE customer_id BETWEEN 3002 AND 3007
GROUP BY customer_id
HAVING MAX(purch_amt) > 1000 ;

	--(17) Write a SQL statement to find the highest purchase amount with their ID, for only those salesmen whose ID is within the range 5003 and 5008. -->>
SELECT salesman_id, MAX(purch_amt) AS highest_purchase_amount FROM orders
GROUP BY salesman_id
HAVING salesman_id BETWEEN 5003 AND 5008;

	--(18) Write a SQL statement that counts all orders for a date August 17th, 2012. -->>
SELECT COUNT(ord_date) AS num_of_orders FROM orders
WHERE ord_date = '2012-08-17';

	--(19) Write a SQL statement that count the number of salesmen for whom a city is specified. Note that there may be spaces or no spaces in the city column if no city is specified. -->>
SELECT COUNT(*) AS num_of_salesman_with_city FROM salesman
WHERE city IS NOT NULL;

	--(20) Write a query that counts the number of salesmen with their order date and ID registering orders for each day. -->>
SELECT salesman_id, COUNT(salesman_id) AS num_of_salesman, ord_date FROM orders
GROUP BY ord_date,salesman_id;

	--(21) Write a SQL query to calculate the average price of all the products. -->>>
SELECT AVG(PRO_PRICE) AS average_price FROM item_mast;

	--(22) Write a SQL query to find the number of products with a price more than or equal to Rs.350. --->>>
SELECT COUNT(*) AS num_of_product FROM item_mast
WHERE PRO_PRICE >= 350;

	--(23) Write a SQL query to display the average price of each company's products, along with their code. -->>
SELECT AVG(PRO_PRICE) AS average_price, PRO_COM FROM item_mast
GROUP BY PRO_COM;

	--(24) Write a query in SQL to find the sum of the allotment amount of all departments.  -->>>
SELECT SUM(DPT_ALLOTMENT) AS allotment_amount FROM emp_department;

	--(25) Write a query in SQL to find the number of employees in each department along with the department code. -->>
SELECT COUNT(EMP_IDNO) AS num_of_emp, EMP_DEPT AS dept_code FROM emp_details
GROUP BY EMP_DEPT;
