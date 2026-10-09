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
