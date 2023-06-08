USE Pooja_SchoolMgmt_326

SELECT * FROM Student
SELECT * FROM Teachers
SELECT * FROM Country
SELECT * FROM States
SELECT * FROM City
SELECT * FROM Users
SELECT * FROM Subjects

EXEC sp_rename 'Student.CoId', 'CountryId', 'COLUMN';
EXEC sp_rename 'Student.StId', 'StateId', 'COLUMN';
EXEC sp_rename 'Student.CiId', 'CityId', 'COLUMN';


INSERT INTO Student VALUES('John','Doe','fdgdfgfg','5673675356','John@gmail.com','Male',4,1,1,2);
INSERT INTO Teachers VALUES('Jetsan','Lama','jfjhdfh','5673675356','Jetsan@gmail.com','Female',1,1,1,2);
INSERT INTO Country VALUES('India');
INSERT INTO States VALUES('Gujarat',1);
INSERT INTO City VALUES('Ahemdabad',1,1);
INSERT INTO Subjects VALUES('Maths');

ALTER TABLE Teachers
ADD FOREIGN KEY (CountryId) REFERENCES Country(CoId) 

ALTER TABLE Teachers
ADD FOREIGN KEY (StateId) REFERENCES States(StId) 

ALTER TABLE Teachers
ADD FOREIGN KEY (CityId) REFERENCES City(CiId) 

DELETE FROM Teachers
DELETE FROM Student

ALTER TABLE Teachers
DROP COLUMN PassWord

ALTER TABLE Teachers
DROP COLUMN SubjectId

ALTER TABLE Student
DROP CONSTRAINT FK__Student__Teacher__2E1BDC42 

ALTER TABLE Student
ALTER COLUMN TeacherId VARCHAR(50)

ALTER TABLE Teachers
ALTER COLUMN SubjectId VARCHAR(50)

select * from Teachers
DELETE FROM Teachers

GO
CREATE OR ALTER PROC sp_AddEditCountry
@CountryId INT,
@CountryName VARCHAR(250)
AS
BEGIN
	IF(@CountryId IS NOT NULL)
	BEGIN
		UPDATE Country SET CountryName = @CountryName WHERE CoId = @CountryId;
		RETURN 1;
	END
	ELSE
	BEGIN
	 INSERT INTO Country VALUES(@CountryName);
	 RETURN 0;
	END
END

GO
CREATE OR ALTER PROC sp_AddEditState
@StateId INT,
@StateName VARCHAR(250),
@CountryId INT
AS
BEGIN
	IF(@StateId IS NOT NULL)
	BEGIN
		UPDATE States SET StateName = @StateName, CoId = @CountryId WHERE StId = @StateId;
		RETURN 1;
	END
	ELSE
	BEGIN
	 INSERT INTO States VALUES(@StateName,@CountryId);
	 RETURN 0;
	END
END

GO
CREATE OR ALTER PROC sp_AddEditCities
@CityId INT,
@CityName VARCHAR(250),
@StateId INT,
@CountryId INT
AS
BEGIN
	IF(@CityId IS NOT NULL)
	BEGIN
		UPDATE City SET CityName = @CityName,CoId = @CountryId,StId = @StateId  WHERE CiId = @CityId;
		RETURN 1;
	END
	ELSE
	BEGIN
	 INSERT INTO City VALUES(@CityName,@CountryId,@StateId);
	 RETURN 0;
	END
END

GO
CREATE OR ALTER PROC sp_AddEditSubject
@SubId INT,
@SubjectName VARCHAR(250)
AS
BEGIN
	IF(@SubId IS NOT NULL)
	BEGIN
		UPDATE Subjects SET SubjectName = @SubjectName WHERE SubId = @SubId;
		RETURN 1;
	END
	ELSE
	BEGIN
	 INSERT INTO Subjects VALUES(@SubjectName);
	 RETURN 0;
	END
END


GO
CREATE OR ALTER PROC sp_AddEditStudent
@StdId INT,
@FirstName VARCHAR(100),
@LastName VARCHAR(100),
@Address VARCHAR(MAX),
@Mobile VARCHAR(50),
@Email VARCHAR(100),
@Gender VARCHAR(10),
@TeacherId INT,
@CountryId INT,
@StateId INT,
@CityId INT
AS
BEGIN
	IF(@StdId IS NOT NULL)
	BEGIN
		UPDATE Student SET FirstName = @FirstName,LastName = @LastName,Address = @Address,Mobile = @Mobile,Email = @Email,Gender = @Gender,TeacherId = @TeacherId,CountryId = @CountryId,StateId = @StateId,CityId = @CityId  WHERE SId = @StdId;
		RETURN 1;
	END
	ELSE
	BEGIN
	 INSERT INTO Student VALUES(@FirstName,@LastName,@Address,@Mobile,@Email,@Gender,@TeacherId,@CountryId,@StateId,@CityId);
	 RETURN 0;
	END
END

select * from City
select * from Country

GO
CREATE OR ALTER function Multi_Subject(@teacherId INT)
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
SELECT dbo.Multi_Subject(5)

GO
CREATE OR ALTER proc SP_GetTeacherDetails
AS
BEGIN
     SELECT t.TecID, t.FirstName,t.LastName as 'Full Name', t.Email,t.Mobile,t.Gender, LEFT(dbo.Multi_Subject(t.TecId),LEN(dbo.Multi_Subject(t.TecId))-1) as 'Subjects', 
     t.Address+' '+c1.CityName+', '+s1.StateName+', '+c2.CountryName as 'Address'  FROM Teachers t
     inner join Country c2 on t.CountryId = c2.CoId
     inner join States s1 on t.StateId = s1.StId
     inner join City c1 on T.CityId = c1.CiId
END
EXEC SP_GetTeacherDetails

GO
CREATE OR ALTER function Multi_Teachers(@studentId INT)
RETURNS VARCHAR(100)
as
BEGIN
        DECLARE @ANY VARCHAR(255)
        SET @ANY = '';
        SELECT 
        @ANY = @ANY  + (select t.FirstName,t.LastName from Teachers t where t.TecId=value) + ','
        FROM 
           Student s 
           left join Teachers t on CAST(t.TecId as varchar(20))=   s.TeacherId
           CROSS APPLY STRING_SPLIT(s.TeacherId, ',') WHERE s.SId=@studentId;
           RETURN @ANY
END
SELECT dbo.Multi_Teachers(1) AS "Teachers"

GO
CREATE OR ALTER proc SP_GetStudentDetails
AS
BEGIN
     SELECT s.SID, s.FirstName,s.LastName as 'Full Name', s.Email,s.Mobile,s.Gender, LEFT(dbo.Multi_Teachers(s.SId),LEN(dbo.Multi_Teachers(s.SId))-1) as 'Teachers', 
     s.Address+' '+c1.CityName+', '+s1.StateName+', '+c2.CountryName as 'Address'  FROM Student s
     inner join Country c2 on s.CountryId = c2.CoId
     inner join States s1 on s.StateId = s1.StId
     inner join City c1 on s.CityId = c1.CiId
END
EXEC SP_GetStudentDetails