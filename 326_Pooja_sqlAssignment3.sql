
USE PD326PoojaDattani;

CREATE TABLE employees(
	employee_id INT PRIMARY KEY IDENTITY(101,1),
	employee_name TEXT,
	department TEXT,
	salary NUMERIC(10,2),
	hire_date DATE
);

INSERT INTO employees VALUES('ABC','Sales',20000,'2022-06-16');
INSERT INTO employees VALUES('BBS','HR',30000,'2022-07-22');
INSERT INTO employees VALUES('CHJ','Web Designing',45000,'2022-09-19');
INSERT INTO employees VALUES('STB','Web Development',55000,'2022-07-19');
INSERT INTO employees VALUES('QNY','Sales',35000,'2022-01-31');
INSERT INTO employees VALUES('KLS','HR',60000,'2022-12-21');
INSERT INTO employees VALUES('ANF','Web Designing',57000,'2023-01-16');
INSERT INTO employees VALUES('KKE','QA',28000,'2022-02-23');
INSERT INTO employees VALUES('DHS','Web Development',48000,'2023-03-23');
INSERT INTO employees VALUES('NDH','QA',38000,'2022-04-15');
INSERT INTO employees VALUES('JDH','Sales',40000,'2022-05-17');
INSERT INTO employees VALUES('UWG','HR',30000,'2022-06-12');
INSERT INTO employees VALUES('JWY','Web Designing',42000,'2022-03-20');
INSERT INTO employees VALUES('WHK','QA',30000,'2022-10-11');
INSERT INTO employees VALUES('VBS','Web Development',40000,'2022-08-30');
INSERT INTO employees VALUES('ASG','HR',48000,'2022-07-29');
INSERT INTO employees VALUES('SHV','Sales',39000,'2023-04-15');
INSERT INTO employees VALUES('WYH','Web Designing',35000,'2023-04-18');
INSERT INTO employees VALUES('HWN','QA',28000,'2022-02-28');
INSERT INTO employees VALUES('HNX','Web Development',38000,'2022-05-22');
INSERT INTO employees VALUES('WHM','HR',30000,'2022-01-10');
INSERT INTO employees VALUES('SBN','Web Designing',48000,'2022-10-07');
INSERT INTO employees VALUES('SBN','HR',55000,'2023-03-16');
INSERT INTO employees VALUES('WBH','Web Development',58000,'2022-06-06');
INSERT INTO employees VALUES('HSN','QA',38000,'2022-09-29');
INSERT INTO employees VALUES('PBD','Sales',25000,'2022-01-04');



	--How many employees are in the table?

SELECT COUNT(employee_id) AS num_of_emps FROM employees;

	--What is the highest salary in the table?

SELECT MAX(salary) AS highest_salary FROM employees;

	--What is the average salary by department?

SELECT AVG(salary) AS average_salary, CONVERT(VARCHAR,department) AS department FROM employees
GROUP BY CONVERT(VARCHAR, department);

	--Who are the top 5 highest paid employees?

SELECT TOP 5 salary, employee_name
FROM employees
ORDER BY salary DESC;

	--How many employees were hired in the last year?

SELECT *FROM employees
WHERE hire_date >= DATEADD(YEAR, -1, GETDATE());

	--How do you select all columns from a table named "employees"?

SELECT * FROM employees;

	--How do you select only the "employee_id" and "employee_name" columns from a table named "employees"?

SELECT employee_id, employee_name FROM employees;

	--How do you filter records in a table named "employees" to only include those where the "salary" column is greater than or equal to 50000?

SELECT * FROM employees WHERE salary >= 50000;

	--How do you filter records in a table named "employees" to only include those where the "department" column is "Sales"?

SELECT * FROM employees WHERE department LIKE 'Sales';

	--How do you filter records in a table named "employees" to only include those where the "hire_date" column is between January 1, 2022 and December 31, 2022?

SELECT * FROM employees WHERE hire_date BETWEEN '2022-01-01' AND '2022-12-31';

	--How do you calculate the average salary of all employees in a table named "employees"?

SELECT AVG(salary) FROM employees;

	--How do you calculate the total salary of all employees in a table named "employees"?

SELECT SUM(salary) AS total_salary FROM employees;

	--How do you calculate the highest salary in a table named "employees"?

SELECT MAX(salary) AS highest_salary FROM employees;


	--How do you calculate the lowest salary in a table named "employees"?

SELECT MIN(salary) AS lowest_salary FROM employees;


	--How do you calculate the number of employees in a table named "employees"?

SELECT COUNT(employee_id) FROM employees;

	--How do you sort the records in a table named "employees" by the "salary" column in ascending order?

SELECT * FROM employees
ORDER BY salary ASC;

	--How do you sort the records in a table named "employees" by the "salary" column in descending order?

SELECT * FROM employees
ORDER BY salary DESC;

	--How do you count the number of employees in each department in a table named "employees"?

SELECT COUNT(employee_id) AS num_of_emps, CONVERT(VARCHAR,department) AS department FROM employees
GROUP BY CONVERT(VARCHAR, department);

	--How do you select the first 10 records in a table named "employees"?

SELECT TOP 10 * FROM employees;

	--How do you select the last 10 records in a table named "employees"?

SELECT TOP 10 * FROM employees order by employee_id DESC;

	--How do you select the top 5 highest paid employees from a table named "employees"?

SELECT TOP 5 salary, employee_name
FROM employees
ORDER BY salary DESC;

	--How do you select the top 10 highest paid employees from a table named "employees"?

SELECT TOP 10 salary, employee_name
FROM employees
ORDER BY salary DESC;

	--How do you select the bottom 5 lowest paid employees from a table named "employees"?

SELECT TOP 5 salary, employee_name
FROM employees
ORDER BY salary;

	--How do you select the employees who have a salary that is above the average salary in a table named "employees"?

SELECT * FROM employees WHERE salary > ALL (SELECT AVG(salary) FROM employees);

	--How do you select the employees who have a salary that is below the average salary in a table named "employees"?

SELECT * FROM employees WHERE salary < ALL (SELECT AVG(salary) FROM employees);

	--How do you select the employees who have a salary that is between 40000 and 60000 in a table named "employees"?

SELECT * FROM employees WHERE salary BETWEEN 40000 AND 60000;

	--How do you calculate the total salary of all employees in each department in a table named "employees"?

SELECT SUM(salary) AS total_salary, CONVERT(VARCHAR,department) AS department FROM employees
GROUP BY CONVERT(VARCHAR, department);

	--How do you calculate the average salary of all employees in each department in a table named "employees"?

SELECT AVG(salary) AS average_slary, CONVERT(VARCHAR,department) AS department FROM employees
GROUP BY CONVERT(VARCHAR, department);

	--How do you calculate the highest salary of all employees in each department in a table named "employees"?

SELECT MAX(salary) AS highest_salary, CONVERT(VARCHAR,department) AS department FROM employees
GROUP BY CONVERT(VARCHAR, department);

	--How do you calculate the lowest salary of all employees in each department in a table named "employees"?

SELECT MIN(salary) AS highest_salary, CONVERT(VARCHAR,department) AS department FROM employees
GROUP BY CONVERT(VARCHAR, department);

	--How do you select the employees who have been hired in the last year from a table named "employees"?

SELECT *FROM employees
WHERE hire_date >= DATEADD(YEAR, -1, GETDATE());

	--How do you select the employees who have been hired in the last 6 months from a table named "employees"?

SELECT *FROM employees
WHERE hire_date >= DATEADD(MONTH, -6, GETDATE());

	--How do you select the employees who have been hired in the last 3 months from a table named "employees"?

SELECT *FROM employees
WHERE hire_date >= DATEADD(MONTH, -3, GETDATE());

	--How do you select the employees who have been hired in the last week from a table named "employees"?

SELECT *FROM employees
WHERE hire_date >= DATEADD(WEEK, -1, GETDATE());

	--How do you select the employees who have a name that starts with the letter "A" in a table named "employees"?

SELECT * FROM employees WHERE employee_name LIKE 'A%';

	--How do you select the employees who have a name that ends with the letter "s" in a table named "employees"?

SELECT * FROM employees WHERE employee_name LIKE '%s';

DROP TABLE employees;



	--How many employees are in the table?

SELECT COUNT(employee_id) AS num_of_emps FROM employees;

	--What is the highest salary in the table?

SELECT MAX(salary) AS highest_salary FROM employees;

	--What is the average salary by department?

SELECT AVG(salary) AS average_salary, CONVERT(VARCHAR,department) AS department FROM employees
GROUP BY CONVERT(VARCHAR, department);

	--Who are the top 5 highest paid employees?

SELECT TOP 5 salary, employee_name
FROM employees
ORDER BY salary DESC;

	--How many employees were hired in the last year?

SELECT * FROM employees
WHERE hire_date >= DATEADD(YEAR, -1, GETDATE());

	--How do you select all columns from a table named "employees"?

SELECT * FROM employees;

	--How do you select only the "employee_id" and "employee_name" columns from a table named "employees"?

SELECT employee_id, employee_name FROM employees;

	--How do you filter records in a table named "employees" to only include those where the "salary" column is greater than or equal to 50000?

SELECT * FROM employees WHERE salary >= 50000;

	--How do you filter records in a table named "employees" to only include those where the "department" column is "Sales"?

SELECT * FROM employees WHERE department LIKE 'Sales';

	--How do you filter records in a table named "employees" to only include those where the "hire_date" column is between January 1, 2022 and December 31, 2022?

SELECT * FROM employees WHERE hire_date BETWEEN '2022-01-01' AND '2022-12-31';

	--How do you calculate the average salary of all employees in a table named "employees"?

SELECT AVG(salary) FROM employees;

	--How do you calculate the total salary of all employees in a table named "employees"?

SELECT SUM(salary) AS total_salary FROM employees;

	--How do you calculate the highest salary in a table named "employees"?

SELECT MAX(salary) AS highest_salary FROM employees;


	--How do you calculate the lowest salary in a table named "employees"?

SELECT MIN(salary) AS lowest_salary FROM employees;


	--How do you calculate the number of employees in a table named "employees"?

SELECT COUNT(employee_id) FROM employees;

	--How do you sort the records in a table named "employees" by the "salary" column in ascending order?

SELECT * FROM employees
ORDER BY salary ASC;

	--How do you sort the records in a table named "employees" by the "salary" column in descending order?

SELECT * FROM employees
ORDER BY salary DESC;

	--How do you count the number of employees in each department in a table named "employees"?

SELECT COUNT(employee_id) AS num_of_emps, CONVERT(VARCHAR,department) AS department FROM employees
GROUP BY CONVERT(VARCHAR, department);

	--How do you select the first 10 records in a table named "employees"?

SELECT TOP 10 * FROM employees;

	--How do you select the last 10 records in a table named "employees"?

SELECT TOP 10 * FROM employees order by employee_id DESC;

	--How do you select the top 5 highest paid employees from a table named "employees"?

SELECT TOP 5 salary, employee_name
FROM employees
ORDER BY salary DESC;

	--How do you select the top 10 highest paid employees from a table named "employees"?

SELECT TOP 10 salary, employee_name
FROM employees
ORDER BY salary DESC;

	--How do you select the bottom 5 lowest paid employees from a table named "employees"?

SELECT TOP 5 salary, employee_name
FROM employees
ORDER BY salary;

	--How do you select the employees who have a salary that is above the average salary in a table named "employees"?

SELECT * FROM employees WHERE salary > ALL (SELECT AVG(salary) FROM employees)
ORDER BY employee_id;

	--How do you select the employees who have a salary that is below the average salary in a table named "employees"?

SELECT * FROM employees WHERE salary < ALL (SELECT AVG(salary) FROM employees)
ORDER BY employee_id;

	--How do you select the employees who have a salary that is between 40000 and 60000 in a table named "employees"?

SELECT * FROM employees WHERE salary BETWEEN 40000 AND 60000;

	--How do you calculate the total salary of all employees in each department in a table named "employees"?

SELECT SUM(salary) AS total_salary, CONVERT(VARCHAR,department) AS department FROM employees
GROUP BY CONVERT(VARCHAR, department);

	--How do you calculate the average salary of all employees in each department in a table named "employees"?

SELECT AVG(salary) AS average_slary, CONVERT(VARCHAR,department) AS department FROM employees
GROUP BY CONVERT(VARCHAR, department);

	--How do you calculate the highest salary of all employees in each department in a table named "employees"?

SELECT MAX(salary) AS highest_salary, CONVERT(VARCHAR,department) AS department FROM employees
GROUP BY CONVERT(VARCHAR, department);

	--How do you calculate the lowest salary of all employees in each department in a table named "employees"?

SELECT MIN(salary) AS highest_salary, CONVERT(VARCHAR,department) AS department FROM employees
GROUP BY CONVERT(VARCHAR, department);

	--How do you select the employees who have been hired in the last year from a table named "employees"?

SELECT *FROM employees
WHERE hire_date >= DATEADD(YEAR, -1, GETDATE());

	--How do you select the employees who have been hired in the last 6 months from a table named "employees"?

SELECT *FROM employees
WHERE hire_date >= DATEADD(MONTH, -6, GETDATE());

	--How do you select the employees who have been hired in the last 3 months from a table named "employees"?

SELECT *FROM employees
WHERE hire_date >= DATEADD(MONTH, -3, GETDATE());

	--How do you select the employees who have been hired in the last week from a table named "employees"?

SELECT *FROM employees
WHERE hire_date >= DATEADD(WEEK, -1, GETDATE());

	--How do you select the employees who have a name that starts with the letter "A" in a table named "employees"?

SELECT * FROM employees WHERE employee_name LIKE 'A%';

	--How do you select the employees who have a name that ends with the letter "s" in a table named "employees"?

SELECT * FROM employees WHERE employee_name LIKE '%s';

DROP TABLE employees;

