-- Table for employeeRecords

CREATE TABLE employeeRecords (
	id SERIAL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Sex CHAR(1),
    DOJ DATE,
    CurrentDate DATE,
    Designation VARCHAR(100),
    Age INT,
    Salary DECIMAL(10, 2),
    Unit VARCHAR(100),
    LeavesUsed INT,
    LeavesRemaining INT,
    Ratings DECIMAL(3, 2),
    PastExperience INT
);

--ingest data

COPY employeeRecords(FirstName, LastName, Sex, DOJ, CurrentDate, Designation, Age, Salary, Unit, LeavesUsed, LeavesRemaining, Ratings, PastExperience)
FROM 'D:/leapfrog assignments/lf db assignment/assignment4/record.csv'
DELIMITER ','
CSV HEADER;

-- Common Table Expressions (CTEs):
-- Question 1: Calculate the average salary by department for all Analysts.

WITH analyst_salary AS (
    SELECT e.firstname, e.lastname, e.salary,e.unit  
    FROM employeerecords e 
    WHERE e.designation = 'Analyst'
)
SELECT unit,ROUND(AVG(salary)) AS avg_salary 
FROM analyst_salary 
GROUP BY unit;


-- Question 2: List all employees who have used more than 10 leaves.

With leaver AS(
	Select  e.firstname,e.lastname,e.leavesused 
	FROM employeeRecords e 
	Where e.leavesused>10
)

select * from leaver

-- Views:
-- Question 3: Create a view to show the details of all Senior Analysts.

CREATE VIEW Senior_analyst  AS
	SELECT * 
	FROM employeerecords e
	WHERE e.designation='Senior Analyst';

-- Materialized Views:
-- Question 4: Create a materialized view to store the count of employees by department.

CREATE MATERIALIZED VIEW employee_count_by_departments AS 
	SELECT e.unit, Count(e.id) 
	FROM employeerecords e 
	GROUP BY e.unit;

-- Procedures (Stored Procedures):
-- Question 6: Create a procedure to update an employee's salary by their first name and last name.

CREATE OR REPLACE PROCEDURE update_employees_salary(
	fname VARCHAR(100),
	lname VARCHAR(100),
	new_salary INT
)
LANGUAGE plpgsql
AS $$
BEGIN
	Update employeerecords 
	SET salary= new_salary
	WHERE firstname=fname AND lastname=lname;
END;
$$;

CALL update_employees_salary('TOMASA','ARMEN',20000);


-- Question 7: Create a procedure to calculate the total number of leaves used across all departments.

CREATE OR REPLACE PROCEDURE calculate_total_leaves()
LANGUAGE plpgsql
AS $$
BEGIN 
	CREATE OR REPLACE VIEW total AS
	SELECT SUM(leavesused)
	AS total_leaves
	FROM employeerecords;	
END;
$$;

CALL calculate_total_leaves();





