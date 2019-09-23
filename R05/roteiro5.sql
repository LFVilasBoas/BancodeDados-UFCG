SELECT COUNT(*) FROM employee WHERE sex = 'F';

SELECT AVG(Salary) FROM employee WHERE sex = 'M' AND address LIKE '%TX';

SELECT superssn, COUNT(*) FROM employee GROUP BY superssn ORDER BY COUNT(*);

SELECT s.fname, COUNT(*) FROM (employee AS e JOIN employee AS s ON e.superssn = s.ssn) GROUP BY s.fname ORDER BY COUNT(*);

SELECT s.fname, COUNT(*) FROM (employee AS e LEFT OUTER JOIN employee AS s ON e.superssn = s.ssn) GROUP BY s.fname ORDER BY COUNT(*);

SELECT COUNT(*) FROM (SELECT COUNT(*) FROM works_on GROUP BY pno); 