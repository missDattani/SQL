USE PD326PoojaDattani;

CREATE TABLE Customer_new(
	CustomerId INT PRIMARY KEY IDENTITY(1,1),
	CustomerName VARCHAR(250),
	CustomerAddress VARCHAR(MAX),
	CustomerContact VARCHAR(100),
	CustomerCityId INT,
	Salesmanid INT
);

CREATE TABLE City_Info(
	Id INT PRIMARY KEY IDENTITY(1,1),
	CityName VARCHAR(100),
	StateName VARCHAR(100),
	CountryName VARCHAR(100)
);

CREATE TABLE Sales_Person(
	SalesmanId INT PRIMARY KEY IDENTITY(1,1),
	SalesmanName VARCHAR(250),
	SalesmanCityId INT,
	SalesmanComission DECIMAL(10,2)
);

CREATE TABLE Order_Info(
	OrderId INT PRIMARY KEY IDENTITY(1,1),
	OrderAmount DECIMAL(10,2),
	OrderDate DATE,
	CustomerId INT,
	SalesmanId INT
);

CREATE TABLE Product_Info(
	ProductId INT PRIMARY KEY IDENTITY(1,1),
	ProductName VARCHAR(250),
	ProductDetails TEXT,
	OrderId INT
);

ALTER PROCEDURE sp_Ins
AS
BEGIN
DECLARE
@Count INT;
SET @Count = 0;
WHILE(@Count < 200)
	BEGIN
		INSERT INTO Customer_new VALUES('ABC','bsdhvwevajw','9348728387',1,2);
		INSERT INTO Customer_new VALUES('CMS','jkrgheh','9344356322',2,4);
		INSERT INTO Customer_new VALUES('SJB','jkhferf','9643435663',4,3);
		INSERT INTO Customer_new VALUES('NSH','jsdfbfr','9632458945',3,5);
		INSERT INTO Customer_new VALUES('SJH','jhwegyu','9952437565',5,1);
		SET @Count = @Count + 1;
		END
END

EXEC sp_Ins;

DROP PROCEDURE sp_Ins;

DELETE FROM Customer_new;
DROP TABLE Customer_new;

ALTER PROCEDURE sp_InsCity
AS
BEGIN
DECLARE
@Count INT;
SET @Count = 0;
WHILE(@Count < 200)
	BEGIN
		INSERT INTO City_Info VALUES('Ahemdabad','Gujarat','India');
		INSERT INTO City_Info VALUES('DWARKA','Gujarat','India');
		INSERT INTO City_Info VALUES('Indore','MadhyaPradesh','India');
		INSERT INTO City_Info VALUES('Bhopal','MadhyaPradesh','India');
		INSERT INTO City_Info VALUES('Chicago','Illinois','USA');
		SET @Count = @Count + 1;
		END
END

EXEC sp_InsCity;

DROP TABLE City_Info;

ALTER PROCEDURE sp_InsSalesman
AS
BEGIN
DECLARE
@Count INT;
SET @Count = 0;
WHILE(@Count < 200)
	BEGIN
		INSERT INTO Sales_Person VALUES('JGHD',3,0.10);
		INSERT INTO Sales_Person VALUES('JDSI',2,0.12);
		INSERT INTO Sales_Person VALUES('UNSJ',4,0.20);
		INSERT INTO Sales_Person VALUES('OLSM',1,0.15);
		INSERT INTO Sales_Person VALUES('JWSU',5,0.11);
		SET @Count = @Count + 1;
		END
END

EXEC sp_InsSalesman;

DROP TABLE Sales_Person;

ALTER PROCEDURE sp_InsOrder
AS
BEGIN
DECLARE
@Count INT;
SET @Count = 0;
WHILE(@Count < 200)
	BEGIN
		INSERT INTO Order_Info VALUES(200,'2022-12-21',2,4);
		INSERT INTO Order_Info VALUES(3000,'2022-11-02',4,3);
		INSERT INTO Order_Info VALUES(550,'2022-10-12',5,1);
		INSERT INTO Order_Info VALUES(1000,'2022-06-25',1,5);
		INSERT INTO Order_Info VALUES(5000,'2022-07-19',3,2);
		SET @Count = @Count + 1;
		END
END

EXEC sp_InsOrder; 

DROP TABLE Order_Info;

ALTER PROCEDURE sp_InsProduct
AS
BEGIN
DECLARE
@Count INT;
SET @Count = 0;
WHILE(@Count < 200)
	BEGIN
		INSERT INTO Product_Info VALUES('Samsung 11','jdsavdhwdgwvdwjhd',2);
		INSERT INTO Product_Info VALUES('Oppo F21','jdsavdhwdgwvdwjhd',1);
		INSERT INTO Product_Info VALUES('Nokia','jdsavdhwdgwvdwjhd',4);
		INSERT INTO Product_Info VALUES('POCO 10','jdsavdhwdgwvdwjhd',3);
		INSERT INTO Product_Info VALUES('RealMe','jdsavdhwdgwvdwjhd',5);
		SET @Count = @Count + 1;
		END
END

EXEC sp_InsProduct; 

DROP TABLE Product_Info;

SELECT ProductName, COUNT(ProductName) FROM Product_Info
GROUP BY ProductName;

SELECT OrderDate, COUNT(OrderDate) FROM Order_Info
GROUP BY OrderDate;

SELECT SalesmanName, COUNT(SalemanName) FROM Sales_Person
GROUP BY OrderDate;



SELECT * FROM Customer_new;
SELECT * FROM City_Info;
SELECT * FROM Sales_Person;
SELECT * FROM Order_Info;
SELECT * FROM Product_Info;

SELECT CustomerContact, COUNT(CustomerContact) AS "No_of_Contacts" FROM Customer_new
WHERE CustomerContact LIKE '93%'
GROUP BY CustomerContact;




