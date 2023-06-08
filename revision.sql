USE OrderManagement

CREATE TABLE Users(
	Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Email VARCHAR(100) UNIQUE,
	PassWord VARCHAR(50),
	[Role] INT
);

DROP TABLE Users

INSERT INTO Users VALUES('John','Doe','John@gmail.com','John@123',1);

SELECT * FROM Users



CREATE TABLE Country(
	CountryId INT PRIMARY KEY IDENTITY(1,1),
	CountryName VARCHAR(100)
);

CREATE TABLE States(
	StateId INT PRIMARY KEY IDENTITY(1,1),
	StateName VARCHAR(100),
	CountryId INT
);

ALTER TABLE States
ADD FOREIGN KEY (CountryId) REFERENCES Country(CountryId)

CREATE TABLE City(
	CityId INT PRIMARY KEY IDENTITY(1,1),
	CityName VARCHAR(100),
	StateId INT,
	CountryId INT
);

ALTER TABLE City
ADD FOREIGN KEY (CountryId) REFERENCES Country(CountryId)

ALTER TABLE City
ADD FOREIGN KEY (StateId) REFERENCES States(StateId)

GO;
CREATE PROCEDURE Sp_GetCountries
AS
BEGIN
	SELECT * FROM Country;
END

EXEC Sp_GetCountries

INSERT INTO Country VALUES('India')
INSERT INTO States VALUES('Gujarat',1);
INSERT INTO City VALUES('Ahemdabad',1,1);

CREATE TABLE Subjects(
	SubId INT PRIMARY KEY IDENTITY(1,1),
	SubjectName VARCHAR(100)
);

ALTER TABLE Subjects
ADD UNIQUE(SubjectName);

INSERT INTO Subjects VALUES('Maths');
SELECT * FROM Subjects

CREATE TABLE Teachers(
	TecId INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(100),
	LastName VARCHAR(100),
	Gender VARCHAR(10),
	[Address] VARCHAR(MAX),
	MobileNo VARCHAR(20),
	Email VARCHAR(100),
	SubjectId VARCHAR(100),
	CountryId INT,
	StateId INT,
	CityId INT
);

SELECT * FROM Teachers
SELECT * FROM Subjects


ALTER TABLE Teachers
ADD FOREIGN KEY (CountryId) REFERENCES Country(CountryId)

ALTER TABLE Teachers
ADD FOREIGN KEY (StateId) REFERENCES States(StateId)

ALTER TABLE Teachers
ADD FOREIGN KEY (CityId) REFERENCES City(CityId)

ALTER TABLE Teachers
ALTER COLUMN Gender INT

INSERT INTO Teachers VALUES('Sonali','Kar',2,'','9386452728','Sonali@gmail.com','',1,1,1);


GO;
ALTER function Multi_Subject(@teacherId INT)
RETURNS VARCHAR(100)
as
BEGIN
        DECLARE @ANY VARCHAR(255)
        SET @ANY = '';
        SELECT 
        @ANY = @ANY  + (select s1.SubjectName from Subjects s1 where s1.SubId=value) + ','
        FROM 
           Teachers t1 
           left join Subjects s1 on CAST(s1.SubId as varchar(20))=   t1.SubjectId
           CROSS APPLY STRING_SPLIT(t1.SubjectId, ',') WHERE t1.TecId=@teacherId;
           RETURN @ANY
END
GO;
SELECT dbo.Multi_Subject(2)

GO
CREATE OR ALTER proc SP_GetTeacherDetails
AS
BEGIN
     SELECT t.TecID, t.FirstName,t.LastName, t.Email,t.MobileNo,t.Gender, LEFT(dbo.Multi_Subject(t.TecId),LEN(dbo.Multi_Subject(t.TecId))-1) as 'Subjects', 
     t.Address+' '+c1.CityName+', '+s1.StateName+', '+c2.CountryName as 'Address'  FROM Teachers t
     inner join Country c2 on t.CountryId = c2.CountryId
     inner join States s1 on t.StateId = s1.StateId
     inner join City c1 on T.CityId = c1.CityId
END
EXEC SP_GetTeacherDetails

CREATE TABLE Student(
	StuId INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(100),
	LastName VARCHAR(100),
	Gender VARCHAR(10),
	[Address] VARCHAR(MAX),
	MobileNo VARCHAR(20),
	Email VARCHAR(100),
	SubjectId VARCHAR(100),
	CountryId INT,
	StateId INT,
	CityId INT
);

ALTER TABLE Student
ADD FOREIGN KEY (CountryId) REFERENCES Country(CountryId)

ALTER TABLE Student
ADD FOREIGN KEY (StateId) REFERENCES States(StateId)

ALTER TABLE Student
ADD FOREIGN KEY (CityId) REFERENCES City(CityId)

