-- Q1
SELECT COUNT(*) FROM employee WHERE sex = 'F';

-- Q2
SELECT AVG(Salary) FROM employee WHERE sex = 'M' AND address LIKE '%TX';

-- Q3
SELECT superssn, COUNT(*) FROM employee GROUP BY superssn ORDER BY COUNT(*);

-- Q4
SELECT s.fname, COUNT(*) FROM (employee AS e JOIN employee AS s ON e.superssn = s.ssn) GROUP BY s.fname ORDER BY COUNT(*);

-- Q5
SELECT s.fname, COUNT(*) FROM (employee AS e LEFT OUTER JOIN employee AS s ON e.superssn = s.ssn) GROUP BY s.fname ORDER BY COUNT(*);

-- Q6
SELECT MIN(num.COUNT) AS minimo FROM (SELECT COUNT(*) FROM works_on GROUP BY pno) AS num; 

-- Q7


-- Q8
SELECT p.pnumber AS num_proj, AVG(E.salary) FROM project AS p JOIN works_on AS w ON (pnumber = pno) JOIN employee AS e ON (e.ssn = w.essn) GROUP BY num_proj ORDER BY num_proj;

-- Q9
SELECT p.pnumber AS num_proj, p.pname, AVG(E.salary) FROM project AS p JOIN works_on AS w ON (pnumber = pno) JOIN employee AS e ON (e.ssn = w.essn) GROUP BY num_proj ORDER BY num_proj;

--  Q10
SELECT e.fname, e.salary FROM employee AS e WHERE e.salary > ALL (SELECT f.salary FROM works_on AS w JOIN employee AS f ON (f.ssn = w.essn) WHERE W.PNO = 92);

-- Q11
SELECT e.ssn, COUNT(*) AS qtd_proj FROM employee e FULL OUTER JOIN works_on w ON e.ssn = w.essn GROUP BY e.ssn ORDER BY qtd_proj;

--Q12
SELECT w.pno, COUNT(*) AS qtd_func FROM employee e FULL OUTER JOIN works_on w ON e.ssn = w.essn GROUP BY w.pno ORDER BY qtd_func;