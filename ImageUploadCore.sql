USE Pooja326MVC

CREATE TABLE Employee(
  Id INT PRIMARY KEY IDENTITY(1,1),
  [Name] VARCHAR(250) NOT NULL,
  Email VARCHAR(100) UNIQUE,
  Department VARCHAR(100),
  ProfilePic VARCHAR(250)
);




Go
ALTER PROC Sp_InsertEmployee
@Id INT,
@Name VARCHAR(250),
@Email VARCHAR(100),
@Department VARCHAR(100),
@ProfilePic VARCHAR(250)
AS
BEGIN
	IF(@Id IS NULL AND @Email NOT IN(SELECT Email FROM Employee))
	BEGIN
		INSERT INTO Employee VALUES(@Name,@Email,@Department,@ProfilePic);
	END
	ELSE
	BEGIN
		UPDATE Employee SET [Name]=@Name,Email=@Email,Department=@Department,ProfilePic=@ProfilePic WHERE Id=@Id;
	END
END

GO
ALTER PROC Sp_GetEmpById
@Id INT
AS
BEGIN
	SELECT * FROM Employee WHERE Id = @Id;
END

GO
ALTER PROC Sp_GetAllEmployees
AS
BEGIN
	SELECT * FROM Employee;
END

