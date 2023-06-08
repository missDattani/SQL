USE PD326PoojaDattani;
---- Instruction to follow 
--	--Insert Data Accurate and Appropiate.
--	--Choose data type wisely.
--	-- No reference taking.
--	--No Drop of any table should be done.
--	--Insert at least 10 data in the table.
--	--Not to use any previous tables.
--	--Where there is Update there should be Transactions
--	-- Good to Have Insert Data with Storeprocuder

--Create Table Customer [5]
--	--Id
--	--Name
--	--UserName (Must be unique)
--	--Password
--	--Email (Must be unique)
--	--DOB
--	--Address
--	--ContactNo

CREATE TABLE Customer1(
	Id INT IDENTITY(1,1),
	Name VARCHAR(200),
	UserName VARCHAR(250),
	Password VARCHAR(150),
	Email VARCHAR(100),
	DOB DATE,
	Address VARCHAR(MAX),
	ContactNo VARCHAR(50)
);

ALTER TABLE Customer1
ADD CONSTRAINT pk_Id PRIMARY KEY (Id);

ALTER TABLE Customer1
ADD CONSTRAINT uk_Id UNIQUE (UserName,Email);
	
--Create Table Salesman
--	--Id
--	--Name
--	--UserName
--	--Password
--	--Email
--	--DOB
--	--Address
--	--ContactNo

CREATE TABLE Salesman1(
	Id INT IDENTITY(1,1),
	Name VARCHAR(250),
	UserName VARCHAR(250),
	Password VARCHAR(150),
	Email VARCHAR(100),
	DOB DATE,
	Address VARCHAR(MAX),
	ContactNo VARCHAR(50)
);

ALTER TABLE Salesman1
ADD CONSTRAINT pk_SId PRIMARY KEY (Id);

--Create Table Category
--	--Id
--	--Name

CREATE TABLE Category1(
	Id INT IDENTITY(1,1),
	Name VARCHAR(250)
);

ALTER TABLE Category1
ADD CONSTRAINT pk_CId PRIMARY KEY (Id);
	
--Create Table Items
--	--Id
--	--Name
--	--Category (link to category)
--	--Rate
--	--DOM (Date of Manufacture)
--	--DOE (Date of Expire) 

CREATE TABLE Items1(
	Id INT IDENTITY(1,1),
	Name VARCHAR(250),
	Category INT,
	Rate DECIMAL(10,2),
	DOM DATE,
	DOE DATE
);

ALTER TABLE Items1
ADD CONSTRAINT pk_IId PRIMARY KEY (Id);

ALTER TABLE Items1
ADD CONSTRAINT fk_Cat FOREIGN KEY (Category) REFERENCES Category1(Id);

--Create Table ModeOfPayment
--	--Id
--	--Name


CREATE TABLE ModOfPayment(
	Id INT IDENTITY(1,1),
	Name VARCHAR(250)
);

ALTER TABLE ModOfPayment
ADD CONSTRAINT pk_MId PRIMARY KEY (Id);
	
--Create Table Orders
--	--Id
--	--OrderNo (Must be Unique)
--	--Customer (link to customer)
--	--OrderQty 
--	--Bill Amount
--	--DOD (Date of Delivery)
--	--Salesman (link to salesman)
--	--DeliveryAddress
--	--City
--	--ContactNo
--	--MOP (Mode of Payment) (link to payment)
--	--OrderStatus (By default 0 if I cancel then should be update to 1)

CREATE TABLE Orders1(
	Id INT IDENTITY(1,1),
	OrderNo INT,
	Customer INT,
	OrderQty INT,
	Bill_Amt DECIMAL(10,2),
	DOD DATE,
	Salesman INT,
	DAddress VARCHAR(MAX),
	City VARCHAR(50),
	ContactNo VARCHAR(50),
	MOP INT,
	OrderStatus INT
);

ALTER TABLE Orders1
ADD CONSTRAINT pk_OId PRIMARY KEY (Id);

ALTER TABLE Orders1
ADD CONSTRAINT uk_oId UNIQUE (OrderNo);
	
ALTER TABLE Orders1
ADD CONSTRAINT fk_ord FOREIGN KEY (Customer) REFERENCES Customer1(Id);

ALTER TABLE Orders1
ADD CONSTRAINT fk_sord FOREIGN KEY (Salesman) REFERENCES Salesman1(Id);

ALTER TABLE Orders1
ADD CONSTRAINT fk_pord FOREIGN KEY (MOP) REFERENCES ModOfPayment(Id);

ALTER TABLE Orders1
ADD DEFAULT 0 FOR OrderStatus;

--Create Table OrderDetails
--	--Id
--	--OrderId (link to order)
--	--ItemId (link to Items)
--	--OrderQty (Order Quantity per Items)
--	--OrderAmount (Qty * Rate)

CREATE TABLE OrderDetails1(
	Id INT IDENTITY(1,1),
	OrderId INT,
	ItemId INT,
	OrderQty INT,
	Order_Amt DECIMAL(10,2)
);


ALTER TABLE OrderDetails1
ADD CONSTRAINT pk_OdId PRIMARY KEY (Id);

ALTER TABLE OrderDetails1
ADD CONSTRAINT fk_odrd FOREIGN KEY (OrderId) REFERENCES Orders1(Id);

ALTER TABLE OrderDetails1
ADD CONSTRAINT fk_oird FOREIGN KEY (ItemId) REFERENCES Items1(Id);

--Questions : 

--1. After Creating Table , need to update All table with Primary Key , Clustor Key  and Add Identity [5]

--2. Create a Parameterized Store Procedure to Insert/Update Data in each of tables listed above. (If Primary key of that table is passed then Update else Insert) [8]
--	E.g : SP_AddEditCustomer (By using this procedure I will be able to insert or update data)

GO
CREATE OR ALTER PROCEDURE InsOrUpdateCustomer1
	@Id INT,
	@Name VARCHAR(200),
	@UserName VARCHAR(250),
	@Password VARCHAR(150),
	@Email VARCHAR(100),
	@DOB DATE,
	@Address VARCHAR(MAX),
	@ContactNo VARCHAR(50)
AS
BEGIN
	BEGIN TRY
	BEGIN
		IF (@Id IS NULL)
		BEGIN
		INSERT INTO Customer1 VALUES(@Name, @UserName, @Password, @Email, @DOB, @Address, @ContactNo)
		END
	ELSE 
		BEGIN 
		BEGIN TRAN
			UPDATE Customer1 SET Name=@Name, UserName = @UserName, Password = @Password, Email = @Email, DOB = @DOB, Address = @Address, ContactNo = @ContactNo WHERE Id = @Id;
		COMMIT TRAN
		END 
	END
	END TRY
	BEGIN CATCH
		--ROLLBACK TRAN
	END CATCH
END;
GO

EXEC InsOrUpdateCustomer1 NULL,'John','John123','12345','John@gmail.com','2000-10-08','asdhsgjfa,jhashdga','7363572728'
EXEC InsOrUpdateCustomer1 NULL,'Jolly','Jolly123','65738','Jolly@gmail.com','2001-02-12','asdhsgjfa,jhashdga','8273498634'
EXEC InsOrUpdateCustomer1 NULL,'Jack','Jack123','26373','Jack@gmail.com','2002-08-16','asdhsgjfa,jhashdga','0938738293'
EXEC InsOrUpdateCustomer1 NULL,'Mack','Mack123','93933','Mack@gmail.com','1999-09-19','asdhsgjfa,jhashdga','9838327383'
EXEC InsOrUpdateCustomer1 NULL,'Elly','Elly123','65444','Elly@gmail.com','2000-11-04','asdhsgjfa,jhashdga','832846832'
EXEC InsOrUpdateCustomer1 NULL,'Emily','Emily123','75435','Emily@gmail.com','2002-06-16','asdhsgjfa,jhashdga','897234223'
EXEC InsOrUpdateCustomer1 NULL,'Dev','Dev123','45624','Dev@gmail.com','1998-07-22','asdhsgjfa,jhashdga','932487238'
EXEC InsOrUpdateCustomer1 NULL,'Samira','Samira123','56433','Samira@gmail.com','1998-10-03','asdhsgjfa,jhashdga','786387463'
EXEC InsOrUpdateCustomer1 NULL,'Parth','Parth123','53457','Parth@gmail.com','2002-12-21','asdhsgjfa,jhashdga','7623762887'
EXEC InsOrUpdateCustomer1 NULL,'Tanvi','Tanvi123','56733','Tanvi@gmail.com','1997-01-31','asdhsgjfa,jhashdga','98273487623'

GO
CREATE OR ALTER PROCEDURE InsertOrUpdateSalesman1
	@Id INT,
	@Name VARCHAR(250),
	@UserName VARCHAR(250),
	@Password VARCHAR(150),
	@Email VARCHAR(100),
	@DOB DATE,
	@Address VARCHAR(MAX),
	@ContactNo VARCHAR(50)
AS
BEGIN
	BEGIN TRY
		BEGIN
			IF(@Id IS NULL)
			BEGIN
				INSERT INTO Salesman1 VALUES (@Name, @UserName, @Password, @Email, @DOB, @Address, @ContactNo);
			END
			ELSE
			BEGIN
			BEGIN TRAN
				UPDATE Salesman1 SET  Name=@Name, UserName = @UserName, Password = @Password, Email = @Email, DOB = @DOB, Address = @Address, ContactNo = @ContactNo WHERE Id = @Id;
			COMMIT TRAN
			END
		END
	END TRY
	BEGIN CATCH
	END CATCH
END;
GO

EXEC InsertOrUpdateSalesman1 NULL,'Aamna','Aamna123','56733','Aamna@gmail.com','1997-01-31','asdhsgjfa,jhashdga','98273487623'
EXEC InsertOrUpdateSalesman1 NULL,'Aman','Aman123','12345','Aman@gmail.com','2000-10-08','asdhsgjfa,jhashdga','7363572728'
EXEC InsertOrUpdateSalesman1 NULL,'Jolly','Jolly123','65738','Jolly@gmail.com','2001-02-12','asdhsgjfa,jhashdga','8273498634'
EXEC InsertOrUpdateSalesman1 NULL,'Jack','Jack123','26373','Jack@gmail.com','2002-08-16','asdhsgjfa,jhashdga','0938738293'
EXEC InsertOrUpdateSalesman1 NULL,'Mack','Mack123','93933','Mack@gmail.com','1999-09-19','asdhsgjfa,jhashdga','9838327383'
EXEC InsertOrUpdateSalesman1 NULL,'Elly','Elly123','65444','Elly@gmail.com','2000-11-04','asdhsgjfa,jhashdga','832846832'
EXEC InsertOrUpdateSalesman1 NULL,'Emily','Emily123','75435','Emily@gmail.com','2002-06-16','asdhsgjfa,jhashdga','897234223'
EXEC InsertOrUpdateSalesman1 NULL,'Dev','Dev123','45624','Dev@gmail.com','1998-07-22','asdhsgjfa,jhashdga','932487238'
EXEC InsertOrUpdateSalesman1 NULL,'Samira','Samira123','56433','Samira@gmail.com','1998-10-03','asdhsgjfa,jhashdga','786387463'
EXEC InsertOrUpdateSalesman1 NULL,'Parth','Parth123','53457','Parth@gmail.com','2002-12-21','asdhsgjfa,jhashdga','7623762887'

GO
CREATE OR ALTER PROCEDURE InsOrUpdateCategory1
	@Id INT,
	@Name VARCHAR(200)
AS
BEGIN
	BEGIN TRY
	BEGIN
		IF (@Id IS NULL)
		BEGIN
		INSERT INTO Category1 VALUES(@Name)
		END
	ELSE 
		BEGIN 
		BEGIN TRAN
			UPDATE Category1 SET Name=@Name WHERE Id = @Id;
		COMMIT TRAN
		END 
	END
	END TRY
	BEGIN CATCH
		--ROLLBACK TRAN
	END CATCH
END;
GO

EXEC InsOrUpdateCategory1 NULL,'Samsung';
EXEC InsOrUpdateCategory1 NULL,'Oppo';
EXEC InsOrUpdateCategory1 NULL,'Nokia';
EXEC InsOrUpdateCategory1 NULL,'VIVO';
EXEC InsOrUpdateCategory1 NULL,'Samsung';
EXEC InsOrUpdateCategory1 NULL,'RealMe';
EXEC InsOrUpdateCategory1 NULL,'RedMe';
EXEC InsOrUpdateCategory1 NULL,'POCO';
EXEC InsOrUpdateCategory1 NULL,'Motorola';
EXEC InsOrUpdateCategory1 NULL,'IPhone';

SELECT * FROM Category1;

GO
CREATE OR ALTER PROCEDURE InsOrUpdateItems1
	@Id INT,
	@Name VARCHAR(250),
	@Category INT,
	@Rate DECIMAL(10,2),
	@DOM DATE,
	@DOE DATE
AS
BEGIN
	BEGIN TRY
	BEGIN
		IF (@Id IS NULL)
		BEGIN
		INSERT INTO Items1 VALUES(@Name,@Category,@Rate,@DOM,@DOE);
		END
	ELSE 
		BEGIN 
		BEGIN TRAN
			UPDATE Items1 SET Name=@Name, Category = @Category, Rate=@Rate, DOM=@DOM, DOE=@DOE WHERE Id = @Id;
		COMMIT TRAN
		END 
	END
	END TRY
	BEGIN CATCH
		--ROLLBACK TRAN
	END CATCH
END;
GO

EXEC InsOrUpdateItems1 NULL,'IPhone 14',20,87000,'2022-10-19','2023-10-19';
EXEC InsOrUpdateItems1 NULL,'Samsung s21',11,60000,'2022-08-16','2023-10-19';
EXEC InsOrUpdateItems1 NULL,'VIVO v17',14,15000,'2018-06-19','2020-10-19';
EXEC InsOrUpdateItems1 NULL,'Oppo F21S',12,29000,'2021-10-19','2025-09-21';
EXEC InsOrUpdateItems1 NULL,'POCO 8',18,20000,'2022-06-16','2023-05-22';
EXEC InsOrUpdateItems1 NULL,'IPhone 10',20,80000,'2020-05-20','2025-11-01';
EXEC InsOrUpdateItems1 NULL,'Motorola',19,40000,'2019-07-07','2023-04-15';
EXEC InsOrUpdateItems1 NULL,'Oppo A71',12,12000,'2017-05-01','2023-03-11';
EXEC InsOrUpdateItems1 NULL,'VIVO v9',14,75000,'2018-02-15','2023-07-22';
EXEC InsOrUpdateItems1 NULL,'Nokia',13,10000,'2022-10-19','2023-10-19';

SELECT * FROM Items1

GO
CREATE OR ALTER PROCEDURE InsOrUpdatePayment
	@Id INT,
	@Name VARCHAR(200)
AS
BEGIN
	BEGIN TRY
	BEGIN
		IF (@Id IS NULL)
		BEGIN
		INSERT INTO ModOfPayment VALUES(@Name)
		END
	ELSE 
		BEGIN 
		BEGIN TRAN
			UPDATE ModOfPayment SET Name=@Name WHERE Id = @Id;
		COMMIT TRAN
		END 
	END
	END TRY
	BEGIN CATCH
		--ROLLBACK TRAN
	END CATCH
END;
GO

EXEC InsOrUpdatePayment NULL,'UPI';
EXEC InsOrUpdatePayment NULL,'Paytm';
EXEC InsOrUpdatePayment NULL,'PhonePe';
EXEC InsOrUpdatePayment NULL,'GooglePay';
EXEC InsOrUpdatePayment NULL,'BhimUPI';
EXEC InsOrUpdatePayment NULL,'NetBanking';
EXEC InsOrUpdatePayment NULL,'CreditCard';
EXEC InsOrUpdatePayment NULL,'DebitCard';
EXEC InsOrUpdatePayment NULL,'Cash';
EXEC InsOrUpdatePayment NULL,'Cheque';

GO
CREATE OR ALTER PROCEDURE InsOrUpdateorders1
	@Id INT,
	@OrderNo INT,
	@Customer INT,
	@OrderQty INT,
	@Bill_Amt DECIMAL(10,2),
	@DOD DATE,
	@Salesman INT,
	@DAddress VARCHAR(MAX),
	@City VARCHAR(50),
	@ContactNo VARCHAR(50),
	@MOP INT,
	@OrderStatus INT
AS
BEGIN
	BEGIN TRY
	BEGIN
		IF (@Id IS NULL)
		BEGIN
		INSERT INTO Orders1 VALUES(@OrderNo,@Customer,@OrderQty,@Bill_Amt,@DOD,@Salesman,@DAddress,@City,@ContactNo,@MOP,@OrderStatus);
		END
	ELSE 
		BEGIN 
		BEGIN TRAN
			UPDATE Orders1 SET OrderNo=@OrderNo,Customer=@Customer,OrderQty=@OrderQty,Bill_Amt=@Bill_Amt,DOD=@DOD,Salesman=@Salesman,DAddress=@DAddress,City=@City,ContactNo=@ContactNo,MOP=@MOP,OrderStatus=@OrderStatus WHERE Id = @Id;
		COMMIT TRAN
		END 
	END
	END TRY
	BEGIN CATCH
		--ROLLBACK TRAN
	END CATCH
END;
GO

EXEC InsOrUpdateorders1 NULL,1,1,1,20000,'2022-10-11',1,'dsgasdgedrt','Ahemdabad','214324356',2,0;
EXEC InsOrUpdateorders1 NULL,2,4,2,22000,'2022-09-10',2,'dsgasdgedrt','Ahemdabad','3523562435',5,0;
EXEC InsOrUpdateorders1 NULL,3,7,4,40000,'2022-05-04',6,'dsgasdgedrt','Ahemdabad','456245676',4,0;
EXEC InsOrUpdateorders1 NULL,4,2,4,6000,'2022-12-21',1,'dsgasdgedrt','Ahemdabad','87694656',6,0;
EXEC InsOrUpdateorders1 NULL,5,5,2,15000,'2022-03-05',8,'dsgasdgedrt','Ahemdabad','078678345',10,0;
EXEC InsOrUpdateorders1 NULL,6,9,3,33000,'2022-12-5',4,'dsgasdgedrt','Ahemdabad','436456745',9,0;
EXEC InsOrUpdateorders1 NULL,7,10,2,76000,'2022-04-07',3,'dsgasdgedrt','Ahemdabad','879567345',1,0;
EXEC InsOrUpdateorders1 NULL,8,4,1,24000,'2022-01-22',4,'dsgasdgedrt','Ahemdabad','56756767',2,0;
EXEC InsOrUpdateorders1 NULL,9,6,5,40000,'2022-08-25',2,'dsgasdgedrt','Ahemdabad','567688935',3,0;
EXEC InsOrUpdateorders1 NULL,10,9,4,65000,'2022-06-16',9,'dsgasdgedrt','Ahemdabad','4572354354',6,0;

SELECT * FROM Orders1

GO
CREATE OR ALTER PROCEDURE InsOrUpdateOrderDetails
	@Id INT,
	@OrderId INT,
	@ItemId INT,
	@OrderQty INT,
	@Order_Amt DECIMAL(10,2)
AS
BEGIN
	BEGIN TRY
	BEGIN
		IF (@Id IS NULL)
		BEGIN
		INSERT INTO OrderDetails1 VALUES(@OrderId,@ItemId,@OrderQty,@Order_Amt);
		END
	ELSE 
		BEGIN 
		BEGIN TRAN
			UPDATE OrderDetails1 SET OrderId=@OrderId, ItemId=@ItemId, OrderQty=@OrderQty, Order_Amt=@Order_Amt WHERE Id = @Id;
		COMMIT TRAN
		END 
	END
	END TRY
	BEGIN CATCH
		--ROLLBACK TRAN
	END CATCH
END;
GO

EXEC InsOrUpdateOrderDetails NULL,1,1,2,12000;
EXEC InsOrUpdateOrderDetails NULL,2,4,1,10000;
EXEC InsOrUpdateOrderDetails NULL,5,3,4,22000;
EXEC InsOrUpdateOrderDetails NULL,7,2,6,15000;
EXEC InsOrUpdateOrderDetails NULL,3,8,5,9000;
EXEC InsOrUpdateOrderDetails NULL,2,9,3,32000;
EXEC InsOrUpdateOrderDetails NULL,8,10,2,22000;
EXEC InsOrUpdateOrderDetails NULL,9,7,1,11000;
EXEC InsOrUpdateOrderDetails NULL,10,6,3,16000;
EXEC InsOrUpdateOrderDetails NULL,1,5,4,35000;

--3. Create a Parameterized Store Procedure to retrive all the OrderDetails as per Customer (If CustomerId not passed then retrive all the orders) ( Make sure to Add Everything in Single Procedure) [8]
--	Information I want : 
--		--CustomerName
--		--ItemName
--		--Item Rate
--		--Qty
--		--OrderAmount (Qty * ItemRate)
		
--4. Create a User Defined Function that will retrive TotalOrderAmount from the OrderDetails Table as per Customer. [8]
--	I just want total amount as per customerid I Passed.
	
--5. Create a prameterized Store Procedure to retrive all the Order Information as per Customer. (If CustomerId not passed then retrive all the orders) [8]
--	Information I want : 
--		--CustomerName
--		--OrderNo
--		--OrderQty (Total Qty of all the Items) (Using Function)
--		--OrderAmount (Total Amount of Order) (Using Function)
--		--SalesmanName
--		--Address
--		--City
--		--ContactNo
--		--MOP Name
--		--DOD
		
--6. Create a Parameterized Store Procedure to Cancel Order as per OrderNo (If I pass wrong orderno then message should be there) [8]

--7. Create a Parameterized Store Procedure for Login as per Customer/Salesman EmailId and Password.  [10]
--	(If credentials matched then show "Login Successfull" then "Invalid User Input" , If EmailId  is not having in the Table then Create Emaild with Password( Random) ).
	
--8. Create a Parameterized Store Procedure for Delete Customer from the UserName	[5]
--	--All the orders linked to that customer should also be deleted.

--9. Create a OrderDetails using OrderId of Order in a Single Store Procedure. [10]

----10. Every Data suppose to be Dynamic (no any Hard Coded) [Addition 25 points] [ Example : Name would be Dynamic , amount would be Dyanmic , Date Would be Dynamic , OrderNo  would be Dynamic , etc... ]