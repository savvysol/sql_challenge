
-- #### Data Analysis
-- Once you have a complete database, do the following:

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
CREATE VIEW employee_view AS
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary FROM employees as e
	JOIN salaries as s on (s.emp_no=e.emp_no)
	ORDER BY e.last_name;
SELECT * FROM employee_view

-- 2. List employees who were hired in 1986.
SELECT e.emp_no, e.last_name, e.first_name, e.hire_date FROM employees as e
	WHERE EXTRACT(YEAR FROM hire_date) = 1986 
	ORDER BY hire_date

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
CREATE VIEW department_managers AS
SELECT d.dept_no,d.dept_name, m.emp_no,e.last_name,e.first_name,m.from_date,m.to_date
	FROM employees AS e
	JOIN dept_manager AS m ON (e.emp_no = m.emp_no)
	JOIN departments AS d ON (d.dept_no = m.dept_no)
	ORDER BY dept_no, from_date, last_name;
SELECT * FROM department_managers;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
CREATE VIEW employee_departments AS
SELECT e.emp_no,e.last_name,e.first_name,d.dept_name
	FROM employees AS e
	JOIN dept_emp AS de ON (e.emp_no = de.emp_no)
	JOIN departments AS d ON (d.dept_no = de.dept_no)
	ORDER BY dept_name, last_name;
SELECT * FROM employee_departments;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
-- Using the VIEW created for question #3
SELECT * FROM employee_departments WHERE dept_name = 'Sales'
	ORDER BY last_name, first_name

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
-- Using the VIEW created for question #3
SELECT * FROM employee_departments WHERE dept_name = 'Sales' OR dept_name = 'Development'
	ORDER BY dept_name, last_name, first_name

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, count(last_name) FROM employees
	GROUP BY last_name
	ORDER BY last_name DESC

