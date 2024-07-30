DESC employees;
DESC departments;
SELECT * FROM tab;
SELECT * FROM employees INNER JOIN departments USING (department_id) INNER JOIN locations USING (location_id);
SELECT * FROM employees INNER JOIN jobs USING (job_id) INNER JOIN departments USING (department_id);

SELECT 
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct, 
    employees.manager_id AS "EMP_MANAGER_ID",
    department_id,
    department_name, 
    departments.manager_id AS "DEPT_MANAGER_ID",
    location_id 
FROM employees 
INNER JOIN departments USING(department_id) 
INNER JOIN locations USING(location_id) 
WHERE locations.city = 'Seattle' 
ORDER BY employee_id;