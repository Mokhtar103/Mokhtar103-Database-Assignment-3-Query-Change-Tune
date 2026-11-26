-- 3.1
CREATE SEQUENCE InvoiceNumberSequence
START WITH 1
INCREMENT BY 1;

DECLARE @InvoiceNumber VARCHAR(30);

SET @InvoiceNumber =
    'LAB-INV-2026-' +
    FORMAT(NEXT VALUE FOR InvoiceNumberSequence, '000000');

SELECT @InvoiceNumber AS InvoiceNumber;

-- 3.2
INSERT INTO [finance].[Invoices]
(InvoiceNumber, StudentId, TermId,
TotalAmount, IssuedAtUtc, DueAtUtc, PaidAmount)
VALUES (@InvoiceNumber, 174, 4,  4500,  GETUTCDATE(),
 DATEADD(DAY, 30, GETUTCDATE()), 0)

 select InvoiceNumber from finance.Invoices where StudentId = 174

 -- 3.3
BEGIN TRANSACTION;

SELECT NEXT VALUE FOR InvoiceNumberSequence AS GeneratedNumber;

ROLLBACK TRANSACTION;

SELECT NEXT VALUE FOR InvoiceNumberSequence AS NextNumber;

/* 
- suppose the sequence was 5 before executing the transaction
- after executing the operation the sequence become 6
- roll back doesn't return the 6 to the sequence,
- the next number after rolling back returns 6
-Why? Because sequence generates numbers independent of transactions,
rollback doesn't undo the sequence generation
*/