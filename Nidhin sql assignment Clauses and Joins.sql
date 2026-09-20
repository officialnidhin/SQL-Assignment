CREATE DATABASE employee;
USE employee;
SELECT DATABASE();
CREATE TABLE Departments (
    department_id INT,
    department_name VARCHAR(50)
);
DESCRIBE Departments;
CREATE TABLE Location (
    location_id INT,
    location_name VARCHAR(100)
);
DESCRIBE Location;
CREATE TABLE Employees (
    employee_id INT,
    employee_name VARCHAR(50),
    gender CHAR(1),
    age INT,
    designation VARCHAR(50),
    hire_date DATE,
    department_id INT,
    location_id INT
);
DESCRIBE Employees;
ALTER TABLE Employees
ADD email VARCHAR(100);
DESCRIBE Employees;
ALTER TABLE Employees
MODIFY designation VARCHAR(100);
DESCRIBE Employees;
ALTER TABLE Employees
DROP COLUMN age;
DESCRIBE Employees;
ALTER TABLE Employees
RENAME COLUMN hire_date TO date_of_joining;
DESCRIBE Employees;
RENAME TABLE Departments TO Departments_Info;
RENAME TABLE Location TO Locations;
SHOW TABLES;
TRUNCATE TABLE Employees;
DROP TABLE Employees;
DROP DATABASE employee;
DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;
SELECT DATABASE();
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE
);
DESCRIBE Departments;
CREATE TABLE Location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M','F')),
    age INT CHECK (age >= 18),
    designation VARCHAR(100),
    hire_date DATE DEFAULT (CURRENT_DATE),
    department_id INT,
    location_id INT,
    
    FOREIGN KEY (department_id)
        REFERENCES Departments(department_id),
        
    FOREIGN KEY (location_id)
        REFERENCES Location(location_id)
);
SHOW TABLES;
DESCRIBE Departments;
DESCRIBE Location;
DESCRIBE Employees;
INSERT INTO Departments
VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'IT'),
(4, 'Finance');
SELECT * FROM Departments;
INSERT INTO Location (location_name)
VALUES
('Kochi'),
('Bangalore'),
('Chennai'),
('Mumbai');
SELECT * FROM Location;
INSERT INTO Employees
(employee_id, employee_name, gender, age, designation, department_id, location_id)
VALUES
(101, 'Rahul', 'M', 25, 'Analyst', 1, 1);

SELECT * FROM Employees;
INSERT INTO Departments
VALUES (5, 'HR');
INSERT INTO Departments
VALUES (5, NULL);
INSERT INTO Employees
(employee_id, employee_name, gender, age, designation, department_id, location_id)
VALUES
(102, 'Arun', 'X', 25, 'Analyst', 1, 1);
INSERT INTO Employees
(employee_id, employee_name, gender, age, designation, department_id, location_id)
VALUES
(103, 'Vijay', 'M', 16, 'Analyst', 1, 1);
INSERT INTO Location (location_name)
VALUES ('Kochi');
SHOW TABLES;
DESCRIBE Departments;
DESCRIBE Location;
DESCRIBE Employees;
SHOW CREATE TABLE Employees;
USE employee;

-- 1. DISTINCT VALUES
SELECT DISTINCT salary
FROM Employees;


-- 2. ALIAS (AS)
SELECT 
    age AS Employee_Age,
    salary AS Employee_Salary
FROM Employees;


-- 3. WHERE CLAUSE & OPERATORS

-- Employees with salary greater than 50000
-- and hired before 2016-01-01
SELECT *
FROM Employees
WHERE salary > 50000
  AND hire_date < '2016-01-01';


-- Employee whose designation is missing
SELECT *
FROM Employees
WHERE designation IS NULL;


-- Fill missing designation with Data Scientist
UPDATE Employees
SET designation = 'Data Scientist'
WHERE designation IS NULL;


-- 4. ORDER BY
SELECT *
FROM Employees
ORDER BY department_id ASC, salary DESC;


-- 5. LIMIT
-- First 5 employees hired in 2018
SELECT *
FROM Employees
WHERE hire_date >= '2018-01-01'
  AND hire_date < '2019-01-01'
ORDER BY hire_date ASC
LIMIT 5;


-- 6. AGGREGATE FUNCTIONS

-- Sum of all salaries in Finance department
SELECT SUM(e.salary) AS Total_Finance_Salary
FROM Employees e
INNER JOIN Departments d
    ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';


-- Minimum age among all employees
SELECT MIN(age) AS Minimum_Age
FROM Employees;


-- 7. GROUP BY

-- Maximum salary for each location
SELECT 
    l.location_name,
    MAX(e.salary) AS Maximum_Salary
FROM Location l
LEFT JOIN Employees e
    ON l.location_id = e.location_id
GROUP BY l.location_id, l.location_name;


-- Average salary for each designation containing 'Analyst'
SELECT 
    designation,
    AVG(salary) AS Average_Salary
FROM Employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;


-- 8. HAVING

-- Departments with less than 3 employees
SELECT 
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS Employee_Count
FROM Departments d
LEFT JOIN Employees e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 3;


-- Locations with female employees whose average age is below 30
SELECT 
    l.location_id,
    l.location_name,
    AVG(e.age) AS Average_Age
FROM Location l
INNER JOIN Employees e
    ON l.location_id = e.location_id
WHERE e.gender = 'F'
GROUP BY l.location_id, l.location_name
HAVING AVG(e.age) < 30;


-- 9. INNER JOIN
-- Employee names, designations and department names
SELECT 
    e.employee_name,
    e.designation,
    d.department_name
FROM Employees e
INNER JOIN Departments d
    ON e.department_id = d.department_id;


-- 10. LEFT JOIN
-- All departments with total number of employees
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS Total_Employees
FROM Departments d
LEFT JOIN Employees e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;


-- 11. RIGHT JOIN
-- All locations with employees assigned to each location
SELECT 
    l.location_name,
    e.employee_name
FROM Employees e
RIGHT JOIN Location l
    ON e.location_id = l.location_id;
    