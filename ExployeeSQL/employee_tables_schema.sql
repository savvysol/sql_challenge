-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/TeZL75
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" varchar(4)   NOT NULL,
    "dept_name" varchar(55)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(4)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(4)   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(55)   NOT NULL,
    "last_name" varchar(55)   NOT NULL,
    "gender" varchar(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" float   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" int   NOT NULL,
    "title" varchar(55)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


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
SELECT * FROM employee_departments WHERE dept_name = 'Sales'
	ORDER BY last_name, first_name

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT * FROM employee_departments WHERE dept_name = 'Sales' OR dept_name = 'Development'
	ORDER BY dept_name, last_name, first_name

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, count(last_name) FROM employees
	GROUP BY last_name
	ORDER BY last_name DESC

