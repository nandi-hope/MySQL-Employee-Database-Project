# 🧮 MySQL Employee Database Project

## 🧠 Project Overview
This project demonstrates advanced **MySQL concepts** using a realistic employee–department relational database.  
It focuses on **constraints, joins, and indexes** — key components of efficient relational database design.

---

## 🧰 Tools & Technologies
| Tool | Purpose |
|------|----------|
| **MySQL** | Database creation, querying, and optimization |
| **Workbench / CLI** | Query execution and schema visualization |
| **GitHub** | Version control & portfolio documentation |

---

## 🧩 Database Schema Overview

**Database Name:** `office`

### Tables:
1. **departments**
   - Fields: dept_id, name, location, created_at  
   - Constraints: `PRIMARY KEY`, `UNIQUE`, `NOT NULL`
2. **employees**
   - Fields: emp_id, first_name, last_name, email, dept_id, manager_id, hire_date, salary, status  
   - Constraints: `PRIMARY KEY`, `CHECK (salary > 0)`, `FOREIGN KEY` relationships to departments and employees  
   - Uses **ENUM** and **DEFAULT** values for business logic.

---

## ⚙️ SQL Features Implemented

### 1️⃣ Constraints
- `PRIMARY KEY`, `UNIQUE`, `CHECK`, `DEFAULT`, and `ENUM`
- **Foreign Key Cascades** (`ON DELETE SET NULL`, `ON UPDATE CASCADE`)
- Ensures referential integrity and data validity

### 2️⃣ Indexes
- `idx_departments_name` — speeds up department name lookups  
- `idx_employees_dept` — optimizes department-level joins  
- `idx_employees_last_first` — improves search by employee name  
- `idx_employees_salary` — accelerates range queries on salary

### 3️⃣ Joins
Includes practical examples of all major joins:
- **INNER JOIN** – employees with department details  
- **LEFT JOIN** – all employees, even without departments  
- **RIGHT JOIN** – all departments, with employees if any  
- **FULL OUTER JOIN (via UNION)** – simulated using UNION  
- **SELF JOIN** – employees with their managers  
- **JOIN with condition** – employees earning more than their managers  

---

## 🧮 Example Queries

### 🔹 INNER JOIN — Employees and their Departments
```sql
SELECT e.emp_id, e.first_name, e.last_name, d.name AS department, d.location
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;
```
✅ Output:

### 🔹 LEFT JOIN — Show every employee, even if they are not assigned to any department, along with the department details if available.
```sql
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee, d.name AS department
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;
```
✅ Output:
### 🔹 RIGHT JOIN — Show all departments, and if a department has employees, display them too.
```sql
SELECT d.dept_id, d.name AS department, e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;
```
✅ Output:
### 🔹 FULL OUTER JOIN — emulation (MySQL does not support FULL OUTER JOIN directly)
### Show every department and every employee, matching them where possible.
-- return rows that are in left join UNION rows that are in right join but not both
```sql
SELECT d.dept_id, d.name AS department, e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
UNION
SELECT d.dept_id, d.name AS department, e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee
FROM departments d
RIGHT JOIN employees e ON d.dept_id = e.dept_id;
```
✅ Output:

### 🔹 SELF JOIN — Employees and their Managers
```sql
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee,
m.emp_id AS manager_id, CONCAT(m.first_name, ' ', m.last_name) AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;
```
✅ Output:

### 🔹indexes — Show employees whose salary falls within a specific range
```sql
SELECT emp_id, first_name, last_name, salary 
FROM employees 
WHERE salary BETWEEN 80000 AND 120000 
ORDER BY salary DESC;
```
✅ Output:

## 📊 Project Highlights

✅ Enforces data integrity via constraints

⚡ Achieves query optimization using indexes

🔁 Demonstrates all major SQL joins

🧩 Implements self-referencing relationships for hierarchical data

📈 Designed for scalability and performance

## 📚 Key Learnings

Strong understanding of relational data modeling

Importance of constraints and indexing in query optimization

Practical use of JOINs in multi-table queries

Writing clean, reusable SQL scripts for real-world data design

## ▶ How to Reproduce

Copy office_database.sql

Open MySQL Workbench or CLI

Run the script step by step

Execute JOIN and INDEX queries for analysis

## 📎 Repository Link

GitHub Repo: MySQL Employee Database Project

## 🧑‍💻 Author
**Nandini Jella**

## 🧩 Connect With Me
- 🔗 [LinkedIn](https://linkedin.com/in/nandini-jella-a8262b1a0)  
- 📧 Email: nandinijella0095@gmail.com
- 📂 [My Portfolio](https://github.com/nandi-hope)

