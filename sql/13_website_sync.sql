-- Task 13

CREATE TABLE dbo.WebsiteCourseCatalog
(
    CourseId INT PRIMARY KEY,
    CourseCode VARCHAR(20),
    Title NVARCHAR(200),
    Credits INT,
    IsVisible BIT NOT NULL DEFAULT 1
);

MERGE dbo.WebsiteCourseCatalog AS t
USING
(
    SELECT Id AS CourseId, Code, Title, CreditHours
    FROM [academic].[Courses]
    WHERE IsActive = 1
) AS source
ON t.CourseId = source.CourseId

-- Update existing courses if their details changed
WHEN MATCHED AND
(
    t.CourseCode <> source.Code
    OR t.Title <> source.Title
    OR t.Credits <> source.CreditHours
    OR t.IsVisible = 0
)
THEN
    UPDATE SET
        t.CourseCode = source.Code,
        t.Title = source.Title,
        t.Credits = source.CreditHours,
        t.IsVisible = 1

-- Insert new active courses
WHEN NOT MATCHED BY TARGET
THEN
    INSERT (CourseId, CourseCode, Title, Credits, IsVisible)
    VALUES (source.CourseId, source.Code,
            source.Title, source.CreditHours, 1)

-- Hide courses that are no longer active
WHEN NOT MATCHED BY SOURCE AND t.IsVisible = 1
THEN
    UPDATE SET t.IsVisible = 0

-- Show what changed
OUTPUT
    $action AS Action,
    COALESCE(INSERTED.CourseId, DELETED.CourseId) AS CourseId,
    DELETED.CourseCode AS OldCode,
    INSERTED.CourseCode AS NewCode,
    DELETED.Title AS OldTitle,
    INSERTED.Title AS NewTitle,
    DELETED.IsVisible AS OldVisibility,
    INSERTED.IsVisible AS NewVisibility;

-- Rename one course
UPDATE [academic].[Courses]
SET Title = 'Computer Architecture'
WHERE Code = 'CS109';

-- Deactivate another course
UPDATE [academic].[Courses]
SET IsActive = 0
WHERE Code = 'CS108'