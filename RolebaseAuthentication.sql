USE PD326

CREATE TABLE [User](
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(200) NOT NULL,
	Email VARCHAR(100) UNIQUE,
	[Password] VARCHAR(50),
	RoleName VARCHAR(100)
);


Go
CREATE PROC Sp_InsertUser
@Id INT,
@Name VARCHAR(200),
@Email VARCHAR(100),
@Password VARCHAR(50),
@RoleName VARCHAR(100)
AS
BEGIN
	IF(@Id IS NULL AND @Email NOT IN(SELECT Email FROM [User]))
	BEGIN
		INSERT INTO [User] VALUES(@Name,@Email,@Password,@RoleName);
	END
	ELSE
	BEGIN
		UPDATE [User] SET [Name] = @Name,Email=@Email,[Password]=@Password,RoleName=@RoleName WHERE Id = @Id;
	END
END

GO
CREATE PROC Sp_LoginUser
@Email VARCHAR(100),
@Password VARCHAR(50)
AS
BEGIN
	SELECT * FROM [User] WHERE Email=@Email AND [Password] = @Password;
END

Go
CREATE PROC Sp_GetUsersData
As
BEGIN
	SELECT * FROM [User]
END

Go
CREATE PROC Sp_GetCountryData
AS
BEGIN
  SELECT * FROM Country
END