
-- 1.1
SELECT StudentId,
	   TotalAmount,
	   PaidAmount,
	   (TotalAmount - PaidAmount) AS AmountLeft,
	   DATEDIFF(DAY, DueAtUtc, GETUTCDATE()) AS DaysLate
INTO #OverdueInvoices
FROM [finance].[Invoices]
WHERE DueAtUtc < GETUTCDATE()
	AND PaidAmount < TotalAmount;

SELECT * FROM #OverdueInvoices

-- 1.2
SELECT StudentId,
	   AmountLeft,
	   DaysLate,
	   CASE
        WHEN DaysLate > 60 OR AmountLeft > 10000 THEN 'Urgent'
        WHEN DaysLate > 30 THEN 'Medium'
        ELSE 'Low'
    END AS Priority
FROM #OverdueInvoices

-- 1.3

SELECT StudentId,
	   AmountLeft,
	   DaysLate,
	   CASE
        WHEN DaysLate > 60 OR AmountLeft > 10000 THEN 'Urgent'
        WHEN DaysLate > 30 THEN 'Medium'
        ELSE 'Low'
    END AS Priority
FROM #OverdueInvoices
ORDER BY CASE
        WHEN DaysLate > 60 OR AmountLeft > 10000 THEN 1
        WHEN DaysLate > 30 THEN 2
        ELSE 3
		 END,
		AmountLeft DESC