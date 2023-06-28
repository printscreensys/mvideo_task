-- 1. Вывести список сотрудников, получающих заработную плату большую чем у непосредственного руководителя
SELECT * 
FROM Employee e, Employee c
WHERE c.id = e.chief_id AND e.salary > c.salary;

-- 2. Вывести список сотрудников, получающих максимальную заработную плату в своем отделе
SELECT * 
FROM Employee e
WHERE e.salary = (SELECT MAX(salary) FROM Employee AS max WHERE max.department_id = e.department_id);

-- 3. Вывести список ID отделов, количество сотрудников в которых не превышает 3 человек
SELECT department_id 
FROM Employee
GROUP BY department_id
HAVING COUNT(*) <= 3;

--4. Вывести список сотрудников, не имеющих назначенного руководителя, работающего в том-же отделе
SELECT * 
FROM Employee e
LEFT JOIN Employee c ON (e.chief_id = c.Id AND e.department_id = c.department_id)
WHERE c.id IS NULL;

--5. Найти список ID отделов с максимальной суммарной зарплатой сотрудников
WITH t AS 
	(SELECT department_id, sum(salary) AS salary
	FROM employee 
	GROUP BY department_id)
SELECT department_id
FROM t
WHERE t.salary = (SELECT max(salary) FROM t);
