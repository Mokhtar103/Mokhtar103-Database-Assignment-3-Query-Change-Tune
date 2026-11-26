-- Task 9

-- a column that has no index
SET STATISTICS IO ON;

SELECT DISTINCT ActionCode
FROM operations.AuditLogs;

SET STATISTICS IO OFF;

-- DISTINCT on a unique column
SET STATISTICS IO ON;

SELECT DISTINCT Id
FROM operations.AuditLogs;

SET STATISTICS IO OFF;
