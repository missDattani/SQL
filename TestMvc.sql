CREATE DATABASE OrderManagement

USE OrderManagement

CREATE TABLE [User](
	Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(100),
	LastName VARCHAR(100),
	Email VARCHAR(100) UNIQUE,
	Password VARCHAR(50)
);

INSERT INTO [User] VALUES('John','Doe','John@gmail.com','John123');
INSERT INTO [User] VALUES('Emily','Doe','Emily@gmail.com','Emily123');
INSERT INTO [User] VALUES('Jack','Lama','Jack@gmail.com','Jack123');


CREATE TABLE Items(
	ItemId INT PRIMARY KEY IDENTITY(1,1),
	ItemName VARCHAR(100),
	Price DECIMAL(10,2)
);

INSERT INTO Items VALUES('Pizza',100);
INSERT INTO Items VALUES('Vada Pav',50);
INSERT INTO Items VALUES('Burger',150);
SELECT * FROM Items;

CREATE TABLE Orders(
	OrderId INT PRIMARY KEY IDENTITY(1,1),
	UserId INT,
	CouponId INT,
	OrderDate DATE,
	OrderTotalQty INT,
	OrderAmount DECIMAL(10,2),
	AfterGST DECIMAL(10,2),
	TotalPayable DECIMAL(10,2)
);

ALTER TABLE Orders
ADD ItemId INT

ALTER TABLE Orders
ADD FOREIGN KEY (ItemId) REFERENCES Items(ItemId)

ALTER TABLE Orders
ADD FOREIGN KEY (UserId) REFERENCES [User](Id)

ALTER TABLE Orders
ADD FOREIGN KEY (CouponId) REFERENCES CouponCodeMaster(CouponICoded)

ALTER TABLE Orders
ADD SGST INT

ALTER TABLE Orders
ADD CGST INT

ALTER TABLE Orders
ALTER COLUMN SGST DECIMAL(10,2)

ALTER TABLE Orders
ALTER COLUMN CGST DECIMAL(10,2)

SELECT * FROM Orders

INSERT INTO Orders(UserId,CouponId,OrderDate,OrderTotalQty,OrderAmount,SGST,CGST) VALUES(1,1,'2023-05-30',2,200,0.05,0.05);
INSERT INTO Orders(UserId,CouponId,OrderDate,OrderTotalQty,OrderAmount,SGST,CGST) VALUES(1,2,'2023-05-29',2,200,0.05,0.05);
INSERT INTO Orders(UserId,CouponId,OrderDate,OrderTotalQty,OrderAmount,SGST,CGST) VALUES(2,3,'2023-05-30',3,450,0.05,0.05);
INSERT INTO Orders(UserId,CouponId,OrderDate,OrderTotalQty,OrderAmount,SGST,CGST) VALUES(2,1,'2023-05-29',2,100,0.05,0.05);



CREATE TABLE CouponCodeMaster(
	CouponICoded INT PRIMARY KEY IDENTITY(1,1),
	CouponCode VARCHAR(100),
	CouponType INT,
	FlatAmount INT,
	Percentage INT,
	ExpiryDate DATE,
	UsageLimit INT,
	IsActive BIT
);

SELECT * FROM CouponCodeMaster

INSERT INTO CouponCodeMaster VALUES('Flat100',1,100,'','2023-05-22',2,0);
INSERT INTO CouponCodeMaster VALUES('100OFF',2,100,'','2023-05-30',1,1);
INSERT INTO CouponCodeMaster VALUES('Flat50',1,50,'','2023-05-31',2,1);


go
create or alter procedure SP_GetOrderDetails
@UserId INT
as
begin
	select O.OrderDate,O.OrderTotalQty,O.OrderAmount,O.AfterGST,ISNULL(C.CouponCode,'No Coupon Applied') AS PromoCode,O.TotalPayable,O.CGST,O.SGST from Orders O
	left join CouponCodeMaster C on (ISNULL(O.CouponId,''))=C.CouponICoded WHERE O.UserId = @UserId
end

EXEC SP_GetOrderDetails 3

SELECT * FROM [User]
