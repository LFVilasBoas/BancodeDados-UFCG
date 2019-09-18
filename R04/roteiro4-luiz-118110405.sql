-- ALUNO: LUIZ FERNANDO SOARES VILAS BOAS - 118110405
 
--Q1
SELECT * FROM department;
--Q2
SELECT * FROM dependent;
--Q3
SELECT * FROM dept_locations;
--Q4
SELECT * FROM employee;
--Q5
SELECT * FROM project;
--Q6
SELECT * FROM works_on;
--Q7
SELECT fname, lname FROM employee WHERE sex = 'M';
--Q8
SELECT fname FROM employee WHERE (sex = 'M') AND (superssn is null);
--Q9
SELECT e.fname,s.fname FROM employee AS e,employee AS s WHERE (e.superssn is not null) AND (e.superssn = s.ssn);
--Q10
SELECT e.fname FROM employee AS e,employee AS s WHERE (e.superssn = s.ssn) AND (s.fname = 'Franklin');
--Q11
SELECT e.dname, f.dlocation FROM department AS e , dept_locations AS f WHERE (e.dnumber = f.dnumber);
--Q12
SELECT e.dname FROM department AS e , dept_locations AS f WHERE (e.dnumber= f.dnumber) AND (f.dlocation LIKE 'S%');
--Q13
SELECT e.fname, e.lname, d.dependent_name FROM employee AS e, dependent AS d WHERE (e.ssn = d.essn);
--Q14
SELECT (fname || ' ' || minit || ' '|| lname), salary FROM employee WHERE (salary > 50000); 
--Q15
SELECT p.pname, d.dname FROM project AS p, department AS d WHERE (p.dnum = dnumber); 
--Q16
SELECT p.pname, e.fname FROM project AS p, department AS d, employee AS e WHERE (p.dnum = dnumber) AND (d.mgrssn = e.ssn) AND (p.pnumber > 30); 
--Q17
SELECT p.pname, e.fname FROM project AS p, employee AS e, works_on AS w WHERE (e.ssn = w.essn ) AND (w.pno = p.pnumber); 
--Q18
SELECT e.fname, d.dependent_name, d.relationship FROM employee AS e, dependent AS d, works_on AS w WHERE (e.ssn = w.essn) AND (w.pno = 91) and (e.ssn = d.essn); 
