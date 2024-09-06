use prescriptions;

-- Problem 1
SELECT EmpID, EmpFirst, EmpLast, DOB, StartDate
FROM employee
WHERE StartDate BETWEEN "2010-06-21" AND "2010-09-22" 
	AND EndDate IS NULL
ORDER BY StartDate ASC;

-- Problem 2
SELECT h.PlanID, h.PlanName, h.City, h.State, h.ZIP
FROM healthplan h
	JOIN customer c USING (PlanID)
GROUP BY PlanID
ORDER BY PlanName;

-- Problem 3
SELECT InsuranceNumber, CompanyName
FROM customer_insurance
WHERE InsuranceNumber NOT REGEXP "[A-Z][0-9]-%";

-- Problem 4
SELECT c.CustID, c.CustFirst, c.CustLast, p.PrescriptionID, p.Date, d.DrugCode, d.Supplier
FROM customer c
		JOIN prescription p USING (CustID)
    JOIN drug d USING (DrugCode)
WHERE d.Supplier in ("Wilper Labs", "TJR Labs", "Vacer Labs")
ORDER BY d.Supplier, c.CustID;

-- Problem 5
SELECT c.CustID, c.CustLast, c.CustFirst, h.Address, h.City, h.State
FROM customer c
	JOIN household h USING (CustID)
WHERE NOT (h.Address REGEXP "Boulevard") AND (h.Address REGEXP "Road$" OR h.Address REGEXP "Rd$")
ORDER BY c.CustLast, c.CustFirst;

-- Problem 6
SELECT Supplier, AVG(TotalPrice) AS "Average Total Price"
FROM drug
GROUP BY Supplier
ORDER BY Supplier;

-- Problem 7
-- (a)
UPDATE prescriptions.prescription
SET AutoRefill = 1
WHERE PrescriptionID = 2 AND PrescriptionID = 3;

-- (b)
CREATE TABLE prescriptions_with_autorefill AS
SELECT *
FROM prescription
WHERE AutoRefill = 1;

-- Problem 8
SELECT p.PrescriptionID, p.Date, d.DrugCode, d.TotalPrice
FROM prescription p 
	JOIN drug d USING (DrugCode)
WHERE d.TotalPrice >=  
	(SELECT AVG(TotalPrice)
    FROM drug)
ORDER BY d.TotalPrice;

-- Problem 9
SELECT c.CustID, c.CustFirst, c.CustLast, SUM(d.TotalPrice) AS SumTotalPrice
FROM customer c
		JOIN prescription p USING (CustID)
	JOIN drug d USING (DrugCode)
GROUP BY c.CustID
HAVING SUM(d.TotalPrice) >= 150
ORDER BY SUM(d.TotalPrice) DESC;