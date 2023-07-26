USE Pooja326MVC;

CREATE TABLE Country(
	CountryId INT PRIMARY KEY IDENTITY(1,1),
	CountryName VARCHAR(100) UNIQUE
);

CREATE TABLE States(
	StateId INT PRIMARY KEY IDENTITY(1,1),
	StateName VARCHAR(100) UNIQUE,
	CountryId INT
	FOREIGN KEY (CountryId) REFERENCES Country(CountryId)
);

CREATE TABLE City(
  CityId INT PRIMARY KEY IDENTITY(1,1),
  CityName VARCHAR(100) UNIQUE,
  StateId INT,
  CountryId INT
  FOREIGN KEY (StateId) REFERENCES States(StateId),
  FOREIGN KEY (CountryId) REFERENCES Country(CountryId)
);

ALTER TABLE [User]
ADD CountryId INT REFERENCES Country(CountryId)

ALTER TABLE [User]
ADD StateId INT REFERENCES States(StateId)

ALTER TABLE [User]
ADD CityId INT REFERENCES City(CityId)


Go
CREATE PROC Sp_UserLogin(
	@Email VARCHAR(100),
	@Password VARCHAR(50)
)
AS
BEGIN
	SELECT * FROM [User] U WHERE U.Email = @Email AND U.Password = @Password;
END

CREATE TABLE [User](
	Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100),
	[Address] VARCHAR(MAX),
	Gender VARCHAR(10),
	DOB DATE,
	[Role] INT,
	MobileNo VARCHAR(20),
	Email VARCHAR(100),
	[Password] VARCHAR(50),
	CountryId INT REFERENCES Country(CountryId),
	StateId INT REFERENCES States(StateId),
	CityId INT REFERENCES City(CityId)
);

INSERT INTO [User] VALUES('pooja','dattani','Okha','Female','2001-07-19',1,'8347493020','pooja@gmail.com','pooja123',1,1,1);
INSERT INTO Country VALUES('India');
INSERT INTO States VALUES('Gujarat',1);
INSERT INTO City VALUES('Okha',1,1);


Go
CREATE PROC Sp_AddEditCountry(
	@CoId INT,
	@CoName VARCHAR(100)
)
AS
BEGIN
	IF(@CoId IS NULL AND @CoName NOT IN(SELECT CountryName FROM Country))
	BEGIN
		INSERT INTO Country VALUES(@CoName);
	END
	ELSE
	BEGIN
		UPDATE Country SET CountryName = @CoName WHERE CountryId = @CoId;
	END
END

GO
CREATE PROC Sp_AddEditStates(
	@StId INT,
	@StName VARCHAR(100),
	@CoId INT 
)
AS 
BEGIN
	IF(@StId IS NULL AND @StName NOT IN(SELECT StateName FROM States))
	BEGIN
		INSERT INTO States VALUES(@StName,@CoId);
	END
	ELSE
	BEGIN
		UPDATE States SET StateName = @StName, CountryId=@CoId WHERE StateId=@StId;
	END
END

GO
CREATE OR ALTER PROC Sp_AddEditCity(
	@CiId INT,
	@CiName VARCHAR(100),
	@StId INT,
	@CoId INT
)
AS
BEGIN
	IF(@CiId IS NULL AND @CiName NOT IN(SELECT CityName FROM City))
	BEGIN
		INSERT INTO City VALUES(@CiName,@StId,@CoId);
	END
	ELSE
	BEGIN
		UPDATE City SET CityName = @CiName, StateId=@StId,CountryId=@CoId WHERE CityId=@CiId;
	END
END

exec Sp_AddEditCity 1,'Porbandar',1,1

Go
CREATE PROC Sp_GetCountryById(
	@CoId INT
)
AS
BEGIN
	SELECT * FROM Country WHERE CountryId = @CoId;
END


Go
CREATE PROC Sp_GetStateById(
	@StId INT
)
AS
BEGIN
	SELECT * FROM States S INNER JOIN Country C ON S.CountryId = C.CountryId WHERE S.StateId = @StId;
END

Go
CREATE PROC Sp_GetCityById(
	@CiId INT
)
AS
BEGIN
	SELECT * FROM City C INNER JOIN States S ON C.StateId = S.StateId INNER JOIN Country CO ON S.CountryId = CO.CountryId WHERE CityId = @CiId;
END

exec Sp_GetCityById 1

Go
CREATE PROC Sp_GetCountries
AS
BEGIN
	SELECT * FROM Country
END

GO
CREATE PROC Sp_GetStates
AS
BEGIN
	SELECT * FROM States S INNER JOIN Country C ON S.CountryId = C.CountryId
END

Go
CREATE PROC Sp_GetCities
AS
BEGIN
	SELECT * FROM City C INNER JOIN States S ON C.StateId = S.StateId INNER JOIN Country CO ON S.CountryId =CO.CountryId;
END

Go
ALTER PROC Sp_GetStateByCountryId(
	@CoId INT 
)
AS
BEGIN
	SELECT * FROM States S INNER JOIN Country C ON S.CountryId = C.CountryId WHERE S.CountryId =@CoId;
END

GO
CREATE PROC Sp_RegisterUser(
	@Id INT,
	@FName VARCHAR(100),
	@LName VARCHAR(100),
	@Address VARCHAR(MAX),
	@Gender VARCHAR(10),
	@DOB DATE,
	@Role INT,
	@Mobile VARCHAR(20),
	@Email VARCHAR(100),
	@Password VARCHAR(50),
	@CoId INT,
	@StId INT,
	@CiId INT
)
AS
BEGIN
	IF(@Id IS NULL AND @Email NOT IN(SELECT Email FROM [User]))
	BEGIN
		INSERT INTO [User] VALUES(@FName,@LName,@Address,@Gender,@DOB,@Role,@Mobile,@Email,@Password,@CoId,@StId,@CiId);
	END
	ELSE
	BEGIN
		UPDATE [User] SET FirstName = @FName,LastName=@LName,[Address]=@Address,Gender=@Gender,DOB=@DOB,[Role]=@Role,MobileNo=@Mobile,Email=@Email,[Password]=@Password,CountryId=@CoId,StateId=@StId,CityId=@CiId WHERE Id=@Id;
	END
END

Go
CREATE PROC Sp_GetCityByStateId(
	@StId INT 
)
AS
BEGIN
	SELECT * FROM City C INNER JOIN States S ON C.StateId = S.StateId INNER JOIN Country Co ON S.CountryId = Co.CountryId WHERE C.StateId =@StId;
END

Go
CREATE PROC Sp_GetUserById
@Id INT
AS
BEGIN
	SELECT * FROM [User]  u INNER JOIN Country co ON u.CountryId = co.CountryId 
	INNER JOIN States s ON co.CountryId = s.CountryId 
	INNER JOIN City c ON s.StateId = c.StateId WHERE Id = @Id; 
END

Go
ALTER PROC Sp_GetUsers
As
BEGIN
	SELECT u.*,co.CountryName,s.StateName,c.CityName 
	FROM [User]  u INNER JOIN Country co ON u.CountryId = co.CountryId 
	INNER JOIN States s ON s.StateId=u.StateId
	INNER JOIN City c ON c.CityId = u.CityId
END


Go
CREATE PROC Sp_Country_Pagination
@PageNumber INT,
@PageSize INT
As
BEGIN
	DECLARE @Pagenum INT,@Pagelength INT
	IF(@PageNumber = 0)
	BEGIN
		SET @Pagenum = 1
	END
	ELSE
	BEGIN
		SET @Pagenum = @PageNumber
	END

	IF(@PageSize = 0)
	BEGIN
		SET @Pagelength = 3
	END
	ELSE
	BEGIN
		SET @Pagelength = @PageSize
	END

	SELECT * FROM Country 
	ORDER BY CountryId
	OFFSET @Pagelength * (@Pagenum - 1) ROWS
	FETCH NEXT @Pagelength ROWS ONLY
END

Go
CREATE PROC Sp_GetCountryCount
AS
BEGIN
	SELECT COUNT(CountryId) AS CountryCount FROM Country 
END
