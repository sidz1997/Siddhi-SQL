CREATE DATABASE ASSIGNMENT;
USE ASSIGNMENT;

CREATE TABLE departments (
	department_id INT (11) UNSIGNED NOT NULL,
	department_name VARCHAR(30) NOT NULL,
	manager_id INT (11) UNSIGNED,
	location_id INT (11) UNSIGNED,
	PRIMARY KEY (department_id)
	);

CREATE TABLE employees (
	employee_id INT (11) UNSIGNED NOT NULL,
	first_name VARCHAR(20),
	last_name VARCHAR(25) NOT NULL,
	email VARCHAR(25) NOT NULL,
	phone_number VARCHAR(20),
	hire_date DATE NOT NULL,
	job_id VARCHAR(10) NOT NULL,
	salary DECIMAL(8, 2) NOT NULL,
	commission_pct DECIMAL(2, 2),
	manager_id INT (11) UNSIGNED,
	department_id INT (11) UNSIGNED,
	PRIMARY KEY (employee_id)
	);    
    
-- 1. Display all information in the tables EMP and DEPT. --
SELECT * FROM EMPLOYEES;
select * from departments;

-- 2. Display only the hire date and employee name for each employee. --
  SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES;
  
-- 3. Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title -- 
SELECT concat(FIRST_NAME,',', ' ', JOB_ID) AS 'Employee and Title' FROM EMPLOYEES;

-- 4. Display the hire date, name and department number for all clerks. --
  SELECT HIRE_DATE, FIRST_NAME, JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%CLERK';
  
-- 5. Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT 
SELECT CONCAT_WS(', ', EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) AS "THE OUTPUT"
FROM EMPLOYEES;

-- 6. Display the names and salaries of all employees with a salary greater than 2000. --
SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE SALARY > 2000;

-- 7. Display the names and dates of employees with the column headers "Name" and "Start Date" -- 
SELECT FIRST_NAME AS 'NAME', HIRE_DATE AS 'START DATE' FROM EMPLOYEES; 

-- 8. Display the names and hire dates of all employees in the order they were hired. --
SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES ORDER BY HIRE_DATE;

-- 9. Display the names and salaries of all employees in reverse salary order. --
SELECT FIRST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC;

-- 10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order. --    
SELECT FIRST_NAME, DEPARTMENT_ID, COMMISSION_PCT FROM EMPLOYEES WHERE COMMISSION_PCT > 0 ORDER BY SALARY DESC;

-- 11. Display the last name and job title of all employees who do not have a manager --  
SELECT LAST_NAME, JOB_ID FROM EMPLOYEES WHERE JOB_ID NOT LIKE '%MAN';

-- 12. Display the last name, job, and salary for all employees whose job is sales representative or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000 --
SELECT LAST_NAME, JOB_ID, SALARY FROM EMPLOYEES
WHERE JOB_ID IN ('SA_REP', 'SH_CLERK') AND SALARY NOT IN (2500, 3500, 5000);
 
-- PART TWO --   
 
-- 1. Display the maximum, minimum and average salary and commission earned. --
SELECT MAX(SALARY) as MAX_SALARY, MIN(SALARY) as MIN_SALARY, AVG(SALARY) as AVG_SALARY, 
MAX(COMMISSION_PCT) as MAX_COMMISSION, MIN(COMMISSION_PCT) as MIN_COMMISSION, AVG(COMMISSION_PCT) as AVG_COMMISSION 
FROM EMPLOYEES;

-- 2. Display the department number, total salary payout and total commission payout for each department.-- 
SELECT DEPARTMENT_ID, SUM(SALARY) AS TOTAL_SALARY_PAYOUT, SUM(COMMISSION_PCT) AS TOTAL_COMMISSION_PAYOUT FROM EMPLOYEES GROUP BY DEPARTMENT_ID ORDER BY DEPARTMENT_ID;

-- 3. Display the department number and number of employees in each department. -- 
SELECT DEPARTMENT_ID, count(EMPLOYEE_ID) AS TOTAL_EMPLOYEES FROM EMPLOYEES GROUP BY DEPARTMENT_ID ORDER BY DEPARTMENT_ID;

-- 4. Display the department number and total salary of employees in each department. --
SELECT DEPARTMENT_ID, SUM(SALARY) AS TOTAL_SALARY FROM EMPLOYEES GROUP BY DEPARTMENT_ID ORDER BY DEPARTMENT_ID;

-- 5. Display the employee's name who doesn't earn a commission. Order the result set without using the column name --
 select first_name from employees where commission_pct is null order by first_name;
 
-- 6. Display the employees name, department id and commission. If an Employee doesn't earn the commission, then display as 'No commission'. Name the columns appropriately -- 
select first_name, department_id, coalesce(commission_pct, 'No commission') from employees;   

-- 7. Display the employee's name, salary and commission multiplied by 2. If an Employee doesn't earn the commission, then display as 'No commission. Name the columns appropriately -- 
select first_name, salary, coalesce(commission_pct *2, 'No commission') as twice_commission from employees;

-- 8.  Display the employee's name, department id who have the first name same as another employee in the same department --
 select e1.first_name, e1.department_id from employees e1 where e1.first_name in (select e2.first_name from employees e2 
 where e1.department_id = e2.department_id group by e2.first_name, e2.department_id having count(*) > 1);

-- 9. Display the sum of salaries of the employees working under each Manager. -- 
select sum(salary), Job_id from employees where job_id like '%MAN' group by Job_id;

-- 10. Select the Managers name, the count of employees working under and the department ID of the manager.-- 
select first_name, count(*), department_id from employees where 
job_id like '%man' and department_id in (select department_id from employees 
group by department_id having count(department_id) > 1) group by first_name, department_id;

-- 11. Display the names and job titles of all employees with the same job as Trenna. -- 
select first_name, job_id from employees where job_id =(select job_id from employees where first_name ='Trenna');

-- 12.  Display the names and department name of all employees working in the same city as Trenna. -- 
select e.first_name, d.department_name, d.location_id FROM employees e
JOIN departments d ON e.department_id = d.department_id
where d.location_id = (select d2.location_id from departments d2 join employees e2 on e2.department_id = d2.department_id 
where e2.first_name = 'Trenna');

-- 13. Display the name of the employee whose salary is the lowest. --
select first_name from employees where salary = (select min(salary) from employees);

-- 14.  Display the names of all employees except the lowest paid.--
select first_name from employees where salary not in (select min(salary) from employees);

-- Part Three --  

-- 1. Write a query that displays the employee's last names only from the string's 2-5th position with the first letter capitalized and all other letters lowercase, Give each column an appropriate label. -- 
select * from employees;
SELECT CONCAT(UPPER(SUBSTRING(last_name, 2, 1)), LOWER(SUBSTRING(last_name, 3, 4))) AS extracted_last_names FROM employees;

-- 2. Write a query that displays the employee's first name and last name along with a " in between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined. -- 
select * from employees;
select concat(first_name,'-',Last_name) as Full_name, month(hire_date) as Month_joined from employees;

-- 3. Write a query to display the employee's last name and if half of the salary is greater than ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of 1500 each. Provide each column an appropriate label. -- 
select e.Last_name, If(e.salary*0.5 >10000,e.salary*1.10+1500,e.salary*1.115+1500) as adjusted_salary from employees e;

-- 4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, department id, salary and the last name all in Upper case, if the last name consists of 'z' replace it with '$! --   
select* from employees; 
select concat(substring(employee_id,1,2),'00',substring(employee_id,3),'E') as new_id, 
department_id, salary, 
If (instr(upper(last_name),'Z')>0, replace(upper(last_name),'Z','$!'), Upper(last_name)) as last_name from employees;

-- 5. Write a query that displays the employee's last names with the first letter capitalized and all other letters lowercase, and the length of the names, for all employees whose name starts with J, A, or M. Give each column an appropriate label. Sort the results by the employees' last names --
select concat(upper(substring(last_name,1,1)), Lower(substring(last_name,2))) as Last_Name, length(last_name) as Name_length from employees
where last_name like 'J%' or last_name like 'A%' or last_name like 'M%' order by last_name;
select * from employees;

-- 6.Create a query to display the last name and salary for all employees. Format the salary to be 15 characters long, left-padded with $. Label the column SALARY  --
select last_name, concat('$', lpad(salary,15,'$')) as Salary from employees;

-- 7.Display the employee's name if it is a palindrome  --
select first_name from employees where first_name in (select first_name from employees where 
replace(lower(first_name),'  ',' ') = reverse(replace(lower(first_name),'  ',' ')));

-- 8.Display First names of all employees with initcaps.  --
select concat(upper(substring(first_name,1,1)),lower(substring(first_name,2))) as full_name from employees;

-- 9.From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column. --
select * from locations;
select substring_index(substring_index(street_address,' ',2),' ',-1) from locations;

-- 10. Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end. Name the column as e-mail address. All characters should be in lower case. Display this along with their First Name.  -- 
select * from employees;
select lower(concat(first_name, last_name,'@systechusa.com')) as email_address, first_name from employees;

-- 11. Display the names and job titles of all employees with the same job as Trenna. --
select e1.first_name, e1.job_id from employees e1 
join employees e2 on e1.job_id = e2.job_id
where e2.first_name = 'Trenna';

-- 12. Display the names and department name of all employees working in the same city as Trenna.  --
SELECT e1.first_name, d1.department_id, d1.department_name
FROM employees e1
JOIN departments d1 ON e1.department_id = d1.department_id
WHERE d1.location_id = (SELECT location_id FROM employees WHERE first_name = 'Trenna');

-- 13. Display the name of the employee whose salary is the lowest.  --
select * from employees;
select first_name from employees where salary = (select min(salary) from employees);

-- 14. Display the names of all employees except the lowest paid. --
select first_name from employees where salary <> (select min(salary) from employees); 

-- Join Functions -- 
-- 1. Write a query to display the last name, department number, department name for all employees. --      
select e.last_name, e.department_id, d.department_name from employees e
join departments d on e.department_id = d.department_id;

-- 2. Create a unique list of all jobs that are in department 40. Include the location of the department in the output. --
select distinct e.job_id, d.location_id from employees e join departments d on e.department_id = d.department_id 
where d.department_id = 40;

-- 3. Write a query to display the employee last name,department name,location id and city of all employees who earn commission -- 
select e1.employee_id, e1.last_name, d1.department_name, d1.location_id, l1.city from employees e1 join departments d1 on
d1.department_id = e1.department_id join locations l1 on d1.location_id = l1.location_id
where e1.commission_pct is not null;

-- 4.Display the employee last name and department name of all employees who have an 'a' in their last name  --
select e1.last_name, d1.department_name from employees e1 join departments d1
on e1.department_id = d1.department_id where e1.last_name like '%a%';

-- 5. Write a query to display the last name,job,department number and department name for all employees who work in Southlake. --
select * from locations;
select * from employees;
select e1.last_name, e1.job_id, e1.department_id, d1.department_name from employees e1 join departments d1 on
d1.department_id = e1.department_id join locations l1 on d1.location_id = l1.location_id
where l1.city = 'Southlake';

-- 6.Display the employee last name and employee number along with their manager's last name and manager number.  --
select e1.last_name, e1.employee_id, e1.manager_id, e2.last_name as managers_last_name from employees e1
join employees e2 on e1.manager_id = e2.employee_id;

-- 7. Display the employee last name and employee number along with their manager's last name and manager number (including the employees who have no manager). -- 
select e1.last_name, e1.employee_id, e2.last_name as Manager_last_name, e1.manager_id from employees e1
left join employees e2 on e1.manager_id = e2.employee_id;

-- 8. Create a query that displays employees last name,department number,and all the employees who work in the same department as a given employee. --
select e.last_name, e.department_id, e2.last_name as collegue_last_name from employees e join employees e2 
on e.department_id = e2.department_id where e.employee_id = 100;

-- 9. Create a query that displays the name,job,department name,salary,grade for all employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C) --
select e.first_name, e.job_id, e.department_id, e.salary, case 
when e.salary >= 5000 then 'A'
When e.salary >= 3000 then 'B'
Else 'C'
End as grade from employees e;

-- 10. Display the names and hire date for all employees who were hired before their managers along withe their manager names and hire date. Label the columns as Employee name, emp_hire_date,manager name,man_hire_date --
Select e.first_name, e.hire_date, e2.first_name as manager_name, e2.hire_date as manager_hire_date from employees e
join employees e2 on e.manager_id = e2.employee_id
where e2.hire_date < e.hire_date;   

-- HR data base questions --

-- 1. Write a query to display the last name and hire date of any employee in the same department as SALES. --
 select last_name, hire_date, job_id from employees where Job_id like '%SA%';
 
 -- 2.Create a query to display the employee numbers and last names of all employees who earn more than the average salary. Sort the results in ascending order of salary.   --
select employee_id, last_name, salary from employees where salary > (select avg(salary) from employees) order by Salary asc;

-- 3. Write a query that displays the employee numbers and last names of all employees who work in a department with any employee whose last name contains a' u --
select e.employee_id, e.last_name, d.department_id from employees e join employees d
on d.department_id = e.department_id where e.last_name like '%a%' or e.last_name like '%u%';

-- 4. Display the last name, department number, and job ID of all employees whose department location is Tokyo. -- 
select e.last_name, e.department_id, e.job_id from employees e join departments d on d.department_id = e.department_id
join locations l on d.location_id = l.location_id where l.city = 'Tokyo';

-- 5. Display the last name and salary of every employee who reports to king. --
select last_name, salary from employees where manager_id in (select employee_id from employees where last_name = 'King');

-- 6. Display the department number, last name, and job ID for every employee in the OPERATIONS department. --
select e.department_id, e.last_name, e.job_id from employees e 
join departments d on d.department_id = e.department_id where d.department_name = 'Operations'; 

-- 7. Modify the above query to display the employee numbers, last names, and salaries of all employees who earn more than the average salary and who work in a department with any employee with a 'u'in their name. --
select employee_id, last_name, salary from employees where salary > (select avg(salary) from employees) and 
department_id In (select department_id from employees where first_name like '%u%');

-- 8. Display the names of all employees whose job title is the same as anyone in the sales dept. --
 select e.first_name from employees e join jobs j on j.job_id = e.job_id where j.job_id like '%SA%';
 
-- 9. Write a compound query to produce a list of employees showing raise percentages, employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise, employees in department 2 are given a 10% raise, employees in departments 4 and 5 are given a 15% raise, and employees in department 6 are not given a raise.--
 select employee_id, salary, case salary when department_id in (1,3) then salary*1.05 
 when department_id = 2 then salary*1.10 when department_id in (4,5) then salary*1.15
 else salary end as new_salary from employees; 
 
-- 10.Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries. --
select last_name, salary from employees order by salary desc limit 3;

-- 11. Display the names of all employees with their salary and commission earned. Employees with a null commission should have O in the commission column -- 
 select first_name, salary, coalesce(commission_pct,0) as commission from employees;
 
-- 12. Display the Managers (name) with top three salaries along with their salaries and department information. --
select first_name, salary from employees where job_id like '%ma%' order by salary desc limit 3;
 
 
 -- Date Functions --
 
 -- 1.Find the date difference between the hire date and resignation_date for all the employees. Display in no. of days, months and year(1 year 3 months 5 days). --
SELECT employee_id, start_date, end_date,
    DATEDIFF(end_date, start_date) AS total_days,
    FLOOR(DATEDIFF(end_date, start_date) / 30) AS total_months,
    FLOOR(DATEDIFF(end_date, start_date) / 365) AS total_years
FROM job_history; 

-- 2. Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd, yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900)--
 SELECT employee_id, DATE_FORMAT(start_date, '%m/%d/%Y') AS formatted_hire_date,
 IFNULL(DATE_FORMAT(end_date, '%b %D, %Y'), 'DEC 01st, 1900') AS formatted_resignation_date FROM job_history;
 
 -- 3. Calcuate experience of the employee till date in Years and months(example 1 year and 3 months) -- 
SELECT employee_id, CONCAT(FLOOR(TIMESTAMPDIFF(YEAR, hire_date, NOW())), ' years ',
FLOOR(MOD(TIMESTAMPDIFF(MONTH, hire_date, NOW()), 12)), ' months') AS experience FROM employees;

-- 4.  Display the count of days in the previous quarter --
SELECT 
    DATEDIFF(
        DATE_SUB(CURDATE(), INTERVAL QUARTER(CURDATE()) - 1 QUARTER),
        DATE_SUB(CURDATE(), INTERVAL QUARTER(CURDATE()) - 2 QUARTER)
    ) AS count_of_days_in_previous_quarter;
    
    SELECT datediff(DAY, StartDate, EndDate) + 1 AS DaysInPreviousQuarter
FROM(SELECT DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0) AS StartDate,
            DATEADD(DAY, -1, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()), 0)) AS EndDate) AS PreviousQuarter;

-- 5. Fetch the previous Quarter's second week's first day's date --
SELECT DATEADD(DAY, 1, StartDateOfSecondWeek) AS FirstDayOfSecondWeek
FROM (SELECT DATEADD(WEEK, 1, StartDateOfQuarter) AS StartDateOfSecondWeek
FROM (SELECT DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0) AS StartDateOfQuarter) AS PreviousQuarter) AS SecondWeekOfPreviousQuarter;

-- 6. Fetch the financial year's 15th week's dates (Format: Mon DD YYYY) --
DECLARE @FinancialYearStart DATE = '2023-04-01';  -- Replace with your financial year start date
WITH Week15Dates AS (SELECT
        DATEADD(WEEK, 14, @FinancialYearStart) AS StartDate,
        DATEADD(DAY, 6, DATEADD(WEEK, 14, @FinancialYearStart)) AS EndDate)
SELECT
    FORMAT(StartDate, 'ddd MM dd yyyy') AS StartDateFormatted,
    FORMAT(EndDate, 'ddd MM dd yyyy') AS EndDateFormatted
FROM Week15Dates; 

-- 7. Find out the date that corresponds to the last Saturday of January, 2015 using with clause. -- 
 WITH LastSaturdayOfJanuary AS (
    SELECT
        MAX(DateColumn) AS LastSaturday
    FROM
        (SELECT
            DATEADD(DAY, 1 - DATEPART(WEEKDAY, '2015-01-01'), '2015-01-01') AS DateColumn
        UNION ALL
        SELECT
            DATEADD(DAY, 1 - DATEPART(WEEKDAY, '2015-01-02'), '2015-01-02')
        UNION ALL
        SELECT
            DATEADD(DAY, 1 - DATEPART(WEEKDAY, '2015-01-03'), '2015-01-03')
        -- Continue for the rest of the days in January
        ) AS AllJanuaryDates
    WHERE
        DATEPART(WEEKDAY, DateColumn) = 7
)
SELECT
    LastSaturday
FROM
    LastSaturdayOfJanuary;
 
-- Use Airport database for the below two question: -- 
-- 8) Find the number of days elapsed between first and last flights of a passenger. -- 
WITH FirstLastFlights AS (SELECT passenger_id, MIN(flight_date) AS first_flight_date, MAX(flight_date) AS last_flight_date
FROM flights GROUP BY passenger_id) SELECT passenger_id, DATEDIFF(DAY, first_flight_date, last_flight_date) AS days_elapsed
FROM FirstLastFlights;

-- 9. Find the total duration in minutes and in seconds of the flight from Rostov to Moscow. --
SELECT DATEDIFF(MINUTE, MIN(departure_time), MAX(arrival_time)) AS total_duration_minutes,
    DATEDIFF(SECOND, MIN(departure_time), MAX(arrival_time)) AS total_duration_seconds
FROM flights
WHERE departure_airport = 'Rostov' AND arrival_airport = 'Moscow';

-- Practice quesion from class --
 -- write a sql query to find unique designation of employees writen job name --
select * from departments;
select distinct substring(job_id, 4) from employees;     

-- Write a sql query to list the employee name increased there salary by 15% and expressed as number of dollar ($) --
select first_name, concat('$', round(salary*1.15, 2)) as new_salary from employees;

-- write sql query to find those employees with hire date in the format like febuary 22, 1991 written employee_id, employee_name, salary, and hire_date
select employee_id, first_name, salary, date_format(hire_date, "%M %d %Y") as formatted_date from employees;

-- write sql query to get employee name joined in january --
select first_name, hire_date from employees where month(hire_date) = '01';
select * from employees where extract(month from hire_date) = 1;

-- write sql query to get job_id and related employee_id --
select job_id, group_concat(employee_id) 'employee ID' from employees group by job_id;  

--  write sql query to find those employees whose salary falls in the range of smallest salary and 2500 --
select * from employees where salary between (select min(salary) from employees) and 2500;

-- write sql query to find those employees who work in the same department as Clara exclude all those record where fisrt name is clara writen first name, last name and hire date -- 
select * from employees where department_id = (select department_id from employees where first_name = 'Clara') and first_name <> 'Clara';

-- write a sql query to find those employees whose salary is less than that of employees whose job title is MK_MAN exclude employees of job_id MK_MAN --  
select * from employees;
select * from employees where salary < any (select salary from employees where job_id ='MK_MAN') and job_id <> 'MK_MAN';  

-- write a sql query to calculate total salary of the department where atleast one employee works -- 
select d.department_id, result1.total_amt
from departments d,
(select e.department_id, sum(e.salary) total_amt
from employees e
group by department_id) result1
where result1.department_id = d.department_id;

-- Write a query to get the details of the employee where the length of the first name is >=8 -- 
select * from employees;
select first_name from employees where length(first_name)>= 8;

-- Write a query that displays the first name and length of the first name for all employees whose name starts with the letters a,j,m, give each coloumn an appropriate label sort the table by employees first name --
select first_name, length(first_name) from employees having 
first_name like 'a%' or first_name like 'j%' or first_name like 'm%' order by first_name;

-- Write a query to add @gmail.com in email coloumn -- 
update employees set email = concat(email ,'@gmail.com');

-- write a query to select last four number from phone number --
select right(phone_number,4) from employees;

-- write a query to get employee ID, email id discarding the last 3 characters --
select employee_id, reverse(reverse(substring(email,1,length(email)-3))) from employees;
select employee_id, reverse(substr(reverse(email), 4)) as email_id from employees;
select * from departments;

-- write a query to get last word of department name --
select SUBSTRING_INDEX(department_name,' ',-1) from departments;
SELECT SUBSTRING_INDEX(department_name, ' ', -1) AS last_word FROM departments;

-- WRITE A QUERY TO GET MINIMUM DEPARTMENT NAME --
select min(length(department_name)) from departments;
select * from departments;
select * from employees;

-- Write a query to display the length of first name for employees where the last name cointain character c after 2nd position --
select length(first_name) from employees where last_name like '__%c%';
select length(first_name) from employees where instr(last_name,'c')>2;

-- Write a query to update the portion of the phone number in the employee table within the phone number the substring 124 replaced by 999 -- 
select * from employees;
Update employees set Phone_number = replace(Phone_number,'124','999') where Phone_number like '%124%';

-- write a query to display the first 8 characters of the employees first name and indicates the amount of there salary with $ sign each dollar sign signifies a 1,000 dollars, sort the data in desc order of salary --
select left(first_name,8), salary, repeat('$',floor(salary/1000)) as $_salary from employees order by salary;

-- write a query to display the employees with their code first_name last_name and hire_date who hired either on 7th day of any month or 7th month in any year --
select employee_id, first_name, last_name, hire_date from employees where day(hire_date) =7 or month(hire_date)=7;

-- write a query to find all the orders issued by the sales men paul adam written order_number, purch_amp, ord_date, customer_id, salesmen_id --
select * from orders where salesam_id = (select salesman_id from salesman where name ='Paul Adam');

-- From the followig tables write a sql query to find all those employees who work in department id 80 or 40, written first name, last name, department name, department_id --
select e.first_name, e.last_name, e.department_id, d.department_name from employees e
join departments d on e.department_id = d.department_id
where e.department_id in (80, 40);

-- Write a sql query to find those employees whose first name contains the letter z , written fisrt name, last name, city, department_name, state_provience --
 select e.first_name, e.last_name, l.city, l.state_province, d.department_name from employees e
 join departments d on e.department_id = d.department_id
 join locations l on d.location_id =l.location_id
 where e.first_name like '%z%';
 
 -- from the following tables, write a sql query to display department name, city, state provience for each department --
 select d.department_name, l.city,  l.state_province from departments d
 join locations l on d.location_id = l.location_id;
 
-- From the following table write a query to get employees which have or do not have the department. return first_name, last_name, department_id and department_name --
 select e.first_name, e.last_name, e.department_id, d.department_name from employees e
left join departments d on e.department_id = d.department_id;
 
 -- Write a sql query to find all departments including those without employees. return first_name, last_name, department_id and department_name --
 select e.first_name, e.last_name, e.department_id, d.department_name from employees e
 right join departments d on e.department_id = d.department_id;
 
 -- Write a sql query to find the employee who work in the same department as the employee with the last 'taylor' --
 select e.first_name, e.last_name, e.department_id from employees e
 join employees e2 on e.department_id = e2.department_id where e2.last_name = 'taylor';
 
 select first_name, last_name, department_id from employees
 where department_id = any(select department_id from employees where last_name = 'taylor');
 
 -- Write a sql query to find the employee who receives higher salary than the employer with id 163. Return first_name and last_name
 select e.first_name, e.last_name from employees e 
 where e.salary > (select e2.salary from employees e2 where e2.employee_id = 163);
 
 select * from employees;
 -- Write a sql query to find those employees whose salary matches the lowest salary of any of the departments, return first name, last name and department id --
 select e.first_name, e.last_name, e.department_id from employees e 
 where salary in (select min(salary) from employees group by department_id);
 
 -- Write a sql query to find all those employees who work in the finance department. return department_id, name, job_id and department_name --
 select e.first_name, e.job_id, e.department_id, d.department_name from employees e
 join departments d on e.department_id = d.department_id
 where d.department_name = 'finance';

-- Write a sql query to find those employees whose id matches any of the numbers 134, 159 and 183. --
select * from employees e where e.employee_id in (134, 159, 183); 

-- Write a sql query to find those employees whose salary falls within the range of the smallest salary and 2500 --
select * from employees where salary between (select min(salary) from employees) and 2500; 