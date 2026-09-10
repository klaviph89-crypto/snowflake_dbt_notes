


---tASK
                            --
    ---  STRING ,NUMBER ,DATE FUCNTIONS -- EACH 10


select * from employees;

-- 10 STRING FUNCTIONS

SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name FROM employees;

SELECT email, LOWER(email) FROM employees;

SELECT first_name,UPPER(first_name) FROM employees;

SELECT LENGTH(first_name) FROM employees;

SELECT SUBSTRING(first_name, 1, 3) FROM employees;

SELECT TRIM('  hello world  ');

SELECT REPLACE(first_name, 'a', 'x') FROM employees;

SELECT POSITION('@' IN email) FROM employees;

SELECT LEFT(first_name, 2) FROM employees;

SELECT RIGHT(first_name, 2) FROM employees;
 
 
-- 10 NUMBER FUNCTIONS

SELECT ROUND(salary, 2) FROM employees;

SELECT CEIL(salary) FROM employees;

SELECT FLOOR(salary) FROM employees;

SELECT ABS(-150);

SELECT MOD(employee_id, 2) FROM employees;

SELECT POWER(salary, 2) FROM employees;

SELECT SQRT(salary) FROM employees;

SELECT TRUNC(salary, 0) FROM employees;

SELECT SIGN(salary) FROM employees;

SELECT UNIFORM(1, 100, RANDOM());



-- 10 DATE FUNCTIONS

SELECT CURRENT_DATE();

SELECT CURRENT_TIMESTAMP();

SELECT EXTRACT(YEAR FROM hire_date) FROM employees;

SELECT DATEADD(day, 7, CURRENT_DATE());

SELECT DATEDIFF(day, hire_date, CURRENT_DATE()) FROM employees;

SELECT DATE_TRUNC('month', hire_date) FROM employees;

SELECT DAYOFWEEK(hire_date) FROM employees;

SELECT LAST_DAY(hire_date) FROM employees;

SELECT TO_VARCHAR(hire_date, 'YYYY-MM-DD') FROM employees;

SELECT TO_DATE('2026-09-02', 'YYYY-MM-DD');

 