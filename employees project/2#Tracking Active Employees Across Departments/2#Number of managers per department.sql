#Number of managers per department 
#2.Task    
CREATE VIEW task_2_active_employees AS
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
        YEAR(hire_date)) e  -- Proper grouping by the derived column
CROSS JOIN 
    t_dept_manager dm  -- Keep this if a Cartesian product is desired
JOIN 
    t_departments d ON dm.dept_no = d.dept_no
JOIN
    t_employees ee ON dm.emp_no = ee.emp_no
ORDER BY 
    dm.emp_no, e.calendar_year;
    
SELECT * FROM employees_mod.task_2_active_employees;