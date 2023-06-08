USE PD326PoojaDattani;


--Random Integers
DECLARE @Random INT;
DECLARE @Upper INT;
DECLARE @LOWER INT;

SET @Lower = 1;
SET @Upper = 999;
SELECT @Random = ROUND(((@Upper - @Lower - 1) * RAND() + @Lower), 0);
SELECT @Random;


--Decimal Value
DECLARE @DecimalVal DECIMAL(10,2);

SELECT @DecimalVal = ROUND(RAND(CHECKSUM(NEWID())) * (500), 2);
SELECT @DecimalVal;


--Random strings
GO
CREATE OR ALTER PROCEDURE sp_getName(@output VARCHAR(36) OUT)
AS
BEGIN
DECLARE @chars VARCHAR(36);
DECLARE @n INT;
SET @chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
SET @n = 5;
SET @output = SUBSTRING(@chars, CAST((RAND() * LEN(@chars)) AS INT) + 1, @n)

END

EXEC sp_getName;

--Random Address
GO
CREATE OR ALTER PROCEDURE sp_getAddress(@outputAdd VARCHAR(36) OUT)
AS
BEGIN
DECLARE @chars VARCHAR(36);
DECLARE @n INT;
SET @chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
SET @n = 10;
SET @outputAdd = SUBSTRING(@chars, CAST((RAND() * LEN(@chars)) AS INT) + 1, @n)
END

--Random Dates
GO
CREATE OR ALTER PROCEDURE sp_getRandomDate
AS
BEGIN
DECLARE @StartDate AS date;
DECLARE @EndDate AS date;
DECLARE @RandomDate AS DATE;

SELECT @StartDate = '01/01/2019', -- Date Format - DD/MM/YYY
       @EndDate   = '12/31/2021';
SELECT @RandomDate = DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, @StartDate, @EndDate)),@StartDate);
SELECT @RandomDate;
END

--Random Mobileno
GO
CREATE OR ALTER PROCEDURE sp_getMobileNo(@outputmo VARCHAR(36) OUT)
AS
BEGIN
DECLARE @chars VARCHAR(36);
DECLARE @n INT;
SET @chars = '0123456789';
SET @n = 10;
SET @outputmo = SUBSTRING(@chars, CAST((RAND() * LEN(@chars)) AS INT) + 1, @n)
END

EXEC sp_getMobileNo

--Random Pincode
GO
CREATE OR ALTER PROCEDURE sp_getPin(@outputpin VARCHAR(36) OUT)
AS
BEGIN
DECLARE @chars VARCHAR(36);
DECLARE @n INT;
SET @chars = '0123456789';
SET @n = 6;
SET @outputpin = SUBSTRING(@chars, CAST((RAND() * LEN(@chars)) AS INT) + 1, @n)
END





SELECT ROUND(RAND(CHECKSUM(NEWID())) * (100),2);
SELECT FLOOR(RAND()*(1000-5+1)+5);
SELECT DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, '1996-01-01', '2019-12-31')),'1996-01-01')
SELECT CASE WHEN ABS(CHECKSUM(NEWID())) %2 = 0 THEN 'F' ELSE 'M' END;



GO
CREATE OR ALTER PROCEDURE sp_InsEmpNew
AS
BEGIN
DECLARE
@CustomerId INT,
@OrderId INT,
@OrderDId INT,
@ProductId INT
DECLARE @Count INT;
DECLARE @result VARCHAR(36);
SET @Count = 0;
WHILE(@Count < 500)
	BEGIN
	EXEC sp_getName @result OUT;
	SET @CustomerId = (SELECT FLOOR(RAND()*(500-5+1)+5));
	SET @OrderId = (SELECT FLOOR(RAND()*(500-5+1)+5));
	SET @OrderDId = (SELECT FLOOR(RAND()*(500-5+1)+5));
	SET @ProductId = (SELECT FLOOR(RAND()*(500-5+1)+5));

		INSERT INTO EmployeeNew VALUES(@result,@CustomerId,@OrderId,@OrderDId,@ProductId);
		SET @Count = @Count + 1;
		END
END

EXEC sp_InsEmpNew;

SELECT * FROM EmployeeNew;


GO 
CREATE OR ALTER PROCEDURE sp_InsEmpDetail
AS
BEGIN
DECLARE	@EmployeeDOB DATE,
	@EmployeeGender CHAR(10),
	@EmployeeDeptId INT,
	@EmployeeDOJ DATE,
	@CompanyId INT,
	@EmployeeSalary DECIMAL(10,2);
DECLARE @result VARCHAR(36);
DECLARE @outputmo VARCHAR(36);
DECLARE @outputAdd VARCHAR(36);
DECLARE @Count INT;
SET @Count = 0;
WHILE(@Count < 500)
	BEGIN
	EXEC sp_getName @result OUT;
	SET @EmployeeDOB = (SELECT DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, '1996-01-01', '2019-12-31')),'1996-01-01'));
	SET @EmployeeGender = (SELECT CASE WHEN ABS(CHECKSUM(NEWID())) %2 = 0 THEN 'Female' ELSE 'Male' END); 
	SET @EmployeeDeptId = (SELECT FLOOR(RAND()*(500-5+1)+5));
	SET @EmployeeDOJ = (SELECT DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, '2017-01-01', '2019-12-31')),'2017-01-01'));
	EXEC sp_getMobileNo @outputmo OUT;
	EXEC sp_getAddress @outputAdd OUT;
	SET @CompanyId = (SELECT FLOOR(RAND()*(500-5+1)+5));
	SET @EmployeeSalary = (SELECT ROUND(RAND(CHECKSUM(NEWID())) * (5000), 2));

		INSERT INTO EmployeeDetailNew VALUES(@result,@EmployeeDOB,@result,@EmployeeGender,@EmployeeDeptId,@result,@EmployeeDOJ,@outputmo,@outputAdd,@CompanyId,@EmployeeSalary);
		SET @Count = @Count + 1;
		END
END

EXEC sp_InsEmpDetail;

SELECT * FROM EmployeeDetailNew;
DROP TABLE EmployeeDetailNew;

GO
CREATE OR ALTER PROCEDURE sp_InsOrder
AS
BEGIN
DECLARE	@ProductId INT,
	@OrderDId INT,
	@CustomerId INT
DECLARE @Count INT;
SET @Count = 0;
WHILE(@Count < 500)
BEGIN
	SET @ProductId = (SELECT FLOOR(RAND()*(500-5+1)+5));
	SET @OrderDId = (SELECT FLOOR(RAND()*(500-5+1)+5));
	SET @CustomerId = (SELECT FLOOR(RAND()*(500-5+1)+5));

	INSERT INTO OrderNew VALUES(@ProductId,@OrderDId,@CustomerId);
		SET @Count = @Count + 1;
END
END

EXEC sp_InsOrder;

SELECT * FROM OrderNew;



GO
CREATE OR ALTER PROCEDURE sp_InsOrderDetail
AS
BEGIN
DECLARE @result VARCHAR(36);
DECLARE	
	@OrderDate DATE,
	@OrderId INT,
	@ProductId INT,
	@Quntity INT,
	@OrderAmount DECIMAL(10,2),
	@OrderDOP DATE,
	@OrderDOR DATE,
	@OrderStatusId INT
DECLARE @Count INT;
SET @Count = 0;
WHILE(@Count < 500)
BEGIN
		EXEC sp_getName @result OUT;
		SET @OrderDate = (SELECT DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, '2021-01-01', '2022-12-31')),'2021-01-01'));
		SET @OrderId = (SELECT FLOOR(RAND()*(500-5+1)+5));
		SET @ProductId = (SELECT FLOOR(RAND()*(500-5+1)+5));
		SET @Quntity = (SELECT FLOOR(RAND()*(100-5+1)+5));
		SET @OrderAmount = (SELECT ROUND(RAND(CHECKSUM(NEWID())) * (500), 2));
		SET @OrderDOP = (SELECT DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, '2021-01-01', '2022-12-31')),'2021-01-01'));
		SET @OrderDOR = (SELECT DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, '2021-01-01', '2022-12-31')),'2021-01-01'));
		SET @OrderStatusId = (SELECT FLOOR(RAND()*(500-5+1)+5));

	INSERT INTO OrderDetailNew VALUES(@result,@OrderDate,@OrderId,@ProductId,@Quntity,@OrderAmount,@OrderDOP,@OrderDOR,@OrderStatusId);
		SET @Count = @Count + 1;
END
END

EXEC sp_InsOrderDetail;

SELECT * FROM OrderDetailNew;



GO
CREATE OR ALTER PROCEDURE sp_InsCustomer
AS
BEGIN
DECLARE @result VARCHAR(36);
DECLARE @outputpin VARCHAR(6);
DECLARE @outputAdd VARCHAR(36);
DECLARE @outputmo VARCHAR(36);
DECLARE @CustomerPincode VARCHAR(6),
		@CustomerCity VARCHAR(100),
		@CustomerGender CHAR(10),
		@OrderId INT,
		@OrderDId INT,
		@ProductId INT
DECLARE @Count INT;
SET @Count = 0;
WHILE(@Count < 500)
BEGIN
	EXEC sp_getName @result OUT;
	EXEC sp_getAddress @outputAdd OUT;
	EXEC sp_getMobileNo @outputmo OUT;
	EXEC sp_getPin @outputpin OUT;
	SET @CustomerGender = (SELECT CASE WHEN ABS(CHECKSUM(NEWID())) %2 = 0 THEN 'Female' ELSE 'Male' END);
	SET @OrderId = (SELECT FLOOR(RAND()*(500-5+1)+5));
	SET @OrderDId = (SELECT FLOOR(RAND()*(500-5+1)+5));
	SET @ProductId = (SELECT FLOOR(RAND()*(500-5+1)+5));

	INSERT INTO CustomerNew VALUES(@result,@outputAdd,@outputpin,@result,@outputmo,@result,@CustomerGender,@OrderId,@OrderDId,@ProductId);
		SET @Count = @Count + 1;
		END
END

EXEC sp_InsCustomer;

SELECT * FROM CustomerNew;


GO
CREATE OR ALTER PROCEDURE sp_InsProduct
AS
BEGIN
DECLARE @result VARCHAR(36);
DECLARE @outputAdd VARCHAR(36),
		@ProductPrice DECIMAL(10,2),
		@ProComapnyId INT,
		@ProductDOC DATE,
		@ProductDOE DATE,
		@ProductDiscount DECIMAL(10,2),
		@ProductQuntity INT,
		@OrderId INT,
		@CategoryId INT,
		@CustomerId INT;
DECLARE @Count INT;
SET @Count = 0;
WHILE(@Count < 500)
BEGIN
			EXEC sp_getName @result OUT;
			EXEC sp_getAddress @outputAdd OUT;
			SET @ProductPrice = (SELECT ROUND(RAND(CHECKSUM(NEWID())) * (500), 2));
			SET @ProComapnyId = (SELECT FLOOR(RAND()*(500-5+1)+5));
			SET @ProductDOC = (SELECT DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, '2021-01-01', '2022-12-31')),'2021-01-01'));
			SET @ProductDOE = (SELECT DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, '2021-01-01', '2022-12-31')),'2021-01-01'));
			SET @ProductDiscount = (SELECT RAND(2));
			SET @ProductQuntity = (SELECT FLOOR(RAND()*(100-5+1)+5));
			SET @OrderId = (SELECT FLOOR(RAND()*(500-5+1)+5));
			SET @CategoryId = (SELECT FLOOR(RAND()*(500-5+1)+5));
			SET @CustomerId = (SELECT FLOOR(RAND()*(500-5+1)+5));

		INSERT INTO Product VALUES(@result,@outputAdd,@ProductPrice,@ProComapnyId,@ProductDOC,@ProductDOE,@result,@ProductDiscount,@ProductQuntity,@OrderId,@CategoryId,@CustomerId);
			SET @Count = @Count + 1;
END
END

EXEC sp_InsProduct;

SELECT * FROM Product;

DROP TABLE Product;

GO
CREATE OR ALTER PROCEDURE sp_InsDept
AS
BEGIN
DECLARE @result VARCHAR(36);
DECLARE @Count INT;
SET @Count = 0;
WHILE(@Count < 500)
BEGIN
	EXEC sp_getName @result OUT;

	INSERT INTO DepartmentNew VALUES(@result);
	SET @Count = @Count + 1;
END
END

EXEC sp_InsDept;

SELECT * FROM DepartmentNew;
