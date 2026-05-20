CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)



--Simple Queries
--1. List all the employee details
Select * from [dbo].[EMPLOYEE];

--2. List all the department details
Select * from [dbo].[DEPARTMENT];

--3. List of all job details.
Select * from [dbo].[JOB];

--4. List of all the location.
Select * from [dbo].[LOCATION];

--5. List out the first name, last name, salary, commission for all employee
Select [First_Name], [Last_Name], [Salary], [COMM]
From [dbo].[EMPLOYEE];

--6.List out the employee ID, last name, department Id for all the employees and alias
Select [Employee_Id] AS [ID of the Employee], [Last_Name] AS [Name of the Employee], [Department_Id] AS Dep_Id
From [dbo].[EMPLOYEE];

--7. List out the annual salary of the employee with their names only.
Select [First_Name] + ' ' + [Last_Name] AS [Name], [Salary] * 12 AS Annual_Salary
From [dbo].[EMPLOYEE];

--Where Condition
--1. List the details about Smith
Select * from [dbo].[EMPLOYEE]
Where [Last_Name] = 'Smith';

--2. List out the employee who are working in department 20.
Select * from [dbo].[EMPLOYEE]
Where [Department_Id] = 20;

--3.List out all the employees who are earning between 2000 and 3000
Select * from [dbo].[EMPLOYEE]
Where [Salary] BETWEEN 2000 AND 3000;

--4. list out all the employees who are working in department 10 or 20.
Select * from [dbo].[EMPLOYEE]
Where [Department_Id] IN (10,20);

--5. Find out the employees who are not working in department 10 or 30.
Select * from [dbo].[EMPLOYEE]
Where [Department_Id] NOT IN (10,30);

--6. List out the employees whose name start with L.
Select * from [dbo].[EMPLOYEE]
Where [First_Name] LIKE 'L%';

--7. List out the employees whose name starts with L and ends with E.
Select * from [dbo].[EMPLOYEE]
Where [First_Name] LIKE 'L%e';

--8. List out the employees whose name length is 4 and start with J.
Select * from [dbo].[EMPLOYEE]
Where LEN([First_Name]) = 4 AND [First_Name] LIKE 'J%';

--9. List out the employees who are working in department 30 and draw salary more than 2500.
Select * from [dbo].[EMPLOYEE]
Where [Department_Id] = 30 AND [Salary] > 2500;

--10. List out the employee who are not receiving commission.
Select * from [dbo].[EMPLOYEE]
Where [COMM] IS NULL;

--ORDER BY Clause
--1. List out employee ID and last name in ascending order based on employee id.
Select [Employee_Id], [Last_Name]
From [dbo].[EMPLOYEE]
ORDER BY [Employee_Id];

--2. List out the employee ID and Name in descending order based on salary.
Select [Employee_Id], [Last_Name]
From [dbo].[EMPLOYEE]
ORDER BY [Salary] DESC;

--3. List out the employee details according to their last name in ascending order.
Select * From [dbo].[EMPLOYEE]
ORDER BY [Last_Name];

--4.List out the employee details according to their last name in ascending order and then department id in descending order.
Select * From [dbo].[EMPLOYEE]
ORDER BY [Last_Name] ASC, [Department_Id] DESC;

--GROUP BY and HAVING Clause
--1. List out the department wise maximum salary, minimum salary  and average salary of the employee.
Select [Department_Id], Max([Salary]) AS Max_Salary, Min([Salary]) AS Min_salary, AVG([Salary]) AS Average_Salary
From [dbo].[EMPLOYEE]
GROUP BY [Department_Id];

--2. List out the job wise maximum salary, minimum salary and average salalry of the employee.
Select [Job_Id], Max([Salary]) AS Max_Salary, Min([Salary]) AS Min_salary, AVG([Salary]) AS Average_Salary
From [dbo].[EMPLOYEE]
GROUP BY [Job_Id];

--3. List out the number of employee who joined each month in ascending order.
Select Month([Hire_Date]) AS MONTH, COUNT(*) AS EmployeeCount 
FROM [dbo].[EMPLOYEE]
GROUP BY [Hire_Date]
ORDER BY MONTH;

--4. List out the number of employee for each month and year in the ascending  based on year and month
Select MONTH([Hire_Date]) AS Month, YEAR([Hire_Date]) AS Year, Count(*) AS EmployeeCount
From [dbo].[EMPLOYEE]
Group by YEAR([Hire_Date]), MONTH([Hire_Date])
Order by Year, Month;

--5. List out the Department Id having atleast four employee.
Select [Department_Id]
From [dbo].[EMPLOYEE]
GROUP BY [Department_Id]
Having Count(*)>=4;

--6. How many employees joing in February month
Select Count(*) AS Feb_EMP
From [dbo].[EMPLOYEE]
Where MONTH([Hire_Date]) = 2;

--7. How many employee joined in May or June Month
Select Count(*) AS Feb_Jun_Emp
From [dbo].[EMPLOYEE]
Where MONTH([Hire_Date]) In (5,6);

--8. How many employee joined in 1985
Select Count(*) AS Joined_1985
From [dbo].[EMPLOYEE]
where Year([Hire_Date]) = 1985;

--9. How many employee joined each month in 1985
Select Count(*) AS Emp_No, MONTH([Hire_Date]) AS Month
From [dbo].[EMPLOYEE]
where YEAR([Hire_Date]) = 1985
GROUP BY MONTH([Hire_Date]);

--10. How many employee joined in April 1985.
Select Count(*) AS Emp_joined_Apr_1985
From [dbo].[EMPLOYEE]
Where YEAR([Hire_Date]) = 1985 AND MONTH([Hire_Date]) = 4;

--11. Which is the department Id having greater than or equal to 3 employees joining in April 1985.
Select [Department_Id] AS Dept_Id
from [dbo].[EMPLOYEE]
Where MONTH([Hire_Date]) = 4 And YEAR([Hire_Date]) = 1985
GROUP BY [Department_Id]
Having Count(*)>=3;

--Joins 
--1. List out employees with their department name
Select E.[First_Name] AS Emp_Name, D.[Name] AS Dept_Name
From [dbo].[EMPLOYEE] E
Join [dbo].[DEPARTMENT] D on E.[Department_Id] = D.[Department_Id];

--2.Display Employees with their designation 
Select E.[First_Name] AS Emp_Name, J.[Designation] AS Designation 
From [dbo].[EMPLOYEE] E
Join [dbo].[JOB] J on E.[Job_Id] = J.[Job_ID];

--3. Display Employee with their department name and city
Select E.[First_Name], D.[Name], L.[City]
From [dbo].[EMPLOYEE] E
Join [dbo].[DEPARTMENT] D on E.Department_Id = D.Department_Id
Join [dbo].[LOCATION] L on D.Location_Id = L.Location_ID;

--4. How many employees are working in different departments? Display with department name.
Select D.[Name], Count(E.[First_Name]) AS No_of_Emp
From [dbo].[EMPLOYEE] E
Join [dbo].[DEPARTMENT] D on E.Department_Id = D.Department_Id
Group BY D.Name;

--5. how many employees working in sales
Select COUNT(*) AS Sales_Emp
From [dbo].[EMPLOYEE] E
Join [dbo].[DEPARTMENT] D on E.Department_Id = D.Department_Id
Where D.[Name] = 'Sales';

--6.Which is the department having greater than or equal to 3 employees and display the department name in ascending order.
Select E.[First_Name] AS Emp_Name, D.[Name] AS Dept_Name
From EMPLOYEE E
Join [dbo].[DEPARTMENT] D on E.Department_Id = D.Department_Id
Order by D.[Name];

--7. How many  employees working from Dallas 
Select COUNT(*) AS Total_Emp
From EMPLOYEE E
Join [dbo].[DEPARTMENT] D on E.[Department_Id] = D.Department_Id
Join [dbo].[LOCATION] L on D.Location_Id = L.Location_ID
Where [City] = 'Dallas';

--8. Display all the employees in sales or operation department
Select E.[First_Name] AS emp_Name, D.[Name] AS Dept_Name
From EMPLOYEE E
Join [dbo].[DEPARTMENT] D on E.Department_Id = D.Department_Id
Where D.[Name] in ('Sales', 'Operations');

--Conditional Statement
--1. Display the employee details with salary grade. Use conditional statement to create a grade column.
Select *,
CASE
	When [Salary] < 1000 THEN 'Grade D'
	When [Salary] BETWEEN 1000 AND 1999 THEN 'Grade C'
	When [Salary] Between 2000 AND 2999 THEN 'Grade B'
	When [Salary] >= 3000 THEN 'Grade A'
	ELSE 'No Grade'
End AS Grade
From [dbo].[EMPLOYEE];

--2. List out the  number of employees grade wise. Use conditional fstatement to create a grade column.
Select
CASE
	When [Salary] < 1000 THEN 'Grade D'
	When [Salary] BETWEEN 1000 AND 1999 THEN 'Grade C'
	When [Salary] Between 2000 AND 2999 THEN 'Grade B'
	When [Salary] >= 3000 THEN 'Grade A'
	ELSE 'No Grade'
End AS Grade,
Count(*) AS Emp_Count
From [dbo].[EMPLOYEE]
Group By
CASE
	When [Salary] < 1000 THEN 'Grade D'
	When [Salary] BETWEEN 1000 AND 1999 THEN 'Grade C'
	When [Salary] Between 2000 AND 2999 THEN 'Grade B'
	When [Salary] >= 3000 THEN 'Grade A'
	ELSE 'No Grade'
End;
	
--3. Display the employee salary grade and tge number of employees between 200 to 5000 range of salary.
SELECT 
  CASE 
    WHEN Salary BETWEEN 2000 AND 2999 THEN 'Grade B'
    WHEN Salary BETWEEN 3000 AND 5000 THEN 'Grade A'
    ELSE 'Other'
  END AS Grade,
  COUNT(*) AS EmployeeCount
FROM EMPLOYEE
WHERE Salary BETWEEN 2000 AND 5000
GROUP BY 
  CASE 
    WHEN Salary BETWEEN 2000 AND 2999 THEN 'Grade B'
    WHEN Salary BETWEEN 3000 AND 5000 THEN 'Grade A'
    ELSE 'Other'
  END;

 --Subqueries
 --1. Display the employees list who got the maximum salary.
  Select * From [dbo].[EMPLOYEE]
  Where [Salary] = (Select Max([Salary]) From [dbo].[EMPLOYEE]);

 --2. Display the employees who are working in th sales department
  Select * From [dbo].[EMPLOYEE] 
  WHERE [Department_Id] = (Select [Department_Id] From [dbo].[DEPARTMENT] Where [Name] = 'Sales');

 --3. Display the Employee who are working as Clerk
  Select * From [dbo].[EMPLOYEE]
  Where Job_Id = (Select [Job_ID] From [dbo].[JOB] Where [Designation] = 'Clerk');

 --4. Display the list of Employees who alives in Boston.
  Select * From [dbo].[EMPLOYEE]
  Where [Department_Id] = (Select [Department_Id] From [dbo].[DEPARTMENT] 
						   Where Location_Id = (Select [Location_ID] FROM [dbo].[LOCATION] Where [City] = 'Boston')
						   );

--5. Find out the number of employees working in sales department.
Select Count(*) From [dbo].[EMPLOYEE]
Where [Department_Id] = (Select [Department_Id] From [dbo].[DEPARTMENT] Where [Name] = 'Sales' );

--6. Update the salaries of the employees who are working as clerks on the basis of 10%
UPDATE EMPLOYEE
Set Salary = Salary * 1.1
Where Job_Id = (Select Job_Id From JOB Where Designation = 'Clerk');

--7. Dispaly the second highest salary drawning employee details.
Select TOP 1*
From EMPLOYEE
Where Salary < (Select Max(Salary) From EMPLOYEE)
Order by Salary DESC;

--8. List out the employees who earn more than every employee in department 30
Select * from EMPLOYEE
Where Salary > ALL (Select Salary From [dbo].[EMPLOYEE] Where Department_Id = 30);

--9.Find Out which department has no employees
Select [Department_Id],[Name]  from [dbo].[DEPARTMENT]
Where [Department_Id] NOT IN (Select Distinct [Department_Id] From EMPLOYEE);

--10.Find out the employee who earns greater than the average salary from ther department
SELECT * 
FROM EMPLOYEE E
WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEE WHERE Department_Id = E.Department_Id);
