**Employees Analysis Project**
**Project Overview**

This project aims to analyze and provide insights into employee demographics, salary distributions, and departmental structures using SQL queries and visualizations. The dataset contains employee information, department details, salary data, and records of employee movement across different departments. The project includes creating views, stored procedures, and visualizations in Tableau to enhance understanding and dynamic analysis.


![Dashboard ](https://github.com/user-attachments/assets/4fc74b95-cb3e-4540-87f1-c293eaed9bc2)

**Task 1: Employee Gender Distribution Over Time
Description**

*This task involves creating a view named task_1_employee_count to analyze the distribution of employees by gender across different calendar years from 1990 onwards. The SQL query groups employees by year and gender, providing the number of employees for each grouping.*




**CREATE VIEW task_1_employee_count AS
SELECT
    YEAR(d.from_date) AS calendar_year,
    e.gender,
    COUNT(e.emp_no) AS number_of_employees
FROM 
    t_employees e 
    JOIN t_dept_emp d ON d.emp_no = e.emp_no
GROUP BY calendar_year, e.gender
HAVING calendar_year >= 1990;**

Purpose

*To track how the distribution of male and female employees has changed over the years, helping to identify hiring trends or shifts in workforce composition.*

**Task 2: Active Employees by Department and Year
Description**

*A view named task_2_active_employees is created to identify active employees in each department for every year they were employed. It uses a combination of a cross join to build a timeline and a case statement to mark active status.*




**CREATE VIEW task_2_active_employees AS
SELECT
    d.dept_name,
    ee.gender,
    ee.emp_no,
    dm.from_date,
    dm.to_date,
    e.calendar_year,
    CASE
        WHEN YEAR(dm.to_date) >= e.calendar_year AND YEAR(dm.from_date) <= e.calendar_year THEN 1
        ELSE 0
    END AS active
FROM
    (SELECT 
        YEAR(hire_date) AS calendar_year
     FROM 
        t_employees
     GROUP BY 
        YEAR(hire_date)) e
CROSS JOIN 
    t_dept_manager dm
JOIN 
    t_departments d ON dm.dept_no = d.dept_no
JOIN
    t_employees ee ON dm.emp_no = ee.emp_no
ORDER BY 
    dm.emp_no, e.calendar_year;**

Purpose

*To provide a comprehensive view of employee activity over time, helping to understand workforce allocation across departments and identifying trends in employee tenure.*


**Task 3: Average Salaries by Department, Gender, and Year
Description**

*This task generates a query that groups and calculates the average salary of employees by department, gender, and year. The results are limited to calendar years up until 2002. The query helps in analyzing salary trends and possible discrepancies between genders.*



**SELECT 
    e.gender,
    d.dept_name,
    ROUND(AVG(s.salary), 2) AS salary,
    YEAR(s.from_date) AS calendar_year
FROM
    t_salaries s
    JOIN t_employees e ON s.emp_no = e.emp_no
    JOIN t_dept_emp de ON de.emp_no = e.emp_no
    JOIN t_departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no , e.gender , calendar_year
HAVING calendar_year <= 2002
ORDER BY d.dept_no;**

Purpose

*To gain insights into the average salary distribution across departments and genders over the years, providing valuable information for understanding compensation practices and identifying any gender pay gap.*


**Task 4: Filtering Employees Based on Salary Range
Description**

*A stored procedure named filter_salary is created to dynamically filter employees based on a given salary range. This allows users to quickly analyze the average salaries of different departments for male and female employees within any specified salary range.*



**DROP PROCEDURE IF EXISTS filter_salary;***

**DELIMITER $$**
**CREATE PROCEDURE filter_salary (IN p_min_salary FLOAT, IN p_max_salary FLOAT)**
**BEGIN
    SELECT 
        e.gender, d.dept_name, AVG(s.salary) AS avg_salary
    FROM
        t_salaries s
        JOIN t_employees e ON s.emp_no = e.emp_no
        JOIN t_dept_emp de ON de.emp_no = e.emp_no
        JOIN t_departments d ON d.dept_no = de.dept_no
    WHERE s.salary BETWEEN p_min_salary AND p_max_salary
    GROUP BY d.dept_no, e.gender;
END$$**

**DELIMITER ;**
**CALL filter_salary(50000, 90000);**
**Purpose**

To provide a flexible way to analyze salary distributions based on different salary ranges, which can be used to understand compensation patterns and identify trends within specific salary bands.
Tableau Dashboard for Visualizations

In addition to the SQL queries, this project includes a Tableau dashboard that visualizes the data from each of the four tasks. The dashboard provides an interactive experience to explore employee distributions, active workforce trends, salary patterns, and gender demographics across departments. Each visualization is designed to correspond with the queries and insights derived from the SQL tasks.
How to Use the Dashboard

    Download or Access the Tableau Dashboard: The .twb file included in the repository can be opened using Tableau Desktop.
    Explore the Visualizations: Use filters and interactive elements to explore different aspects of the data, such as gender distribution by year, active employees in departments, and average salary distributions.


**How to Use This Project**

    Clone the Repository: Clone this repository to your local machine to access all SQL scripts and Tableau visualization.
    Set Up Database: Ensure that you have access to the database employees_mod and that the required tables (t_employees, t_dept_emp, t_dept_manager, t_departments, t_salaries) are properly populated.
    Execute SQL Scripts: Run the provided SQL queries to create views and stored procedures as described.
    Analyze the Data and Visualizations: Use the created views, stored procedures, and Tableau dashboard to analyze various aspects of the employee data as per your requirements.

**Conclusion**

*This project offers a comprehensive look at how to perform detailed analysis on employee data by leveraging SQL views, stored procedures, and Tableau visualizations. The queries and dashboards provide insights into gender distribution, active employee tracking by department, salary trends, and dynamic salary filtering.*
