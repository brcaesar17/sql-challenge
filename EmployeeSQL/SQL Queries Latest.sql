-- CREATE SCHEMA OF THE SIX TABLES AND IMPORT THE CSV FILES DATA INTO THOSE TABLES:

-- TITLES 
DROP TABLE IF EXISTS titles CASCADE;

-- Create the table
CREATE TABLE Titles(
	Title_ID VARCHAR(7) PRIMARY KEY NOT NULL,
	Title_Name VARCHAR(45) NOT NULL
);

copy Titles from 'D:\Bootcamp\sql-challenge\EmployeeSQL\data\titles.csv' Delimiter ',' csv header;

SELECT * from Titles

-- EMPLOYEES 
-- Remove table if it exists
DROP TABLE IF EXISTS employees CASCADE;

-- Create the table
CREATE TABLE Employees(
	Emp_No INT NOT NULL,
	emp_title_id VARCHAR(7) not null
	Birth_Date DATETIME,
	First_Name VARCHAR(45) NOT NULL,
	Last_Name VARCHAR(45) NOT NULL,
	Sex VARCHAR(10) NOT NULL,
	Hire_Date DATETIME,
	PRIMARY KEY Emp_No,
	FOREIGN KEY Emp_title_ID
);
copy Employees from 'D:\Bootcamp\sql-challenge\EmployeeSQL\data\employees.csv' Delimiter ',' csv header;

select * from Employees

-- DEPARTMENTS 
-- Remove table if it exists
DROP TABLE IF EXISTS Departments CASCADE;

-- Create the table
CREATE TABLE Departments(
	Dept_No VARCHAR(7) PRIMARY KEY NOT NULL,
	Dept_name VARCHAR(45) NOT NULL
);
copy Departments from 'D:\Bootcamp\sql-challenge\EmployeeSQL\data\departments.csv' Delimiter ',' csv header;

SELECT * FROM Departments


-- MANAGERS 
--DROP TABLE IF EXISTS Managers;

-- Create the table
CREATE TABLE Managers (
	ept_No VARCHAR(7) FK >- Departments.Dept_No,
	Emp_No Int FK >- Employees.Emp_No,
);
copy Managers from 'D:\Bootcamp\sql-challenge\EmployeeSQL\data\dept_manager.csv' Delimiter ',' csv header;

SElect * from Managers


-- SALARIES 
DROP TABLE IF EXISTS Salary CASCADE;

create table Salary (
-Emp_No Int FK >- Employees.Emp_No,	
Salary int not NULL
);
copy Salary from 'D:\Bootcamp\sql-challenge\EmployeeSQL\data\salaries.csv' Delimiter ',' csv header;

SELECT * from Salary


-- EMPLOYEES AND DEPARTMENTS 
DROP TABLE IF EXISTS Dept_Emp;

create table Dept_Emp (
	Dept_No VARCHAR(7) FK >- Departments.Dept_No,
	Emp_No Int FK >- Employees.Emp_No
);

copy Dept_Emp from 'D:\Bootcamp\sql-challenge\EmployeeSQL\data\dept_emp.csv' Delimiter ','csv header;

SELECT * from Dept_Emp

-- DATA ANALYSIS 
--1. List the employee number, last name, first name, sex, and salary of each employee (2 points)
SELECT 
first_name, last_name, sex, salary
FROM 
Employees 
inner join Salary on Employees.Emp_No = Salary.Emp_No;

--2. List the first name, last name, and hire date for the employees who were hired in 1986 (2 points)
SELECT 
first_name, last_name, hire_date
FROM 
Employees 
WHERE (hire_date >='01-01-1986' and hire_date <='31-12-1986');


--3. List the manager of each department along with their department number, department name, employee number, last name, and first name (2 points)

select em.first_name, em.last_name, em.emp_no, dp.dept_name, dp.dept_no
from 
Departments as dp
inner join managers as mn on dp.dept_no = mn.dept_no
inner join employees as em on em.emp_no = mn.emp_no

--4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name (2 points)
select em.first_name, em.last_name, em.emp_no, dp.dept_no, dep.dept_name
from 
employees as em

inner join Dept_Emp as dp on em.emp_no = dp.emp_no
inner join Departments as dep on dep.dept_no = dp.dept_no

--5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B (2 points)
select 
first_name, last_name, sex
from 
employees 
where 
first_name = 'Hercules' and last_name like 'B%'

--6. List each employee in the Sales department, including their employee number, last name, and first name (2 points)
select em.first_name, em.last_name, em.emp_no, dp.dept_no, dep.dept_name
from 
employees as em

inner join Dept_Emp as dp on em.emp_no = dp.emp_no
inner join Departments as dep on dep.dept_no = dp.dept_no
where 
dep.dept_name = 'Sales'

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select em.first_name, em.last_name, em.emp_no, dep.dept_name
from 
employees as em

inner join Dept_Emp as dp on em.emp_no = dp.emp_no
inner join Departments as dep on dep.dept_no = dp.dept_no
where 
dep.dept_name = 'Sales' or dep.dept_name = 'Development'



-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT count(last_name) as lnf, last_name
FROM Employees as em
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;