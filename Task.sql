USE PD326PoojaDattani;


CREATE TABLE Customer_new(
	CustomerId INT PRIMARY KEY IDENTITY(1,1),
	CustomerName VARCHAR(250),
	CustomerAddress VARCHAR(MAX),
	CustomerContact VARCHAR(100),
	CustomerCityId INT,
	Salesmanid INT
);

ALTER TABLE Customer_new
ADD FOREIGN KEY (CustomerCityId) REFERENCES City_Info(Id);

ALTER TABLE Customer_new
ADD FOREIGN KEY (Salesmanid) REFERENCES Sales_Person(SalesmanId);

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

ALTER TABLE Sales_Person
ADD FOREIGN KEY (SalesmanCityId) REFERENCES City_Info(Id);

CREATE TABLE Order_Info(
	OrderId INT PRIMARY KEY IDENTITY(1,1),
	OrderAmount DECIMAL(10,2),
	OrderDate DATE,
	CustomerId INT,
	SalesmanId INT
);

ALTER TABLE Order_Info
ADD FOREIGN KEY (CustomerId) REFERENCES Customer_new(CustomerId);

ALTER TABLE Order_Info
ADD FOREIGN KEY (SalesmanId) REFERENCES Sales_Person(SalesmanId);

CREATE TABLE Product_Info(
	ProductId INT PRIMARY KEY IDENTITY(1,1),
	ProductName VARCHAR(250),
	ProductDetails TEXT,
	OrderId INT
);

ALTER TABLE Product_Info
ADD FOREIGN KEY (OrderId) REFERENCES Order_Info(OrderId);


INSERT INTO Customer_new VALUES('ABC','bsdhvwevajw','9348728387',1,2);
INSERT INTO Customer_new VALUES('CMS','jkrgheh','9344356322',2,4);
INSERT INTO Customer_new VALUES('SJB','jkhferf','9643435663',4,3);
INSERT INTO Customer_new VALUES('NSH','jsdfbfr','9632458945',3,5);
INSERT INTO Customer_new VALUES('SJH','jhwegyu','9952437565',5,1);

INSERT INTO City_Info VALUES('Ahemdabad','Gujarat','India');
INSERT INTO City_Info VALUES('DWARKA','Gujarat','India');
INSERT INTO City_Info VALUES('Indore','MadhyaPradesh','India');
INSERT INTO City_Info VALUES('Bhopal','MadhyaPradesh','India');
INSERT INTO City_Info(CityName,CountryName) VALUES('Chicago','USA');

INSERT INTO Sales_Person VALUES('JGHD',3,0.10);
INSERT INTO Sales_Person VALUES('JDSI',2,0.12);
INSERT INTO Sales_Person VALUES('UNSJ',4,0.20);
INSERT INTO Sales_Person VALUES('OLSM',1,0.15);
INSERT INTO Sales_Person VALUES('JWSU',5,0.11);

INSERT INTO Order_Info VALUES(200,'2022-12-21',2,4);
INSERT INTO Order_Info VALUES(3000,'2022-11-02',4,3);
INSERT INTO Order_Info VALUES(550,'2022-10-12',5,1);
INSERT INTO Order_Info VALUES(1000,'2022-06-25',1,5);
INSERT INTO Order_Info VALUES(5000,'2022-07-19',3,2);



