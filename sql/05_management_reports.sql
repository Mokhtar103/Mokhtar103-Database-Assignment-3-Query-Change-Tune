-- 5.1
SELECT Code AS Course_Code,
	   Title AS Course_Title,
	   CreditHours
FROM [academic].[Courses]
ORDER BY CreditHours DESC, Course_Title ASC;

-- 5.2
SELECT TOP 5 StudentNumber,
			UserId 
FROM [identity].[StudentProfiles]
ORDER BY NEWID();

-- 5.3
SELECT FirstName,
	LastName,
	Email
FROM [identity].[Users]
WHERE Email LIKE ' %'
   OR Email LIKE '% ';

-- 5.4 
SELECT Email
FROM [identity].[Users]
WHERE Email <> LOWER(Email)

-- 5.5
SELECT Email
FROM [identity].[Users]
WHERE Email NOT LIKE '%@%'
OR Email LIKE '@%'
OR Email NOT LIKE '%@%.%';

-- 5.6
SELECT DISTINCT
	SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) AS EmailProvider
FROM [identity].[Users]
WHERE Email LIKE '%@%'
ORDER BY EmailProvider ASC

-- 5.7
SELECT Id,
	FirstName,
	LastName,
	LastLoginAtUtc
FROM [identity].[Users]
ORDER BY 
	CASE 
		WHEN LastLoginAtUtc IS NULL THEN 2
		ELSE 1
	END,
LastLoginAtUtc DESC;

-- 5.8
SELECT Id,
	   Amount,
	   PaidAtUtc
FROM [finance].[Payments]
WHERE PaidAtUtc >= '2026-10-01'
	AND PaidAtUtc < '2026-11-01';

-- 5.9
SELECT
    Id,
	Amount,
	PaidAtUtc,
    CAST(
        (PaidAtUtc AT TIME ZONE 'UTC')
        AT TIME ZONE 'Egypt Standard Time'
        AS TIME
    ) AS CairoPaymentTime
FROM [finance].[Payments]
WHERE CAST(
    (PaidAtUtc AT TIME ZONE 'UTC')
    AT TIME ZONE 'Egypt Standard Time'
    AS TIME
) >= '00:00:00'
AND CAST(
    (PaidAtUtc AT TIME ZONE 'UTC')
    AT TIME ZONE 'Egypt Standard Time'
    AS TIME
) < '05:00:00';

-- 5.10
SELECT Id,
	SessionDate,
	Topic
FROM [attendance].[AttendanceSessions]
WHERE DATENAME(WEEKDAY, SessionDate) = 'Friday';

-- 5.11
SELECT PhoneNumber
FROM [identity].[Users]
WHERE PhoneNumber LIKE '+201[0125][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'

-- 5.12
SELECT
    LEFT(PhoneNumber, 3)
    + REPLICATE('*', LEN(PhoneNumber) - 5)
    + RIGHT(PhoneNumber, 2) AS HiddenPhoneNumber
FROM [identity].[Users];

-- 5.13
SELECT
    InvoiceNumber,
    CASE
        WHEN InvoiceNumber LIKE '%-%'
        THEN TRY_CAST(
            RIGHT(
                InvoiceNumber,
                CHARINDEX('-', REVERSE(InvoiceNumber)) - 1
            ) AS INT
        )
    END AS RunningNumber
FROM [finance].[Invoices]
ORDER BY RunningNumber;

-- 5.14
SELECT
    CASE
        WHEN EstimatedMinutes IS NULL THEN 'Not set'
        ELSE
            CAST(EstimatedMinutes / 60 AS VARCHAR(10))
            + ' h '
            + CAST(EstimatedMinutes % 60 AS VARCHAR(10))
            + ' min'
    END AS LessonLength
FROM [content].[Lessons];

-- 5.15
SELECT Title,
	   Body
FROM [communication].[Announcements]
WHERE Title LIKE '%[%]%'
	OR Body LIKE '%[%]%'

-- 5.16
SELECT TOP 5 WITH TIES
		Id
		InvoiceNumber,
		TotalAmount
FROM [finance].[Invoices]
ORDER BY TotalAmount DESC

-- 5.17
SELECT TOP 10 PERCENT
		Id
		InvoiceNumber,
		PaidAmount
FROM [finance].[Invoices]
ORDER BY PaidAmount DESC

-- 5.18
SELECT Id, SectionCode, Capacity, Location
FROM [delivery].[Sections]
WHERE Location <> 'HALL A'
	OR Location IS NULL

-- 5.19
SELECT Id,
	InvoiceNumber,
	TotalAmount,
	PaidAmount,
	DueAtUtc,
	(TotalAmount - PaidAmount) as RemainingAmount,
		CASE
			WHEN PaidAmount = 0 THEN 'Not Paid'
			ELSE 'Partially Paid'
		END AS PaymentStatus,
		CASE
			WHEN GETUTCDATE() > DueAtUtc THEN 'OverDue'
			ELSE 'Not OverDue'
		END AS OverdueStatus,
		 CAST(
        ROUND(
            PaidAmount * 100.0 / NULLIF(TotalAmount, 0),
            1
        ) AS DECIMAL(5,1)
    ) AS PercentagePaid
FROM [finance].[Invoices]
WHERE TotalAmount > PaidAmount
ORDER BY RemainingAmount Desc

-- 5.20
SELECT Id, FirstName, LastName, Email, CreatedAtUtc
FROM [identity].[Users]
ORDER BY CreatedAtUtc DESC
OFFSET 40 ROWS
FETCH NEXT 20 ROWS ONLY;

-- 5.21
SELECT TOP 50 Id, EntityName
FROM [operations].[AuditLogs]
WHERE Id > 150
ORDER BY Id ASC;

-- 5.22
SELECT TOP 10 *
FROM [finance].[Payments]
Order by PaidAtUtc DESC;