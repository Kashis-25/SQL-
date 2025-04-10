create database casestudy2
-- Create Table  loction 
use casestudy2
create table location (Location_Id Int Primary key, city varchar(20) );
insert into location (Location_Id,city) values
(122, 'New York'),
(123, 'Dallas'),
(124, 'Chicago'),
(167, 'Boston');
-- Create table department
CREATE TABLE DEPARTMENT (
    Department_ID INT PRIMARY KEY,
    Name VARCHAR(20),
    location_ID INT,
    FOREIGN KEY (location_ID) REFERENCES LOCATION(Location_ID)
);
insert into DEPARTMENT (Department_ID, Name, location_ID) values 
(10,'Accounting', 122),
(20, 'Sales', 124),
(30, 'Research', 123),
(40, 'Operations' ,167);

--Create Table JOB 
create table Job(Job_Id Int primary key,designation varchar(20)); 
insert into Job(Job_Id,designation) values 
(667,'Clerk'),
(668, 'Staff'),
(669, 'Analyst'),
(670, 'Sales Person'),
(671, 'Manager'),
(672, 'President');

-- Create Table Employees
CREATE TABLE EMPLOYEE (
    Employee_Id INT PRIMARY KEY,
    Last_name VARCHAR(20),
    First_Name VARCHAR(20),
    Middle_Name VARCHAR(20),
    job_id INT,
    Hire_date DATE,
    salary INT,
    Comm INT,
    Department_ID INT,
    FOREIGN KEY (job_id) REFERENCES JOB(job_id),
    FOREIGN KEY (Department_ID) REFERENCES DEPARTMENT(Department_ID)
);
INSERT INTO EMPLOYEE (Employee_Id, Last_name, First_Name, Middle_Name, job_id, Hire_date, salary, Comm, Department_ID) VALUES
(7369, 'Smith', 'John', 'Q', 667, '1984-12-17', 800, NULL, 20),
(7499, 'Allen', 'Kevin', 'J', 670, '1985-02-20', 1600, 300, 30),
(7550, 'Doyle', 'Jean', 'K', 671, '1985-04-04', 2850, NULL, 30),
(7560, 'Dennis', 'Lynn', 'S', 671, '1985-05-15', 2750, NULL, 30),
(7570, 'Baker', 'Leslie', 'D', 671, '1985-06-10', 2200, NULL, 40),
(7521, 'Wark', 'Cynthia', 'D', 670, '1985-02-22', 1250, 50, 40);

--Simple Queries:
--1. List all the employee details.
use casestudy2
select * from EMPLOYEE

--2. List all the department details
select * from DEPARTMENT

--3. List all job details.
select * from Job

-- 4 List all the locations.
select * from location

-- 5 List out the First Name, Last Name, Salary, Commission for all Employees.
select first_name,last_name,salary,comm from EMPLOYEE

-- 6 List out the Employee ID, Last Name, Department ID for all employees and alias Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id"
 select Employee_Id as 'ID of the Employee', last_name as 'Name of the Employee',department_id  Dep_id from Employee

 -- 7 List out the annual salary of the employees with their names only.
 select salary *12 as 'Annual salary', concat(first_name, Last_name) as 'Employee Name' from EMPLOYEE

 --  === WHERE CONDITION ===

 --1 List the details about "Smith
 select * from EMPLOYEE where Last_name = 'smith'

 -- 2 List out the employees who are working in department 20.
 use casestudy2
 select * from EMPLOYEE where Department_ID = 20

 -- 3 . List out the employees who are earning salary between 2000 and 3000.
 select * from EMPLOYEE where salary between 2000 AND 3000;

-- 4 List out the employees who are working in department 10 or 20
select * from Employee where Department_ID in (10,20);

-- 5 Find out the employees who are not working in department 10 or 30.
select * from EMPLOYEE where Department_ID in (10,30);

-- 6 List out the employees whose name starts with 'L'.
select * from EMPLOYEE where First_Name like  'L%';

--7 List out the employees whose name starts with 'L' and ends with 'E'
select * from EMPLOYEE where First_Name like 'l%E';

-- 8 List out the employees whose name length is 4 and start with 'J'
select * from EMPLOYEE where First_Name like 'J_';

-- 9 List out the employees who are working in department 30 and draw the salaries more than 2500
select * from EMPLOYEE where Department_ID =30 and salary>2500;

-- 10 List out the employees who are not receiving commission.
select * from EMPLOYEE where comm is null;

-- === ORDER BY CLAUSE ===
-- 1 List out the Employee ID and Last Name in ascending order based on the Employee ID.
select employee_id, last_name from EMPLOYEE order by Employee_Id ASC;

-- 2 List out the Employee ID and Name in descending order based on salary
select employee_id,last_name from EMPLOYEE  order by Last_name desc;

-- 3 List out the employee details according to their Last Name in ascending-order
select * from EMPLOYEE order by Last_name asc;

-- 4 List out the employee details according to their Last Name in ascending order and then Department ID in descending order.
select * from EMPLOYEE order by Last_name asc , Department_ID desc;

-- GROUP BY & HAVING CLAUSE 

-- 1 List out the employee details according to their Last Name in ascending order and then Department ID in descending order.
use casestudy2
select * from EMPLOYEE order by last_name asc, department_id desc;

--2 List out the job wise maximum salary, minimum salary and average salary of the employees
use casestudy2 
SELECT 
    Job.designation,
    MAX(EMPLOYEE.salary) AS Max_Salary,
    MIN(EMPLOYEE.salary) AS Min_Salary,
    AVG(EMPLOYEE.salary) AS Avg_Salary
FROM EMPLOYEE
JOIN Job ON EMPLOYEE.job_id = Job.Job_Id
GROUP BY Job.designation;
--3 List out the number of employees who joined each month in ascending order.
select year(hire_date) As year, month (hire_date) as month, count(employee_id) As 'Number Of Employee' from employee group by year(hire_date),month(hire_date) having count(employee_id)>0 order by year, month;
-- 4 List out the number of employees for each month and year in ascending order based on the year and month.
SELECT 
    YEAR(hire_date) AS 'Joining Year', 
    MONTH(hire_date) AS 'Joining Month', 
    COUNT(employee_Id) AS 'Number Of Employees'
FROM EMPLOYEE
GROUP BY YEAR(hire_date), MONTH(hire_date)
ORDER BY YEAR(hire_date) ASC, MONTH(hire_date) ASC;

-- 5 List out the Department ID having at least four employees.
use casestudy2
select department_id, 
COUNT(Employee_ID) as 'Number of Employees'
from EMPLOYEE
GROUP BY  Department_id 
having count(employee_id) >=4;
 
 -- 6 How many employees joined in February month?
 SELECT count(employee_id) As 'Employee Joined in February' from employee  where Month(hire_date)=2  GROUP BY MONTH(HIRE_DATE) HAVING COUNT(EMPLOYEE_ID) >0; 

 -- 7 List out the employees whose name starts with 'L' and ends with 'E
 use casestudy2
 select * from employee WHERE first_name like 'l%E';

 -- 8	List out the employees whose name length is 4 and start with 'J'
 select * from employee where first_name like 'J__' AND len(First_name) = '4';

 -- 9 List out the employees who are working in department 30 and draw the salaries more than 2500.
 select * from employee where department_id = '30'and salary <=2500;

 -- 10 List out the employees who are not receiving commission
 select * from employee where comm = null

 -- Order By clause
 -- 1 List out the Employee ID and Last Name in ascending order based on the Employee ID.
 select employee_id, last_name from employee ORDER BY  employee_id asc;

 -- 2 List out the Employee ID and Name in descending order based on salary
  select employee_id, first_name, last_name, middle_name from employee ORDER BY  employee_id desc;

  -- 3 List out the employee details according to their Last Name in ascending-order.
  select *  from employee ORDER BY last_name asc;

  -- 4 List out the employee details according to their Last Name in ascending
order and then Department ID in descending order.

-- GROUP BY and HAVING Clause:
-- 1 List out the department wise maximum salary, minimum salary and average salary of the employees
select   max(salary) as 'MAX SALARY', min(salary) AS 'MIN SALARY', avg(salary)  AS 'AVERAGE SALARY'from employee   GROUP BY department_id;

-- 2 List out the job wise maximum salary, minimum salary and average salary of the employees.
use casestudy2
select j.designation as job_Title, max(salary) as 'MAXIMUM SALARY', min(salary) AS 'MINIMUM SALARY', avg(salary) AS 'Average Salary' from employee e JOIN JOB j on e.job_id = j.job_id Group By j.designation having count(e.employee_id)>0;

-- 3 List out the number of employees who joined each month in ascending order.
select datepart(month,Hire_date) AS ' Hire Month', datepart(Year,Hire_date) AS 'Hire Year', count(employee_id) AS 'Number_of_Employee' From employee Group By datepart(month,Hire_date), datepart(Year,Hire_date) ORDER BY datepart(month,Hire_date) ASC,datepart(Year,Hire_date) ASC;

--4  List out the number of employees for each month and year in ascending order based on the year and month.
SELECT 
    DATEPART(year, Hire_date) AS 'Hire Year', 
    DATEPART(month, Hire_date) AS 'Hire Month', 
    COUNT(Employee_Id) AS 'Number_of_Employees'
FROM 
    EMPLOYEE
GROUP BY 
    DATEPART(year, Hire_date), 
    DATEPART(month, Hire_date)
ORDER BY 
    DATEPART(year, Hire_date) ASC, 
    DATEPART(month, Hire_date) ASC;

-- 5 List out the Department ID having at least four employees
use casestudy2
select Department_ID AS 'TOTAL DEPARTMENT ID', count(Employee_id) AS 'Total OF Employee'  FROM EMPLOYEE Group By Department_ID having count (Employee_ID)>= 4;

--6 How many employees joined in February month.
use casestudy2
select count(Employee_Id) as 'Employee Joined In Feburary' from EMPLOYEE  where datepart(month,Hire_date) =2;

-- 7 How many employees joined in May or June month.
USE casestudy2;

DECLARE @May INT = 5;
DECLARE @June INT = 6;

SELECT 
    DATEPART(year, hire_date) AS 'Hire Year',
    DATEPART(month, hire_date) AS 'Hire Month',
    COUNT(employee_id) AS 'No of Employee Joined This Month'
FROM 
    employee
WHERE 
    DATEPART(month, hire_date) IN (@May, @June)
GROUP BY 
    DATEPART(year, hire_date),
    DATEPART(month, hire_date);

--8 	How many employees joined in 1985?
select datepart(yy,[Hire_date]) as 'Joining Date', count(*)as 'Number of employee' from employee  Group By datepart(yy,[hire_date]) having datepart(yy,[Hire_date])='1985'

-- 9 How many employees joined each month in 1985?
USE casestudy2;

SELECT 
    DATENAME(month, [hire_date]) AS Month,
    COUNT(*) AS [Number of Employees]
FROM 
    EMPLOYEE
WHERE 
    YEAR([hire_date]) = 1985
GROUP BY 
    DATEpart(month, [hire_date]),
    DATEPART(month, [hire_date])
ORDER BY 
    DATEPART(month, [hire_date]);

	-- 10 How many employees were joined in April 1985?
SELECT 
    COUNT(*) AS 'No Of Employees Joined In April 1985',
    DATEPART(mm, [hire_date]) AS 'Hire Month',
    DATEPART(yy, [hire_date]) AS 'Hire Year'
FROM 
    EMPLOYEE
GROUP BY 
    DATEPART(yy, [hire_date]),
    DATEPART(mm, [hire_date])
HAVING 
    DATEPART(yy, [hire_date]) = 1985 
    AND DATEPART(mm, [hire_date]) = 4;

-- 11  Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
use casestudy2
select  Department_id, count(*) As' no of employee' from employee where datepart(mm,[hire_date])=1985 AND datepart(yy,[hire_date]) =4 Group By department_id having count (*)>=3;

-- Joins
 
-- 1 List out employees with their department names.
USE casestudy2;

SELECT 
    e.Employee_Id,
    e.Last_name,
    e.First_Name,
    e.Middle_Name,
    d.Name AS Department_Name
FROM 
    EMPLOYEE e
JOIN 
    DEPARTMENT d ON e.Department_ID = d.Department_ID;

	-- 2 Display employees with their designations.
	select 
	e.Employee_Id,
    e.Last_name,
    e.First_Name,
    e.Middle_Name,
    j.designation  AS 'Designation'

	from employee e
	JOIN
	Job j ON e.job_id =j.job_id;

-- 3 Display the employees with their department names and city.
select 
e.Employee_Id,
    e.Last_name,
    e.First_Name,
    e.Middle_Name,
	d.Name AS 'Department name',
	L.city As 'City Name'
	
	from employee e
	join
	department d on e.department_id = d.department_id
	join
	location l on d.location_id = l.location_id;

	-- 4 How many employees are working in different departments? Display with department names
	USE casestudy2;

SELECT COUNT(*) AS EMPLOYEE_COUNT,D.NAME FROM EMPLOYEE AS E
INNER JOIN DEPARTMENT AS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.NAME

-- 5 How many employees are working in the sales department?
use casestudy2
select count(e.Employee_id) AS 'Employee Wokring In Sales Department'
from department d 
join
employee e ON d.department_id = e.department_id
where 
d.name = 'sales';

-- 6 Which is the department having greater than or equal to 3 employees and display the department names in ascending order.
use casestudy2
select d.name As ' Department Name', count(e.employee_id) AS 'Number Of Employee'
from department d
join 
employee e ON d.department_ID = e.department_id
Group By
d.name
Having 
count(e.employee_id) >=3
Order By 
d.name ASC;

-- 7 How many employees are working in 'Dallas'?
select 
count(e.employee_id) AS Number_Of_Employee
from
employee e
Join 
Department d ON e.department_ID = d.department_id
JOIN 
Location l ON d.location_Id = L.location_id
where 
l.city = 'DALLAS';

-- 8 Display all employees in sales or operation departments?

SELECT 
    e.Employee_Id,
    e.Last_name,
    e.First_Name,
    e.Middle_Name,
    d.Name AS Department_Name
FROM 
    EMPLOYEE e
JOIN 
    DEPARTMENT d ON e.Department_ID = d.Department_ID
WHERE 
    d.Name IN ('Sales', 'Operations');



-- Conditional Statement 
-- 1 Display the employee details with salary grades. Use conditional statement to create a grade column.
use casestudy2 
select 
e.employee_id,
e.last_name,
e.first_name,
e.middle_name,
e.salary,
case
when e.salary < 1000 Then 'Grade D'
when e.salary >= 1000 AND e.salary <2000 THEN 'Grade C'
when e.salary >=2000 AND e.salary <3000 THEN 'Grade B'
ELSE 'GRADE A'
END AS  SALARY_GRADE
FROM 
EMPLOYEE E;

-- 2 List out the number of employees grade wise. Use conditional statement to create a grade column.use casestudy2SELECT 
    CASE
        WHEN e.salary < 1000 THEN 'Grade D'
        WHEN e.salary >= 1000 AND e.salary < 2000 THEN 'Grade C'
        WHEN e.salary >= 2000 AND e.salary < 3000 THEN 'Grade B'
        ELSE 'Grade A'
    END AS Salary_Grade,
    COUNT(*) AS Number_of_Employees
FROM 
    EMPLOYEE e
GROUP BY 
    CASE
        WHEN e.salary < 1000 THEN 'Grade D'
        WHEN e.salary >= 1000 AND e.salary < 2000 THEN 'Grade C'
        WHEN e.salary >= 2000 AND e.salary < 3000 THEN 'Grade B'
        ELSE 'Grade A'
    END
ORDER BY 
    Salary_Grade;
	-- 3 Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
	SELECT 
    CASE
        WHEN e.salary < 2000 THEN 'Below 2000'
        WHEN e.salary >= 2000 AND e.salary < 3000 THEN '2000-2999'
        WHEN e.salary >= 3000 AND e.salary <= 5000 THEN '3000-5000'
        ELSE 'Above 5000'
    END AS Salary_Grade,
    COUNT(*) AS Number_of_Employees
FROM 
    EMPLOYEE e
WHERE 
    e.salary BETWEEN 2000 AND 5000
GROUP BY 
    CASE
        WHEN e.salary < 2000 THEN 'Below 2000'
        WHEN e.salary >= 2000 AND e.salary < 3000 THEN '2000-2999'
        WHEN e.salary >= 3000 AND e.salary <= 5000 THEN '3000-5000'
        ELSE 'Above 5000'
    END
ORDER BY 
    Salary_Grade;


	-- SUBQUERIES
	--1  Display the employees list who got the maximum salary
	USE casestudy2;

SELECT 
    e.Employee_Id,
    e.Last_name,
    e.First_Name,
    e.Middle_Name,
    e.salary
FROM 
    EMPLOYEE e
WHERE 
    e.salary = (SELECT MAX(salary) FROM EMPLOYEE);

-- 2 Display the employees who are working in the sales department

USE casestudy2;

SELECT 
    e.Employee_Id,
    e.Last_name,
    e.First_Name,
    e.Middle_Name,
    e.salary
FROM 
    EMPLOYEE e
WHERE 
    e.Department_ID = (SELECT Department_ID FROM DEPARTMENT WHERE Name = 'Sales');

	-- 3 Display the employees who are working as 'Clerk'
	USE casestudy2;

SELECT 
    e.Employee_Id,
    e.Last_name,
    e.First_Name,
    e.Middle_Name,
    e.salary
FROM 
    EMPLOYEE e
WHERE 
    e.job_id = (SELECT Job_Id FROM JOB WHERE designation = 'Clerk');
	

	-- 4 Display the list of employees who are living in 'Boston'
	SELECT 
    e.Employee_Id,
    e.Last_name,
    e.First_Name,
    e.Middle_Name,
    e.salary
FROM 
    EMPLOYEE e
WHERE 
    e.Department_ID IN (
        SELECT 
            d.Department_ID
        FROM 
            DEPARTMENT d
        WHERE 
            d.location_ID = (SELECT l.Location_ID FROM LOCATION l WHERE l.city = 'Boston')
    );

	-- 5 Find out the number of employees working in the sales department
	USE casestudy2;

SELECT 
    COUNT(*) AS Number_of_Employees
FROM 
    EMPLOYEE e
WHERE 
    e.Department_ID = (SELECT Department_ID FROM DEPARTMENT WHERE Name = 'Sales');

-- 6 Update the salaries of employees who are working as clerks on the basis of 10%.
USE casestudy2;

UPDATE 
    EMPLOYEE
SET 
    salary = salary * 1.10
WHERE 
    job_id = (SELECT Job_Id FROM JOB WHERE designation = 'Clerk');

	--7 Display the second highest salary drawing employee details.
	USE casestudy2;

SELECT 
    e.Employee_Id,
    e.Last_name,
    e.First_Name,
    e.Middle_Name,
    e.salary
FROM 
    EMPLOYEE e
WHERE 
    e.salary = (
        SELECT MAX(salary) 
        FROM EMPLOYEE 
        WHERE salary < (
            SELECT MAX(salary) 
            FROM EMPLOYEE
        )
    );
	--8 List out the employees who earn more than every employee in department 30
	SELECT 
    e.Employee_Id,
    e.Last_name,
    e.First_Name,
    e.Middle_Name,
    e.salary
FROM 
    EMPLOYEE e
WHERE 
    e.salary > (SELECT MAX(salary) FROM EMPLOYEE WHERE Department_ID = 30);

	-- 9 Find out which department has no employees.
	USE casestudy2;

SELECT 
    d.Department_ID,
    d.Name AS Department_Name
FROM 
    DEPARTMENT d
WHERE 
    d.Department_ID NOT IN (SELECT DISTINCT e.Department_ID FROM EMPLOYEE e);

-- 10 Find out the employees who earn greater than the average salary for their department
USE casestudy2;

SELECT 
    e.Employee_Id,
    e.Last_name,
    e.First_Name,
    e.Middle_Name,
    e.salary,
    e.Department_ID
FROM 
    EMPLOYEE e
WHERE 
    e.salary > (
        SELECT AVG(salary) 
        FROM EMPLOYEE 
        WHERE Department_ID = e.Department_ID
    );