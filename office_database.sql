MySQL-Employee-Database-Project/
│
├── sql/
│   └── office_database.sql
│
├── images/
│   └── (you’ll upload query output screenshots later)
│
└── README.md

DROP DATABASE IF EXISTS office;
CREATE DATABASE office;
USE office;


-- departments table
CREATE TABLE departments (
dept_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL UNIQUE,
location VARCHAR(100) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- employees table
CREATE TABLE employees (
emp_id INT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE,
dept_id INT,
manager_id INT DEFAULT NULL,
hire_date DATE NOT NULL,
salary DECIMAL(10,2) NOT NULL CHECK (salary > 0),
status ENUM('active','on_leave','terminated') DEFAULT 'active',
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT fk_emp_manager FOREIGN KEY (manager_id) REFERENCES employees(emp_id) ON DELETE SET NULL ON UPDATE CASCADE
) ;


-- indexes
CREATE INDEX idx_departments_name ON departments(name);
CREATE INDEX idx_employees_dept ON employees(dept_id);
CREATE INDEX idx_employees_last_first ON employees(last_name, first_name);
CREATE INDEX idx_employees_salary ON employees(salary);


-- notes: MySQL does not implement DEFERRABLE constraints; inserts must respect FK ordering.

-- Insert 10 departments
INSERT INTO departments (dept_id, name, location) VALUES
(1, 'Engineering', 'Hyderabad'),
(2, 'Human Resources', 'Bangalore'),
(3, 'Finance', 'Mumbai'),
(4, 'Sales', 'Delhi'),
(5, 'Marketing', 'Pune'),
(6, 'Customer Success', 'Chennai'),
(7, 'Legal', 'Hyderabad'),
(8, 'IT', 'Bangalore'),
(9, 'Operations', 'Noida'),
(10, 'Research', 'Hyderabad');


-- Insert 10 employees (emp_id chosen explicitly so manager_id can reference earlier rows)
INSERT INTO employees (emp_id, first_name, last_name, email, dept_id, manager_id, hire_date, salary, status) VALUES
(1, 'Asha', 'Reddy', 'asha.reddy@example.com', 1, NULL, '2018-03-12', 120000.00, 'active'),
(2, 'Vikram', 'Shah', 'vikram.shah@example.com', 1, 1, '2019-06-01', 95000.00, 'active'),
(3, 'Sneha', 'Kumar', 'sneha.kumar@example.com', 2, 2, '2020-01-20', 75000.00, 'on_leave'),
(4, 'Rohan', 'Patel', 'rohan.patel@example.com', 3, 1, '2017-11-05', 88000.00, 'active'),
(5, 'Priya', 'Mehta', 'priya.mehta@example.com', 4, 4, '2021-04-15', 70000.00, 'active'),
(6, 'Sameer', 'Singh', 'sameer.singh@example.com', 5, 2, '2016-09-30', 105000.00, 'active'),
(7, 'Nisha', 'Roy', 'nisha.roy@example.com', 6, 6, '2022-02-10', 65000.00, 'active'),
(8, 'Amit', 'Bose', 'amit.bose@example.com', 7, 4, '2015-12-01', 115000.00, 'active'),
(9, 'Leena', 'Iyer', 'leena.iyer@example.com', 8, 8, '2019-08-22', 72000.00, 'terminated'),
(10, 'Manish', 'Gupta', 'manish.gupta@example.com', 9, 1, '2014-05-17', 130000.00, 'active');


-- Quick sanity checks
SELECT COUNT(*) AS departments_cnt FROM departments;
SELECT COUNT(*) AS employees_cnt FROM employees;

-- 1) INNER JOIN: Show all employees along with the department they belong to.
SELECT e.emp_id, e.first_name, e.last_name, d.name AS department, d.location
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;


-- 2) LEFT JOIN: Show every employee, even if they are not assigned to any department, along with the department details if available.
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee, d.name AS department
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;


-- 3) RIGHT JOIN: Show all departments, and if a department has employees, display them too.
SELECT d.dept_id, d.name AS department, e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;


-- 4) FULL OUTER JOIN emulation (MySQL does not support FULL OUTER JOIN directly)
-- return rows that are in left join UNION rows that are in right join but not both
-- Show every department and every employee, matching them where possible.
SELECT d.dept_id, d.name AS department, e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
UNION
SELECT d.dept_id, d.name AS department, e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee
FROM departments d
RIGHT JOIN employees e ON d.dept_id = e.dept_id;


-- 5) SELF JOIN: Show every employee along with the name of their manager.
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee,
m.emp_id AS manager_id, CONCAT(m.first_name, ' ', m.last_name) AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;


-- 6) find employees earning more than their manager
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee, e.salary,
m.emp_id AS manager_id, CONCAT(m.first_name, ' ', m.last_name) AS manager, m.salary AS manager_salary
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;


-- 7) Use indexes: range on salary    Show employees whose salary falls within a specific range
SELECT emp_id, first_name, last_name, salary 
FROM employees 
WHERE salary BETWEEN 80000 AND 120000 
ORDER BY salary DESC;






