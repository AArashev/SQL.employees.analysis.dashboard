#A breakdown between male and female employees created as VIEW
use employees_mod;
CREATE VIEW task_1_employee_count AS
# 1.Task
select
	YEAR(d.from_date) AS calendar_year,
    e.gender,
    COUNT(e.emp_no) as number_of_employees
    from 
    t_employees e 
    JOIN 
    t_dept_emp d ON d.emp_no = e.emp_no
    GROUP BY calendar_year, e.gender
    HAVING calendar_year >=1990;
    
    SELECT * FROM employees_mod.task_1_employee_count;