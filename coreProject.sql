CREATE DATABASE CoreProject

USE CoreProject

CREATE TABLE Users(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(255) NOT NULL,
	Email VARCHAR(100) UNIQUE,
	[Password] VARCHAR(50) NOT NULL,
	IsActive BIT DEFAULT 1,
	ISDeleted BIT DEFAULT 0,
	CreatedOn DATE,
	LastChangedPassword VARCHAR(255),
	OTP BIGINT,
	JWTToken NVARCHAR(MAX),
	TokenCreatedOn DATE,
	PasswordChangedOn DATE
);

INSERT INTO Users([Name],Email,[Password]) VALUES('Pooja','pooja@gmail.com','pooja123')

UPDATE Users SET CreatedOn = GETDATE() WHERE Id = 1

CREATE TABLE Company(
	CompanyId INT PRIMARY KEY IDENTITY(1,1),
	CompanyName VARCHAR(255) NOT NULL,
	IsActive BIT DEFAULT 1,
	ISDeleted BIT DEFAULT 0,
	CreatedOn DATE,
);

INSERT INTO Company VALUES('Shaligram',1,0,GETDATE());

CREATE TABLE Department(
	DeptId INT PRIMARY KEY IDENTITY(1,1),
	DeptName VARCHAR(255) NOT NULL,
	CompanyId INT REFERENCES Company(CompanyId),
	IsActive BIT DEFAULT 1,
	ISDeleted BIT DEFAULT 0,
	CreatedOn DATE,
);

INSERT INTO Department VALUES('Buying',1,1,0,GETDATE())

CREATE TABLE Employee(
	EmployeeId INT PRIMARY KEY IDENTITY(1,1),
	EmpURN  AS ('KT'+CONVERT([varchar](16),[EmployeeId])), --Computed Column
	EmployeeName VARCHAR(255) NOT NULL,
	Email VARCHAR(100) UNIQUE NOT NULL,
	[Location] VARCHAR(255) NOT NULL,
	DeptId INT REFERENCES Department(DeptId),
	JobRoleId INT,
	EmployeeCode INT NOT NULL,
	CompanyId INT REFERENCES Company(CompanyId),
	IsActive BIT DEFAULT 1,
	ISDeleted BIT DEFAULT 0,
	CreatedOn DATE,
	UpdatedOn DATE,
);

ALTER TABLE Employee
ADD FOREIGN KEY (JobRoleId) REFERENCES JobRole(JobRoleId);

CREATE TABLE JobRole(
	JobRoleId INT PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(255) NOT NULL,
	DeptId INT REFERENCES Department(DeptId),
	IsActive BIT DEFAULT 1,
	ISDeleted BIT DEFAULT 0,
	CreatedOn DATE,
);

INSERT INTO JobRole VALUES('Buyer',1,1,0,GETDATE())

--User
GO
CREATE PROC Sp_GetLoginData
@Email VARCHAR(100),
@Password VARCHAR(50)
AS
BEGIN
	IF EXISTS (SELECT Id FROM Users WHERE Email = @Email AND [Password] = @Password AND IsActive = 1 AND ISDeleted = 0)
	BEGIN
		SELECT * FROM Users WHERE Email = @Email AND [Password] = @Password;
	END
END

Go
CREATE PROC Sp_AddEditEmployeeData
@EmpId INT,
@EmpName VARCHAR(255),
@Email VARCHAR(100),
@Location VARCHAR(255),
@DeptId INT,
@JobId INT,
@EmpCode INT,
@CompanyId INT
AS
BEGIN
	IF @EmpId = 0
	BEGIN
		IF EXISTS (SELECT EmployeeId FROM Employee WHERE Email = @Email AND IsActive = 1 AND ISDeleted = 0 OR EmployeeCode = @EmpCode)
		BEGIN
			SELECT 2
		END
		ELSE
		BEGIN
			INSERT INTO Employee(EmployeeName,Email,[Location],DeptId,JobRoleId,EmployeeCode,CompanyId,CreatedOn) 
			VALUES(@EmpName,@Email,@Location,@DeptId,@JobId,@EmpCode,@CompanyId,GETDATE());
			SELECT 3
		END
	END
	ELSE
	BEGIN
		UPDATE Employee SET EmployeeName=@EmpName,Email=@Email,[Location]=@Location,DeptId=@DeptId,JobRoleId=@JobId,
		EmployeeCode=@EmpCode,CompanyId=@CompanyId,UpdatedOn=GETDATE() WHERE EmployeeId=@EmpId;
		SELECT 4
	END
END

Go
CREATE PROC Sp_GetCompanyList
AS
BEGIN
	SELECT * FROM Company WHERE IsActive = 1 AND ISDeleted = 0
END

Go
CREATE PROC Sp_GetJobRoleBYDeptId
@DeptId INT
As
BEGIN
	SELECT * FROM JobRole WHERE DeptId = @DeptId AND IsActive = 1 AND ISDeleted = 0;
END

GO
CREATE PROC Sp_GetDepartmentByCompanyId
@CompanyId INT
As
BEGIN
	SELECT * FROM Department WHERE CompanyId=@CompanyId AND IsActive=1 AND ISDeleted=0;
END

SELECT * FROM Employee


GO
CREATE PROC Sp_GetEmployeeList
AS
BEGIN
	SELECT E.EmployeeId,E.EmpURN,E.EmployeeName,E.Email,E.Location,D.DeptName,J.Name,E.EmployeeCode,C.CompanyName
	FROM Employee E INNER JOIN Company C ON E.CompanyId = C.CompanyId
	INNER JOIN Department D ON C.CompanyId = D.CompanyId
	INNER JOIN JobRole J ON D.DeptId = J.DeptId
	WHERE E.IsActive = 1 AND E.ISDeleted = 0
	AND C.IsActive = 1 AND C.ISDeleted = 0
	AND D.IsActive = 1 AND D.ISDeleted = 0
	AND J.IsActive = 1 AND J.ISDeleted = 0
END

Go
CREATE PROC Sp_GetEmployeeById
@EmpId INT
AS
BEGIN
		SELECT E.EmployeeId,E.EmpURN,E.EmployeeName,E.Email,E.Location,D.DeptName,J.Name,E.EmployeeCode,C.CompanyName
	FROM Employee E INNER JOIN Company C ON E.CompanyId = C.CompanyId
	INNER JOIN Department D ON C.CompanyId = D.CompanyId
	INNER JOIN JobRole J ON D.DeptId = J.DeptId
	WHERE E.EmployeeId = @EmpId AND E.IsActive = 1 AND E.ISDeleted = 0 
	AND C.IsActive = 1 AND C.ISDeleted = 0
	AND D.IsActive = 1 AND D.ISDeleted = 0
	AND J.IsActive = 1 AND J.ISDeleted = 0
END

Go
CREATE PROC Sp_DeleteEmployee
@EmpId INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			UPDATE Employee SET IsActive = 0,ISDeleted=1 WHERE EmployeeId=@EmpId
		COMMIT TRAN
	END TRY
	BEGIN CATCH 
		ROLLBACK TRAN
	END CATCH
END

Go
CREATE PROC Sp_GetUserDataByEmail
@Email VARCHAR(100)
AS
BEGIN
	SELECT * FROM Users WHERE Email = @Email
END

Go
CREATE PROC Sp_UpdatePassword
@Email VARCHAR(100),
@NewPassword VARCHAR(50)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM Users WHERE Email = @Email AND IsActive = 1 AND ISDeleted = 0)
			BEGIN
				UPDATE Users SET Password = @NewPassword, PasswordChangedOn = GETDATE()
				WHERE Email = @Email
				SELECT 2
			END
			ELSE
			BEGIN
				SELECT 1
			END
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH
END

Go
CREATE PROC Sp_VerifyOTP
@OTP INT,
@Email VARCHAR(100)
AS
BEGIN
	IF EXISTS (SELECT * FROM Users WHERE Email = @Email AND OTP = @OTP)
	BEGIN
		SELECT 1
	END
	ELSE
	BEGIN
		SELECT 0
	END
END

Go
CREATE PROC Sp_UpdateOTP
@Id INT,
@OTP BIGINT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			UPDATE Users SET OTP = @OTP WHERE Id = @Id;
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH
END

Go
CREATE PROC Sp_UpdateToken
@Id INT,
@Token NVARCHAR(Max)
AS
BEGIN
	DECLARE @success INT
	BEGIN TRY
		BEGIN TRAN
			UPDATE Users SET JWTToken = @Token,TokenCreatedOn = GETDATE() WHERE Id = @Id;
			SET @success = 5
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		SET @success = 4
	END CATCH
	SELECT @success
END

GO
ALTER PROC Sp_ValidateToken
@Id INT,
@Token NVARCHAR(MAX),
@TokenDate DATETIME
As
BEGIN
	IF(SELECT COUNT(Id) FROM Users WHERE Id = @Id AND IsActive = 1) = 1
	BEGIN
		IF((SELECT TokenCreatedOn FROM Users WHERE JWTToken = @Token AND Id = @Id) < @TokenDate )
		BEGIN
			SELECT 1
		END
		ELSE
		BEGIN
			SELECT 0
		END
	END
	ELSE 
	BEGIN
		SELECT 0
	END
END

Go
CREATE PROC Sp_GetEmployeeDataTable
@sortColumn VARCHAR(50),
@sortOrder VARCHAR(50),
@offSetValue INT,
@pageSize INT,
@searchText VARCHAR(50)
AS
BEGIN
	SELECT E.EmployeeId,E.EmpURN,E.EmployeeName,E.Email,E.Location,D.DeptName,E.EmployeeCode,C.CompanyName,J.Name,
	CASE WHEN E.IsActive = 1 THEN 'Active' ELSE 'InActive' END AS 'Status',
	COUNT(E.EmployeeId) OVER() AS FilterTotalCount
	FROM Employee E 
	INNER JOIN Company C ON E.CompanyId = C.CompanyId
	INNER JOIN Department D ON D.DeptId = E.DeptId AND D.CompanyId = C.CompanyId
	INNER JOIN JobRole J ON J.JobRoleId = E.JobRoleId AND J.DeptId = D.DeptId
	WHERE (
	(
		@searchText <> ''
		AND(
			E.EmployeeName LIKE '%' + @searchText + '%'
			OR E.EmpURN LIKE '%' + @searchText + '%'
			OR E.Email LIKE '%' + @searchText + '%'
			OR D.DeptName LIKE '%' + @searchText + '%'
			OR J.Name LIKE '%' + @searchText + '%'
			OR C.CompanyName LIKE '%' + @searchText + '%'
			OR E.EmployeeCode LIKE '%' + @searchText + '%'
			OR E.IsActive LIKE '%' + CASE WHEN @searchText = 'Active' THEN '1' END + '%'
			OR E.IsActive LIKE '%' + CASE WHEN @searchText = 'InActive' THEN '0' END + '%'
		)
	)
	OR(@searchText = '')
	)
	ORDER BY CASE
		WHEN @sortOrder <> 'ASC'
		THEN ''
		WHEN @sortColumn = 'EmployeeName'
		THEN E.EmployeeName
		END ASC,
		CASE
		WHEN @sortOrder <> 'DESC'
		THEN ''
		WHEN @sortColumn = 'EmployeeName'
		THEN E.EmployeeName
		END DESC,
		CASE
		WHEN @sortOrder <> 'ASC'
		THEN ''
		WHEN @sortColumn = 'EmpURN'
		THEN E.EmpURN
		END ASC,
		CASE
		WHEN @sortOrder <> 'DESC'
		THEN ''
		WHEN @sortColumn = 'EmpURN'
		THEN E.EmpURN
		END DESC,
		CASE
		WHEN @sortOrder <> 'ASC'
		THEN ''
		WHEN @sortColumn = 'Email'
		THEN E.Email
		END ASC,
		CASE
		WHEN @sortOrder <> 'DESC'
		THEN ''
		WHEN @sortColumn = 'Email'
		THEN E.Email
		END DESC,
		CASE
		WHEN @sortOrder <> 'ASC'
		THEN ''
		WHEN @sortColumn = 'Location'
		THEN E.Location
		END ASC,
		CASE
		WHEN @sortOrder <> 'DESC'
		THEN ''
		WHEN @sortColumn = 'Location'
		THEN E.Location
		END DESC,
		CASE
		WHEN @sortOrder <> 'ASC'
		THEN ''
		WHEN @sortColumn = 'DeptName'
		THEN D.DeptName
		END ASC,
		CASE
		WHEN @sortOrder <> 'DESC'
		THEN ''
		WHEN @sortColumn = 'DeptName'
		THEN D.DeptName
		END DESC,
		CASE
		WHEN @sortOrder <> 'ASC'
		THEN ''
		WHEN @sortColumn = 'Name'
		THEN J.Name
		END ASC,
		CASE
		WHEN @sortOrder <> 'DESC'
		THEN ''
		WHEN @sortColumn = 'Name'
		THEN J.Name
		END DESC,
		CASE
		WHEN @sortOrder <> 'ASC'
		THEN ''
		WHEN @sortColumn = 'EmployeeCode'
		THEN E.EmployeeCode
		END ASC,
		CASE
		WHEN @sortOrder <> 'DESC'
		THEN ''
		WHEN @sortColumn = 'EmployeeCode'
		THEN E.EmployeeCode
		END DESC,
		CASE
		WHEN @sortOrder <> 'ASC'
		THEN ''
		WHEN @sortColumn = 'CompanyName'
		THEN C.CompanyName
		END ASC,
		CASE
		WHEN @sortOrder <> 'DESC'
		THEN ''
		WHEN @sortColumn = 'CompanyName'
		THEN C.CompanyName
		END DESC OFFSET @offSetValue ROWS
		FETCH NEXT @PageSize ROWS ONLY
END


