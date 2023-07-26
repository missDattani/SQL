USE Pooja_SchoolMgmt_326

--User
GO
ALTER PROC [dbo].[Sp_UserLogin](
	@UserEmail VARCHAR(200),
	@Password VARCHAR(200)
)
AS
BEGIN
 SELECT * FROM Users U WHERE U.Email = @UserEmail AND U.Password = @Password 
END

Go
ALTER PROC [dbo].[Sp_UserDetailsByEmail]
@Email VARCHAR(20)
AS
BEGIN
	SELECT * FROM Users U WHERE U.Email =  @Email
END

Go
ALTER   PROC [dbo].[Sp_UserData](
@FirstName VARCHAR(100),
@LastName VARCHAR(100),
@Email VARCHAR(100) ,
@Password VARCHAR(20) 
)
AS
BEGIN
	IF NOT EXISTS (SELECT Email FROM Users WHERE Email = @Email)
	BEGIN
		INSERT INTO Users(FirstName,LastName,Email,[Password]) VALUES (@FirstName,@LastName,@Email,@Password)
	END
END

Go
ALTER PROC [dbo].[Sp_CheckUser]
@UserName VARCHAR(20)
AS
BEGIN 
	SELECT * FROM Users U WHERE U.FirstName = @UserName OR U.Email = @UserName 
END

SELECT * FROM Users

EXEC [dbo].[Sp_UserDetailsByEmail] 'pooja@gmail.com'
--User

--Country
Go
CREATE PROC [dbo].[Sp_GetAllCountries]
AS
BEGIN
	SELECT * FROM Country
END

Go
CREATE PROC [dbo].[Sp_AddEdit_Country](@ID INT,@CountryName VARCHAR(200))
AS
BEGIN

	IF(@ID IS Null AND @CountryName NOT IN(SELECT CountryName FROM Country))
	BEGIN
		INSERT INTO Country VALUES (@CountryName)
	END
	ELSE
	BEGIN
		UPDATE Country SET CountryName = @CountryName WHERE CoId = @ID
	END
END

GO
CREATE PROC [dbo].[Sp_GetCountryById](@ID INT)
AS
BEGIN
SELECT * FROM Country C WHERE C.CoId = @ID
END

GO
CREATE PROC [dbo].[Sp_Delete_Country](@ID INT)
AS
BEGIN
	IF ( @ID IN (SELECT CoId FROM States))
	BEGIN
		  SELECT 0		
	END
	ELSE
	BEGIN
	DELETE FROM Country  WHERE CoId = @ID
	 	
	END
END

--Country

--State
Go
CREATE PROC [dbo].[Sp_GetAllStates]
AS
BEGIN
	SELECT S.StId,S.StateName,C.CountryName,S.CoId FROM States S INNER JOIN Country C ON S.CoId = C.CoId
END

GO
CREATE PROC [dbo].[Sp_GetStateById](@ID INT)
AS
BEGIN
SELECT * FROM States S INNER JOIN Country C ON C.CoId = S.CoId WHERE S.StId = @ID
END

GO
CREATE PROC [dbo].[Sp_AddEdit_State](@ID INT,@StateName VARCHAR(200),@CountryID INT)
AS
BEGIN

	IF(@ID IS NULL AND @StateName NOT IN(SELECT StateName FROM States))
	BEGIN
		INSERT INTO States VALUES (@StateName,@CountryID)
	END
	ELSE
	BEGIN
		UPDATE 
		States SET StateName = @StateName,CoId = @CountryID WHERE StId = @ID
	END
END

GO
CREATE PROC [dbo].[Sp_Delete_State](@ID INT)
AS
BEGIN
IF(@ID IN(SELECT StId FROM City))
	BEGIN
		return 0
	END
	ELSE
	BEGIN
	DELETE FROM States  WHERE StId = @ID
		
	END		
END

GO
CREATE PROC [dbo].[Sp_GetStateByCountryID](@ID INT)
AS
BEGIN
	SELECT S.*, C.CountryName FROM States S INNER JOIN Country C ON C.CoId = S.CoId WHERE C.CoId = @ID
END
--State

--City
Go
CREATE PROC [dbo].[Sp_GetAllCity]
AS
BEGIN
	SELECT C.CiId, C.CityName,S.StateName,CO.CountryName FROM City C 
	INNER JOIN States S ON C.StId = S.StId INNER JOIN Country CO ON CO.CoId = C.CoId
END

GO
ALTER PROC [dbo].[Sp_GetCityById](@Id INT)
AS
BEGIN
select * from City where CiId = @Id;
END


Go
CREATE OR ALTER PROC [dbo].[Sp_AddEdit_City](@Id INT,@CityName VARCHAR(200),@StId INT,@CoId INT)
AS
BEGIN

	IF(@Id IS NULL AND @CityName NOT IN(SELECT CityName FROM City))
	BEGIN
		INSERT INTO City VALUES (@CityName, @CoId,@StId)
	END
	ELSE
	BEGIN
		UPDATE City SET CityName = @CityName,CoId = @CoId,StId = @StId WHERE CiId = @Id
	END
END

SELECT * FROM Users
DELETE FROM Users WHERE Id = 1
--City

Go
CREATE OR ALTER PROC Sp_GetCountryDataTable
@sortColumn VARCHAR(50),
@sortOrder VARCHAR(50),
@offSetVal INT,
@pageSize INT,
@searchText VARCHAR(50)
AS
BEGIN
	SELECT CoId,CountryName,count(CoId) OVER () as 'FilterTotalCount' FROM Country
	WHERE ((@searchText <> ''
	AND (CountryName LIKE '%' + @searchText + '%'
	))
	OR (@searchText = '')
	)
	ORDER BY CASE 
		WHEN @sortOrder <> 'ASC'
			THEN ''
		WHEN @sortColumn = 'CountryName'
			THEN CountryName
		END ASC,
	CASE
		WHEN @sortOrder <> 'DESC'
			THEN ''
		WHEN @sortColumn = 'CountryName'
			THEN CountryName
		END DESC OFFSET @offSetVal ROWS

	FETCH NEXT @pageSize ROWS ONLY
END