SHOW DATABASES;
USE employeesalary;
SHOW tables;

/* 1 SELECT ALL MANAGERS THAT STAYS IN TEXAS*/;
SELECT Manager FROM employeesalary.`employees managers` 
WHERE STATE REGEXP 'TX';

/* 2 HOW MANY MANAGERS ARE THERE IN EACH STATE */;
SELECT STATE, COUNT(*) AS 'numberOfEmployees' FROM employeesalary.`employees managers`
GROUP BY STATE;

/* 3 WHAT IS THE TOTAL OF SALARY RECEIVED */
SELECT SUM(replace(Salary, '$', '')) AS 'total salary' FROM employeesalary.`employees salary`;

/* 4 What is the second miximum salary */
SELECT MAX(Salary) AS 'secondMaxSalary' FROM employeesalary.`employees salary`
WHERE Salary < (SELECT MAX(Salary) FROM employeesalary.`employees salary`);

/* 5 Who are the managers that are earning more than 50 000*/
UPDATE employeesalary.`employees salary` SET  
Salary = REPLACE(Salary,'$', '') WHERE Salary LIKE '$%';

SELECT Manager AS 'managers', Salary AS 'salaries' FROM employeesalary.`employees managers` 
JOIN employeesalary.`employees salary` ON `employees managers`.`Employee ID` = `employees salary`.`Employee ID` 
WHERE Salary > '50000';

/* 6 How many managers that are earning less than 50000 */
SELECT COUNT(Manager) FROM employeesalary.`employees managers`
JOIN employeesalary.`employees salary` ON `employees managers`.`Employee ID` = `employees salary`.`Employee ID`
WHERE Salary < '50000';

/* 7 Show the projects that have been done in Washington DC */
SELECT Projects AS 'projects', STATE AS 'state' FROM employeesalary.`employees salary`
JOIN employeesalary.`employees managers` ON `employees salary`.`Employee ID` = `employees managers`.`Employee ID`
WHERE STATE = 'WA';

/* 8 What is the average salary from each state */
SELECT STATE, ROUND(avg(Salary), 2) AS 'avgSalary' FROM employeesalary.`employees salary`
JOIN employeesalary.`employees managers` ON `employees salary`.`Employee ID` = `employees managers`.`Employee ID`
GROUP BY STATE;

/* 9 Which employee has the lowest salary */
SELECT Manager AS 'Manager', Salary AS minSalary FROM employeesalary.`employees managers`
JOIN employeesalary.`employees salary` ON `employees managers`.`Employee ID` = `employees salary`.`Employee ID`
ORDER BY Salary ASC LIMIT 1;

/* 10 How many halftime versus fulltime employees are there? */
SELECT COUNT(Status) FROM employeesalary.`employees status`
WHERE Status = 'Full Time' & 'Half-Time';

/* 11 What is the median salary of all the employees */
SELECT MAX(Salary) AS "Median"
FROM (
 SELECT Salary,
 NTILE(4) OVER(ORDER BY Salary) AS Quartile
 FROM employeesalary.`employees salary` 
) employeesalary
WHERE Quartile = 2;

/* 12 mention all the States and their highest paid managers and their salary */
SELECT STATE, Manager, max(Salary) AS 'salaries' FROM employeesalary.`employees managers`
JOIN employeesalary.`employees salary` ON `employees managers`.`Employee ID` = `employees salary`.`Employee ID`
GROUP BY STATE, Manager;

/* 13 How many salaries that are duplicated */
SELECT Salary, COUNT(Salary) AS duplicatedSalary FROM employeesalary.`employees salary` 
GROUP BY Salary 
HAVING COUNT(Salary) > 1;

/* 14 How many employees are there in status category */
SELECT Status, COUNT(status) AS employeeNumber FROM employeesalary.`employees status`
GROUP BY status;

/* 15 Who are the employees that did not receive bonuses */
SELECT Manager FROM employeesalary.`employees managers`
JOIN employeesalary.`employees salary` ON `employees managers`.`Employee ID` = `employees salary`.`Employee ID`
WHERE Bonus IS NULL;

/* 16 Show all employees whose bonuses are between 10 to 50% */
SELECT manager FROM employeesalary.`employees managers`
JOIN employeesalary.`employees salary` ON `employees managers`.`Employee ID` = `employees salary`.`Employee ID`
WHERE bonus BETWEEN 12 AND 20;

/* 17 Who is the manager that gets the highest bonus */
SELECT Manager FROM employeesalary.`employees managers`
JOIN employeesalary.`employees salary` ON `employees managers`.`Employee ID` = `employees salary`.`Employee ID`
ORDER BY bonus DESC LIMIT 1;

/* 18  Mention 5 contract employees who have the highest bonuses*/
SELECT manager, status FROM employeesalary.`employees managers`
JOIN employeesalary.`employees salary` ON `employees managers`.`Employee ID` = `employees salary`.`Employee ID`
JOIN employeesalary.`employees status` ON `employees salary`.`Employee ID` = `employees status`.`Employee ID` 
WHERE status = 'contract' 
ORDER BY bonus DESC LIMIT 5;



