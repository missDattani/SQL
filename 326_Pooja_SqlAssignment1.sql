--create database
CREATE DATABASE PD326PoojaDattani;

--use database
USE PD326PoojaDattani;

--create employeetable
CREATE TABLE PDEmployeeDetail(
	PDEmployeeId INT PRIMARY KEY IDENTITY(1,1),
	PDEmployeeFirstName VARCHAR(250),
	PDEmployeeLastName VARCHAR(250),
	PDEmployeeDOB DATETIME,
	PDEmployeeEmail VARCHAR(250),
	PDEmployeeGender CHAR(10),
	PDEmployeeDepartmentId INT,
	PDEmployeeCode BIGINT,
	PDEmployeeDesignation VARCHAR(100),
	PDEmployeeDOJ DATE,
	PDEmployeeSalary DECIMAL,
	PDEmployeeCountryCode VARCHAR(10),
	PDEmployeeMobileNumber1 VARCHAR(50),
	PDEmployeeMobileNumber2 VARCHAR(50),
	PDEmployeeCurrentAddress NVARCHAR(MAX),
	PDEmployeePermanentAddress NVARCHAR(MAX),
	PDEmployeePinCode VARCHAR(6),
	PDEmployeeCityId VARCHAR(100),
	PDEmployeeStateId VARCHAR(100),
	PDEmployeeCountryId VARCHAR(100),
);

--add column into employeetable
ALTER TABLE PDEmployeeDetail
ADD PDEmployeeResume TEXT;

--change datatype of column
ALTER TABLE PDEmployeeDetail
ALTER COLUMN PDEmployeeCityId INT;

--change datatype of column
ALTER TABLE PDEmployeeDetail
ALTER COLUMN PDEmployeeStateId INT;

--change datatype of column
ALTER TABLE PDEmployeeDetail
ALTER COLUMN PDEmployeeCountryId INT;

--Not null constraint
ALTER TABLE PDEmployeeDetail
ALTER COLUMN PDEmployeeFirstName VARCHAR(250) NOT NULL;

--Unique constraint
ALTER TABLE PDEmployeeDetail
ADD UNIQUE (PDEmployeeEmail);

--add new column
ALTER TABLE PDEmployeeDetail
ADD PDEmployeeProfilePic IMAGE;

--drop altered column
ALTER TABLE PDEmployeeDetail
DROP COLUMN PDEmployeeProfilePic;

--add new column
ALTER TABLE PDEmployeeDetail
ADD PDEmployeeIsActiveId BIT;

--Rename column
EXEC sp_RENAME 'PDEmployeeDetail.PDEmployeeIsActiveId', 'PDEmployeeIsActivated', 'COLUMN';

--Default constraint
ALTER TABLE PDEmployeeDetail
ADD CONSTRAINT df_CountryCode DEFAULT '+91' FOR PDEmployeeCountryCode;

--Default constraint
ALTER TABLE PDEmployeeDetail
ADD CONSTRAINT df_CountryId DEFAULT 1 FOR PDEmployeeCountryId;

--Check constraint
ALTER TABLE PDEmployeeDetail
ADD CHECK (PDEmployeeSalary > 0);

--Default columns
ALTER TABLE PDEmployeeDetail
ADD PDCreatedOn DATETIME NOT NULL DEFAULT GETDATE();

--Default columns
ALTER TABLE PDEmployeeDetail
ADD PDCreatedBy VARCHAR(100) NOT NULL DEFAULT SYSTEM_USER;

--Insert data into Employee table
INSERT INTO PDEmployeeDetail(
	PDEmployeeFirstName,
	PDEmployeeLastName,
	PDEmployeeDOB,
	PDEmployeeEmail,
	PDEmployeeGender,
	PDEmployeeDepartmentId,
	PDEmployeeCode,
	PDEmployeeDesignation,
	PDEmployeeDOJ,
	PDEmployeeSalary,
	PDEmployeeMobileNumber1,
	PDEmployeeCurrentAddress,
	PDEmployeePinCode,
	PDEmployeeCityId,
	PDEmployeeStateId,
	PDEmployeeIsActivated
) VALUES

( 'ABC','VLH','1998-08-20','ABC.V@shaligraminfotech.com','Female',2,220,'Web Developer','2017-01-01',30000,'9633645675','2,hsgK,dfaaa','360350',9,2,1 ),

( 'DEF','TUV','1997-05-20','DEF.T@shaligraminfotech.com','Female',2,220,'Web Developer','2017-01-01',30000,'9633645675','20,hsgK,dfaaa','360350',10,2,1 ),

( 'GHI','WFG','1999-06-16','GHI.W@shaligraminfotech.com','Male',3,190,'Web Developer','2019-01-01',15000,'9263623411','11,hdKdsf,GssdEY','300350',10,2,0 ),

( 'JKL','YGH','1999-07-22','JKL.Y@shaligraminfotech.com','Female',1,343,'Web Developer','2020-01-01',25000,'9262341445','1,hdKdsf,GssdEY','300150',10,2,1 ),

( 'MNO','HJF','1996-12-21','MNO.H@shaligraminfotech.com','Male',5,456,'BDE','2015-01-01',10000,'9211432768','20,hdKdghsf,dfssdEY','312350',6,1,1 );

INSERT INTO PDEmployeeDetail(
	PDEmployeeFirstName,
	PDEmployeeLastName,
	PDEmployeeDOB,
	PDEmployeeEmail,
	PDEmployeeGender,
	PDEmployeeDepartmentId,
	PDEmployeeCode,
	PDEmployeeDesignation,
	PDEmployeeDOJ,
	PDEmployeeSalary,
	PDEmployeeMobileNumber1,
	PDEmployeeCurrentAddress,
	PDEmployeePinCode,
	PDEmployeeCityId,
	PDEmployeeStateId,
	PDEmployeeIsActivated
) VALUES
( 'PQR','SKN','2002-05-14','PQR.S@shaligraminfotech.com','Female',1,222,'Web Developer','2023-01-01',3000,'9654356478','hsgK,dfaaa','360011',8,3,1 ),

( 'STU','KFN','2000-07-19','STU.K@shaligraminfotech.com','Male',5,190,'BDE','2020-01-01',8000,'9263674373','GssdEY','360001',5,1,0 ),

( 'VWX','OGK','1997-11-22','VWX.O@shaligraminfotech.com','Male',2,343,'Web Developer','2017-01-01',25000,'9264567321','GssdEY,dftgea','300021',3,2,0 ),

( 'YZF','JHL','1998-04-03','YZF.J@shaligraminfotech.com','Female',4,346,'Designer','2016-01-01',35000,'9299438768','hdK,ddEY','350036',2,2,1 ),

( 'JRE','GDU','2002-02-05','JRE.G@shaligraminfotech.com','Female',1,433,'Web Developer','2022-01-01',5000,'9863492888','hdKfsew,ddEYsfs','350011',1,3,1 );

INSERT INTO PDEmployeeDetail(
	PDEmployeeFirstName,
	PDEmployeeLastName,
	PDEmployeeDOB,
	PDEmployeeEmail,
	PDEmployeeGender,
	PDEmployeeDepartmentId,
	PDEmployeeCode,
	PDEmployeeDesignation,
	PDEmployeeDOJ,
	PDEmployeeSalary,
	PDEmployeeMobileNumber1,
	PDEmployeeCurrentAddress,
	PDEmployeePinCode,
	PDEmployeeCityId,
	PDEmployeeStateId,
	PDEmployeeIsActivated
) VALUES
( 'FSU','FGY','2001-05-14','USF.F@shaligraminfotech.com','Female',3,168,'Web Developer','2023-01-01',7000,'9654356478','hsgK,dfaaa','360011',4,3,1 ),

( 'GGY','FSY','1998-07-19','GGY.F@shaligraminfotech.com','Male',5,390,'BDE','2020-01-01',30000,'9263674373','GssdEY','360001',5,2,0 ),

( 'GHU','KSJ','1996-11-22','GHU.K@shaligraminfotech.com','Female',1,643,'Web Developer','2017-01-01',25000,'9264567321','GssdEY,dftgea','300021',7,3,1 ),

( 'KLN','YUB','2000-04-03','KLN.Y@shaligraminfotech.com','Female',3,226,'Web Developer','2022-01-01',5000,'9299438768','hdK,ddEY','350036',6,2,1 ),

( 'NXK','ADJ','1999-02-05','NXK.A@shaligraminfotech.com','Male',4,156,'Designer','2022-01-01',33000,'9863492888','hdKfsew,ddEYsfs','350011',4,3,0 );


--default constraint
ALTER TABLE PDEmployeeDetail
ADD CONSTRAINT df_IsActive DEFAULT 1 FOR PDEmployeeIsActivated;

--Foreign key in departmentid
ALTER TABLE PDEmployeeDetail
ADD CONSTRAINT fk_DepartmentId  FOREIGN KEY (PDEmployeeDepartmentId) REFERENCES Department(DepartmentId);

--Transaction started
BEGIN TRAN

UPDATE PDEmployeeDetail SET PDEmployeeCityId = 7 WHERE PDEmployeeId = 2;

UPDATE PDEmployeeDetail SET PDEmployeeCityId = 9 WHERE PDEmployeeId = 3;

COMMIT TRAN
ROLLBACK TRAN

--Retrive record from employee table
SELECT * FROM PDEmployeeDetail;

--Department table
CREATE TABLE Department(
	DepartmentId INT PRIMARY KEY IDENTITY(1,1),
	DepartmentName VARCHAR(100) NOT NULL
);


--Insert records into department table
INSERT INTO Department VALUES('Dot Net');
INSERT INTO Department VALUES('Angular JS');
INSERT INTO Department VALUES('Node JS');
INSERT INTO Department VALUES('Designing');
INSERT INTO Department VALUES('BDE');

--Retrive data from department table 
SELECT * FROM Department;

--CityId of Employee table references citydetail table
ALTER TABLE PDEmployeeDetail
ADD CONSTRAINT FK_cityId  FOREIGN KEY (PDEmployeeCityId) REFERENCES CityDetail(CityId);

--Create Citydetail table
CREATE TABLE CityDetail(
	CityId INT PRIMARY KEY IDENTITY(1,1),
	CityName VARCHAR(100),
	StateId INT NOT NULL,
	CountryId INT NOT NULL
);


--Insert record into citydetail table
INSERT INTO CityDetail VALUES('Ahemdabad',1,1);
INSERT INTO CityDetail VALUES('Rajkot',1,1);
INSERT INTO CityDetail VALUES('Jamnagar',1,1);
INSERT INTO CityDetail VALUES('Surat',1,1);
INSERT INTO CityDetail VALUES('Baroda',1,1);
INSERT INTO CityDetail VALUES('Mumbai',2,1);
INSERT INTO CityDetail VALUES('Jaipur',3,1);
INSERT INTO CityDetail VALUES('Udaipur',3,1);
INSERT INTO CityDetail VALUES('Jabalpur',2,1);
INSERT INTO CityDetail VALUES('Sihora',2,1);


--retrive data from citydetail
SELECT * FROM CityDetail;

--StateId of Employee table references statedetail table
ALTER TABLE PDEmployeeDetail
ADD CONSTRAINT FK_StateId  FOREIGN KEY (PDEmployeeStateId) REFERENCES StateDetail(StateId);

--create table statedetail
CREATE TABLE StateDetail(
	StateId INT PRIMARY KEY IDENTITY(1,1),
	StateName VARCHAR(100),
	CountryId INT NOT NULL
);

--Insert data into statedetail
INSERT INTO StateDetail VALUES('Gujarat',1);
INSERT INTO StateDetail VALUES('Maharashtra',1);
INSERT INTO StateDetail VALUES('Rajasthan',1);

--Retrive data from statedetail
SELECT * FROM StateDetail;

--CountryId of Employee table references countrydetail table
ALTER TABLE PDEmployeeDetail
ADD CONSTRAINT FK_CountryId  FOREIGN KEY (PDEmployeeCountryId) REFERENCES CountryDetail(CountryId);

--create table countrydetail
CREATE TABLE CountryDetail(
	CountryId INT PRIMARY KEY IDENTITY(1,1),
	CountryName VARCHAR(100)
);

--Insert record into countrydetail
INSERT INTO CountryDetail VALUES('India');
INSERT INTO CountryDetail VALUES('US');

--Retrive data from countrydetail
SELECT * FROM CountryDetail;

--For delete records from employee table
DELETE FROM PDEmployeeDetail;

--drop employee table
DROP TABLE PDEmployeeDetail;

--Max function
SELECT MAX(PDEmployeeSalary) FROM PDEmployeeDetail;

--Min function
SELECT MIN(PDEmployeeSalary) FROM PDEmployeeDetail;

--Count function
SELECT COUNT(PDEmployeeId),PDEmployeeStateId FROM PDEmployeeDetail GROUP BY PDEmployeeStateId;
SELECT COUNT(StateId) FROM StateDetail;

--Sum function
SELECT SUM(PDEmployeeSalary) FROM PDEmployeeDetail WHERE PDEmployeeId BETWEEN 22 AND 26;

--Modified On
ALTER TABLE PDEmployeeDetail
ADD PDModifiedOn DATETIME DEFAULT GETDATE();

--Modify by
ALTER TABLE PDEmployeeDetail
ADD PDModifiedBy VARCHAR(100) DEFAULT SYSTEM_USER;

CREATE TRIGGER update_PDEmployee
ON PDEmployeeDetail
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	UPDATE PDEmployeeDetail
	SET PDModifiedOn = GETDATE(),
		PDModifiedBy = SYSTEM_USER
	WHERE PDEmployeeId IN (SELECT PDEmployeeId FROM PDEmployeeDetail)
END;

