-- DELIVERABLE 1
-- Create merged table containing data from employees and titles column with birthdays between 1952 and 1955 and sort by employee number

SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- New table containing unique employee numbers to get most recent title.
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no;

-- Retrieve number of employees by their most recent job title who are about to retire
SELECT COUNT(emp_no),title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- DELIVERABLE 2
-- create merged table containing employees whos birthday in 1965 are current employees and are eligible for mentorship into new roles
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, d.from_date, d.to_date, t.title
INTO mentorship_eligibilty
FROM employees AS e
JOIN dept_emp AS d
ON e.emp_no = d.emp_no
JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (t.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;