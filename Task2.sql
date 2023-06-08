USE PD326PoojaDattani;

CREATE TABLE Product(
	ProductId INT PRIMARY KEY IDENTITY(1,1),
	ProductName VARCHAR(250),
	ProductDescription VARCHAR(MAX),
	ProductPrice DECIMAL(10,2),
	ProComapnyId INT,
	ProductDOC DATE,
	ProductDOE DATE,
	ProductReview VARCHAR(250),
	ProductDiscount DECIMAL(10,2),
	ProductQuntity INT,
	OrderId INT,
	CategoryId INT,
	CustomerId INT
);


CREATE TABLE OrderNew(
	OrderId INT PRIMARY KEY IDENTITY(1,1),
	ProductId INT,
	OrderDId INT,
	CustomerId INT
);

CREATE TABLE OrderDetailNew(
	OrderDId INT PRIMARY KEY IDENTITY(1,1),
	OrderedBy VARCHAR(250),
	OrderDate DATE,
	OrderId INT,
	ProductId INT,
	Quntity INT,
	OrderAmount DECIMAL(10,2),
	OrderDOP DATE,
	OrderDOR DATE,
	OrderStatusId INT
);

CREATE TABLE CustomerNew(
	CustomerId INT PRIMARY KEY IDENTITY(1,1),
	CustomerName VARCHAR(250),
	CustomerAddress VARCHAR(MAX),
	CustomerPincode VARCHAR(6),
	CustomerCity VARCHAR(100),
	CustomerContact VARCHAR(50),
	CustomerEmail VARCHAR(100),
	CustomerGender CHAR(10),
	OrderId INT,
	OrderDId INT,
	ProductId INT
);

CREATE TABLE EmployeeNew(
	EmployeeId INT PRIMARY KEY IDENTITY(1,1),
	EmployeeName VARCHAR(250),
	CustomerId INT,
	OrderId INT,
	OrderDId INT,
	ProductId INT
);

CREATE TABLE EmployeeDetailNew(
	EmployeeDId INT PRIMARY KEY IDENTITY(1,1),
	EmployeeName VARCHAR(250),
	EmployeeDOB DATE,
	EmployeeEmail VARCHAR(100),
	EmployeeGender CHAR(10),
	EmployeeDeptId INT,
	EmployeeDesignation VARCHAR(100),
	EmployeeDOJ DATE,
	EmployeeMobileNo VARCHAR(50),
	EmployeeAddress VARCHAR(MAX),
	CompanyId INT
);

ALTER TABLE EmployeeDetailNew
ADD EmployeeSalary DECIMAL(10,2);

ALTER TABLE EmployeeDetailNew
ADD FOREIGN KEY (EmployeeDeptId) REFERENCES DepartmentNew(Did);

CREATE TABLE DepartmentNew(
	Did INT PRIMARY KEY IDENTITY(1,1),
	DName VARCHAR(250)
);