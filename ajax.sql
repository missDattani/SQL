USE Pooja326MVC

CREATE TABLE [User](
	Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50),
	[Address] VARCHAR(Max),
	Gender VARCHAR(10),
	DOB DATE,
	Role INT,
	MobileNo VARCHAR(20),
	IsDeleted BIT DEFAULT 0,
	Email VARCHAR(100) UNIQUE,
	[Password] VARCHAR(50)
);

INSERT INTO [User](FirstName,LastName,Address,Gender,DOB,Role,MobileNo,Email,Password) VALUES('John','Doe','','Male','',1,'','','')

ALTER TABLE [User]
DROP COLUMN IsDeleted;
ALTER TABLE [User] ADD IsDeleted BIT DEFAULT 0;

ALTER TABLE [User]
DROP CONSTRAINT DF__User__IsDeleted__403A8C7D;

ALTER TABLE [User]
ADD Email VARCHAR(100) UNIQUE;

ALTER TABLE [User]
ADD [Password] VARCHAR(50);

SELECT * FROM [User]

CREATE TABLE Deleted(
 Id INT,
 Col BIT DEFAULT 0
)
INSERT INTO Deleted(Id) VALUES (1)
SELECT * FROM Deleted
DROP TABLE [User]

CREATE TABLE Tbl_Email(
	Id INT PRIMARY KEY IDENTITY(1,1),
	ToEmail VARCHAR(100),
	[Subject] VARCHAR(150),
	[Body] NVARCHAR(Max)
);

SELECT * FROM Tbl_Email
