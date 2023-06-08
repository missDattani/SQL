USE PD326PoojaDattani;

CREATE TABLE EmployeesDetail(
	Employee_id INT PRIMARY KEY IDENTITY(1,1),
	Employee_LastName VARCHAR(250),
	Employee_FirstName VARCHAR(250),
	Employee_Title VARCHAR(250),
	Employee_DOB DATE,
	Employee_DOH DATE,
	Employee_ReportsTo INT,
	Employee_Address VARCHAR(MAX)
);

CREATE TABLE OrdersDetail(
	Order_ID INT PRIMARY KEY IDENTITY(101,1),
	Customer_ID INT,
	Employee_ID INT,
	Order_date DATE
);

CREATE TABLE CustomerDetail(
	Customer_ID INT PRIMARY KEY IDENTITY(1001,1),
	Company_Name VARCHAR(250),
	Contact_Name VARCHAR(250),
	Contact_Title VARCHAR(250),
	Customer_Address VARCHAR(MAX),
	Customer_City VARCHAR(100),
	Customer_Country VARCHAR(100)
);

ALTER TABLE OrdersDetail
ADD CONSTRAINT FK_Customer
FOREIGN KEY (Customer_ID) REFERENCES CustomerDetail(Customer_ID);

ALTER TABLE OrdersDetail
ADD CONSTRAINT FK_Employee
FOREIGN KEY (Employee_ID) REFERENCES EmployeesDetail(Employee_ID);

INSERT INTO EmployeesDetail VALUES('Doe','John','HR','2000-02-28','2018-02-01',1,'jksdjgfgwekfgh,hvsaghdw');
INSERT INTO EmployeesDetail VALUES('Johnson','Mack','Department Head','1997-03-01','2015-01-01',2,'jksdjgfgwekfgh,hvsaghdw');
INSERT INTO EmployeesDetail VALUES('Winget','Zanifer','Project Manager','1999-04-15','2019-03-01',1,'jksdjgfgwekfgh,hvsaghdw');
INSERT INTO EmployeesDetail VALUES('Johar','Abigiel','Web Designer','2001-06-16','2022-01-01',3,'jkgfgwekfgh,hhdw');
INSERT INTO EmployeesDetail VALUES('Thakkar','Joy','HR','1997-07-22','2016-02-01',2,'gwekfgh,hghdw');
INSERT INTO EmployeesDetail VALUES('Jones','Smith','Web Developer','2000-08-30','2023-02-01',3,'jksdh,hvs');
INSERT INTO EmployeesDetail VALUES('Khan','Dev','Team Lead','1999-10-22','2016-01-01',1,'jkgh,hvghdw');
INSERT INTO EmployeesDetail VALUES('Dogra','Stephen','Project Manager','1997-05-03','2016-03-01',2,'jksdjggh,ghdw');


INSERT INTO OrdersDetail VALUES(1001,1,'2023-03-11');
INSERT INTO OrdersDetail VALUES(1003,6,'2022-12-21');
INSERT INTO OrdersDetail VALUES(1003,2,'2023-03-10');
INSERT INTO OrdersDetail VALUES(1008,4,'2022-11-11');
INSERT INTO OrdersDetail VALUES(1005,8,'2022-12-02');
INSERT INTO OrdersDetail VALUES(1002,5,'2023-02-23');
INSERT INTO OrdersDetail VALUES(1002,6,'2023-01-25');
INSERT INTO OrdersDetail VALUES(1004,4,'2022-10-29');
INSERT INTO OrdersDetail(Customer_ID,Employee_ID) VALUES(1001,1);
INSERT INTO OrdersDetail(Customer_ID,Employee_ID) VALUES(1008,2);
INSERT INTO OrdersDetail VALUES(1003,3,'2022-10-29');


INSERT INTO CustomerDetail VALUES('Shaligram','ABC','HR','hgdsuoiqhjsc','OKHA','INDIA');
INSERT INTO CustomerDetail VALUES('Shaligram','NFM','Team Lead','hgdsfdvc','New York','USA');
INSERT INTO CustomerDetail VALUES('Synoverge','DBD','Project Head','hsdjwgnd','Ahemdabad','INDIA');
INSERT INTO CustomerDetail VALUES('AIMDeck','HDK','HR','iosjdghwe','Pune','INDIA');
INSERT INTO CustomerDetail VALUES('Simform','JHS','Project Manager','hgdgwq','Chicago','USA');
INSERT INTO CustomerDetail VALUES('Simfrom','JDH','HR','hwqdgquwu','Rajkot','INDIA');
INSERT INTO CustomerDetail VALUES('Whappnet','DKL','Team Lead','hsdajhi','Phoenix','USA');
INSERT INTO CustomerDetail VALUES('EquitySoft','JSK','Project Head','oksaxmbw','Jamnagar','INDIA');
INSERT INTO CustomerDetail VALUES('Redixweb','KMD','HR','jsajbjhqwb','Ahemdabad','INDIA');

SELECT * FROM EmployeesDetail;
SELECT * FROM OrdersDetail;
SELECT * FROM CustomerDetail;

	--Write a SQL query to retrieve the list of all orders made by customers in the "USA". -->>

SELECT * FROM OrdersDetail O
INNER JOIN CustomerDetail C ON  O.Customer_ID = C.Customer_ID
WHERE Customer_Country = 'USA';

	--Write a SQL query to retrieve the list of all customers who have placed an order -->>

SELECT * FROM CustomerDetail C
INNER JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
WHERE O.Order_date IS NOT NULL;


	--Write a SQL query to retrieve the list of all employees who have not yet placed an order. -->>

SELECT * FROM EmployeesDetail E
INNER JOIN OrdersDetail O ON  E.Employee_id = O.Employee_ID
WHERE O.Order_date IS NULL;


	--Write a SQL query to retrieve the list of all employees who have placed an order. -->>

SELECT * FROM EmployeesDetail E
INNER JOIN OrdersDetail O ON  E.Employee_id = O.Employee_ID
WHERE O.Order_date IS NOT NULL;


	--Write a SQL query to retrieve the list of all customers who have not yet placed an order. -->>

SELECT * FROM CustomerDetail C
INNER JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
WHERE O.Order_date IS NULL;


	--Write a SQL query to retrieve the list of all customers who have placed an order, along with the order date. -->>

SELECT C.Customer_ID,C.Company_Name,C.Contact_Title,O.Order_date FROM CustomerDetail C
INNER JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
WHERE O.Order_date IS NOT NULL;


	--Write a SQL query to retrieve the list of all orders placed by a particular customer -->>

SELECT C.Customer_ID,C.Company_Name,O.Order_ID,O.Order_date FROM CustomerDetail C
LEFT JOIN OrdersDetail O ON C.Customer_ID = O.Customer_ID
WHERE O.Order_date IS NOT NULL AND C.Customer_ID = 1002;

	--Write a SQL query to retrieve the list of all orders placed by a particular employee. -->>

SELECT * FROM EmployeesDetail E
LEFT JOIN OrdersDetail O ON E.Employee_id = O.Employee_ID
WHERE O.Order_date IS NOT NULL AND E.Employee_id = 4;


	--Write a SQL query to retrieve the list of all orders placed by a particular customer on a particular date. -->>

SELECT * FROM CustomerDetail C
LEFT JOIN OrdersDetail O ON C.Customer_ID = O.Customer_ID
WHERE C.Customer_ID = 1003 AND O.Order_date = '2022-10-29';


	--Write a SQL query to retrieve the list of all customers who have not yet placed an order, sorted by their country. -->>

SELECT * FROM CustomerDetail C
INNER JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
WHERE O.Order_date IS NULL
ORDER BY C.Customer_Country;

	--Write a SQL query to retrieve the list of all orders placed by customers in the "USA", sorted by order date. -->>

SELECT * FROM OrdersDetail O
INNER JOIN CustomerDetail C ON  O.Customer_ID = C.Customer_ID
WHERE Customer_Country = 'USA' AND O.Order_date IS NOT NULL
ORDER BY O.Order_date;

	--Write a SQL query to retrieve the list of all employees who have not yet placed an order, sorted by last name. -->>

SELECT * FROM EmployeesDetail E
INNER JOIN OrdersDetail O ON  E.Employee_id = O.Employee_ID
WHERE O.Order_date IS NULL
ORDER BY E.Employee_LastName;

	--Write a SQL query to retrieve the list of all customers who have placed an order, sorted by their company name. -->>

SELECT * FROM CustomerDetail C
INNER JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
WHERE O.Order_date IS NOT NULL
ORDER BY C.Company_Name;

	--Write a SQL query to retrieve the list of all employees who have placed an order, sorted by their hire date. -->>

SELECT * FROM EmployeesDetail E
INNER JOIN OrdersDetail O ON  E.Employee_id = O.Employee_ID
WHERE O.Order_date IS NOT NULL
ORDER BY E.Employee_DOH;

	--Write a SQL query to retrieve the list of all customers who have placed an order on a particular date, sorted by their company name. -->>

SELECT * FROM CustomerDetail C
LEFT JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
WHERE O.Order_date IS NOT NULL AND O.Order_date = '2022-10-29'
ORDER BY C.Company_Name;

	--Write a SQL query to retrieve the list of all customers who have placed an order, along with the employee who handled the order.-->>

SELECT C.Customer_ID,O.Order_date,E.Employee_id,E.Employee_FirstName FROM CustomerDetail C
LEFT JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
INNER JOIN EmployeesDetail E ON E.Employee_id = O.Employee_ID
WHERE O.Order_date IS NOT NULL
GROUP BY E.Employee_id,C.Customer_ID,O.Order_date,E.Employee_FirstName;


	--Write a SQL query to retrieve the list of all employees who have placed an order, along with the customer who placed the order. -->>

SELECT C.Customer_ID,O.Order_date,E.Employee_id FROM EmployeesDetail E
LEFT JOIN OrdersDetail O ON  E.Employee_id = O.Employee_ID
INNER JOIN CustomerDetail C ON C.Customer_ID = O.Customer_ID
WHERE O.Order_date IS NOT NULL
GROUP BY E.Employee_id,C.Customer_ID,O.Order_date;


	--Write a SQL query to retrieve the list of all orders placed by customers in a particular country, along with the customer name and order date. -->>

SELECT C.Customer_ID,C.Contact_Name,O.Order_date FROM CustomerDetail C
INNER JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
WHERE O.Order_date IS NOT NULL AND C.Customer_Country = 'INDIA';

	--Write a SQL query to retrieve the list of all orders placed by employees who were born in a particular year, along with the employee name and order date. -->>

SELECT E.Employee_id,E.Employee_FirstName,E.Employee_DOB,O.Order_date FROM EmployeesDetail E
LEFT JOIN OrdersDetail O ON  E.Employee_id = O.Employee_ID
WHERE O.Order_date IS NOT NULL AND E.Employee_DOB BETWEEN '2000-01-01' AND '2000-12-31';

	--Write a SQL query to retrieve the list of all customers who have placed an order, along with the customer name, order date, and employee who handled the order.-->>

SELECT C.Customer_ID,C.Contact_Name,O.Order_date,E.Employee_id,E.Employee_FirstName FROM CustomerDetail C
LEFT JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
INNER JOIN EmployeesDetail E ON E.Employee_id = O.Employee_ID
WHERE O.Order_date IS NOT NULL
GROUP BY C.Customer_ID,C.Contact_Name,O.Order_date, E.Employee_id,E.Employee_FirstName;


	--Write a SQL query to retrieve the list of all orders placed by customers who have a particular contact title, along with the customer name and order date. -->>

SELECT C.Customer_ID,C.Contact_Name,C.Contact_Title,O.Order_date FROM CustomerDetail C
INNER JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
WHERE O.Order_date IS NOT NULL AND C.Contact_Title = 'HR';

	--Write a SQL query to retrieve the list of all orders placed by employees who have a particular job title, along with the employee name and order date. -->>

SELECT E.Employee_id,E.Employee_FirstName,E.Employee_Title,O.Order_date FROM EmployeesDetail E
LEFT JOIN OrdersDetail O ON  E.Employee_id = O.Employee_ID
WHERE O.Order_date IS NOT NULL AND Employee_Title = 'Project Manager';

	--Write a SQL query to retrieve the list of all customers who have placed an order on a particular date, along with the customer name, order date, and employee who handled the order.-->>

SELECT C.Customer_ID,C.Contact_Name,O.Order_date,E.Employee_id FROM CustomerDetail C
LEFT JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
INNER JOIN EmployeesDetail E ON E.Employee_id = O.Employee_ID
WHERE O.Order_date IS NOT NULL AND O.Order_date = '2022-10-29';

	--Write a SQL query to retrieve the list of all orders placed by customers in a particular city, along with the customer name and order date. -->>

SELECT C.Customer_ID,C.Contact_Name,C.Customer_City,O.Order_date FROM CustomerDetail C
INNER JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
WHERE O.Order_date IS NOT NULL AND C.Customer_City = 'Ahemdabad';


	--Write a SQL query to retrieve the list of all orders placed by employees who were born in a particular city, along with the employee name and order date. -->>

SELECT E.Employee_id,E.Employee_FirstName,E.Employee_DOB,O.Order_date,C.Customer_City FROM EmployeesDetail E
LEFT JOIN OrdersDetail O ON  E.Employee_id = O.Employee_ID
INNER JOIN CustomerDetail C ON C.Customer_ID = O.Customer_ID
WHERE O.Order_date IS NOT NULL AND C.Customer_City ='Ahemdabad';

	--Write a SQL query to retrieve the list of all customers who have placed an order, along with the customer name, order date, and employee who handled the order, sorted by order date. -->>

SELECT C.Customer_ID,C.Contact_Name,C.Customer_City,O.Order_date,E.Employee_id FROM CustomerDetail C
LEFT JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
INNER JOIN EmployeesDetail E ON E.Employee_id = O.Employee_ID
WHERE O.Order_date IS NOT NULL
ORDER BY O.Order_date;


	--Write a SQL query to retrieve the list of all orders placed by customers in a particular country, along with the customer name and order date, sorted by order date. -->>

SELECT C.Customer_ID,C.Contact_Name,C.Customer_Country,O.Order_date FROM CustomerDetail C
INNER JOIN OrdersDetail O ON  C.Customer_ID = O.Customer_ID
WHERE O.Order_date IS NOT NULL AND C.Customer_Country = 'USA'
ORDER BY O.Order_date;