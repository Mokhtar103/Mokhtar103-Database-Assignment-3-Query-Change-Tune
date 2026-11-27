-- 11.1
UPDATE [academic].[Courses]
SET PassingScore = 65
WHERE CODE LIKE 'DSAI%'

-- 11.2
SELECT StudentId,
	   EnrollmentStatusId,
	   FinalScore,
	   CompletedAtUtc,
	   CASE
	   WHEN FinalScore >= 90 THEN 'A'
	   WHEN FinalScore >= 80 THEN 'B'
	   WHEN FinalScore >= 70 THEN 'C'
	   WHEN FinalScore >= 60 THEN 'D'
	   ELSE 'F'
	   END AS Grade
FROM [delivery].[Enrollments]
WHERE CompletedAtUtc IS NOT NULL

-- 11.3 
DELETE FROM [identity].[Roles]
WHERE Name = 'Teaching Assistant'

-- 11.4
CREATE TABLE finance.PaymentStaging
(
    PaymentId INT,
    InvoiceId INT,
    Amount DECIMAL(18,2),
    PaidAtUtc DATETIME2
);

INSERT INTO finance.PaymentStaging
(PaymentId, InvoiceId, Amount, PaidAtUtc)
VALUES
	 (1, 101, 250.00, SYSUTCDATETIME()),
     (2, 102, 500.00, SYSUTCDATETIME()),
     (3, 103, 750.00, SYSUTCDATETIME());

TRUNCATE TABLE finance.PaymentStaging

-- 11.5
DROP TABLE IF EXISTS finance.PaymentStaging;