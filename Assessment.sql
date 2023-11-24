CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT,
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);

INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '21-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '21-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '21-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '21-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '21-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '21-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '21-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '21-04-11 09.00.00', 'Admin');

CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT,
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '23-02-20'),
		(002, 3000, '23-06-11'),
		(003, 4000, '23-02-20'),
		(001, 4500, '23-02-20'),
		(002, 3500, '23-06-11');
        
CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2023-02-20 00:00:00'),
 (002, 'Executive', '2023-06-11 00:00:00'),
 (008, 'Executive', '2023-06-11 00:00:00'),
 (005, 'Manager', '2023-06-11 00:00:00'),
 (004, 'Asst. Manager', '2023-06-11 00:00:00'),
 (007, 'Executive', '2023-06-11 00:00:00'),
 (006, 'Lead', '2023-06-11 00:00:00'),
 (003, 'Lead', '2023-06-11 00:00:00');
 
 -- ASSIGNMENT QUESTIONS PART 1 --  
 select FIRST_NAME AS WORKER_NAME FROM WORKER;
 SELECT UPPER(FIRST_NAME) FROM WORKER;
 SELECT DISTINCT DEPARTMENT FROM WORKER;
 SELECT SUBSTRING(FIRST_NAME,1,3) FROM WORKER;
 SELECT INSTR(FIRST_NAME,'B') FROM WORKER WHERE FIRST_NAME='AMITABH';
 SELECT RTRIM(FIRST_NAME) FROM WORKER;
 SELECT ltrim(DEPARTMENT) FROM WORKER;
 SELECT distinct DEPARTMENT, length(DEPARTMENT) FROM WORKER;
 SELECT REPLACE(FIRST_NAME, 'a', 'A') FROM WORKER;
 SELECT concat(FIRST_NAME,' ', LAST_NAME) AS COMPLETE_NAME FROM WORKER;
 SELECT * FROM WORKER ORDER BY FIRST_NAME;
 SELECT * FROM WORKER ORDER BY FIRST_NAME, DEPARTMENT DESC;
 SELECT * FROM WORKER WHERE FIRST_NAME IN ('Vipul','Satish');
 SELECT * FROM WORKER WHERE FIRST_NAME not IN ('Vipul','Satish');
 SELECT * FROM WORKER WHERE DEPARTMENT='Admin';
 select * from WORKER WHERE FIRST_NAME LIKE '%a%';
 select * from WORKER WHERE FIRST_NAME LIKE '%a';
 select * from WORKER WHERE FIRST_NAME LIKE '_____h';
 select * from WORKER HAVING SALARY between 100000 AND 500000;
 SELECT * FROM WORKER WHERE YEAR(JOINING_DATE)=2021 AND mONTH(JOINING_DATE) = 02;
SELECT DEPARTMENT, COUNT(WORKER_ID) FROM WORKER where department = 'Admin';
SELECT * FROM Worker;
select concat(FIRST_NAME,' ', LAST_NAME) FROM WORKER WHERE SALARY BETWEEN 50000 AND 100000;
SELECT DEPARTMENT, count(WORKER_ID) FROM WORKER group by DEPARTMENT ORDER BY count(WORKER_ID) DESC;
SELECT * FROM WORKER ORDER BY SALARY DESC LIMIT 5;

  -- ASSIGNMENT QUESTIONS PART 2 --
create table school (std_id int, std_name varchar(20),sex varchar(20), percentage int, class int, sec varchar(20),streams varchar(20),DOB timestamp);
    insert into school(std_id, std_name, sex, percentage, class, sec, streams,DOB)
    values(1001,'surekha_joshi','female',82,12,'A','Science','1995-02-03'),
    (1002,'mahi_agrawal','female',56,11,'c','commerce','2008-11-23'),
    (1003,'sanam_verma','male',59,11,'c','commerce','2008-06-29'),
    (1004,'ronit kumar','male',63,11,'c','commerce','1997-05-11'), 
	(1005,'dipesh pulkit','male',78,11,'b','science','2003-09-14'), 
    (1006,'jahanvi puri','female',60,11,'b','commerce','2008-07-11'),
    (1007,'sanam kumar','male',23,12,'c','commerce','1997-03-03'),
	(1008,'sahil saras','male',23,11,'c','commerce','2007-07-11'),
    (1009,'Akshara agrawal','female',72,12,'c','commerce','1996-01-11'),
    (1010,'shruti misra','female',39,11,'f','science','2008-11-23'),
    (1011,'harsh agrawal','male',42,11,'c','science','1998-03-08'),
	(1012,'nikunj agrawal','male',49,12,'c','science','1998-06-28'),
	(1013,'akriti sakshena','female',89,12,'a','science','2008-11-23'),
    (1014,'tani rastogi','female',82,12,'a','science','2008-11-23');  
    
select * from school;
select std_name, DOB from school;
select std_name, DOB from school where percentage >= 80;
select std_name, streams, percentage from school where percentage > 80;
select * from school where streams = 'science' and percentage > 75;    
    