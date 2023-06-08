USE PD326PoojaDattani;

------

CREATE FUNCTION getCustomerDetail()
RETURNS TABLE
AS
	RETURN (SELECT * FROM customer_detail);
---
SELECT * FROM getCustomerDetail();

SELECT * FROM emp_details;
SELECT * FROM order_detail;

-------

CREATE FUNCTION getEmpFullname
(
	@Fname VARCHAR(100),
	@Lname VARCHAR(100)
)
RETURNS VARCHAR(200)
AS
BEGIN
	RETURN (SELECT @Fname + ' ' + @Lname);
END

SELECT dbo.getEmpFullname(EMP_FNAME,EMP_LNAME) AS "Fullname" FROM emp_details;

--------

CREATE OR ALTER FUNCTION getMulOrder()
RETURNS @order TABLE
(
	ord_no INT,
	purchase DECIMAL(10,2),
	ord_date DATE
)
AS
BEGIN
	INSERT INTO @order SELECT o.ord_no,o.purch_amt,o.ord_date FROM order_detail o;

	UPDATE @order SET purchase = 1111.20 WHERE ord_no = 70001;

	DELETE FROM @order WHERE ord_no > 70009;

	RETURN

END

SELECT * FROM getMulOrder();

-------

CREATE FUNCTION checkNum(@num INT)
RETURNS VARCHAR(50)
AS
BEGIN
		DECLARE @msg VARCHAR(50);

	IF (@num % 2 = 0)

		SET @msg = 'Number is Even';
	ELSE
		SET @msg = 'Number is Odd';

	RETURN @msg
END

SELECT dbo.checkNum(21) AS "Check no.";

-------

CREATE OR ALTER FUNCTION getFormattedDate( @DateVal DATETIME)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN DATENAME(DW, @DateVal) + ', ' +
			DATENAME(DAY, @DateVal) + ', ' +
			DATENAME(MONTH, @DateVal) + ', ' +
			DATENAME(YEAR, @DateVal) + ', ' 
END

SELECT dbo.getFormattedDate(PDEmployeeDOB) FROM PDEmployeeDetail;

SELECT * FROM PDEmployeeDetail;

------


CREATE OR ALTER PROCEDURE getCity 
@City VARCHAR(50)
AS
BEGIN
	SELECT * FROM customer_detail WHERE city = @City;
END

EXEC getCity 'New York';


------


CREATE OR ALTER PROCEDURE getCityPattern
@City VARCHAR(50)
AS
BEGIN
	SELECT * FROM customer_detail WHERE city  LIKE '%' + @City + '%' ;
END

EXEC getCityPattern 'I';

