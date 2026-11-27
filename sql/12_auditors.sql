-- 12.1

CREATE TABLE operations.PassMarkHistory
(
	CourseId int,
	Title NVARCHAR(200),
	OldPassMark DECIMAL(5,2),
    NewPassMark DECIMAL(5,2),
    ChangedAt DATETIME2,
    ChangedBy NVARCHAR(128)
)

UPDATE c
SET PassingScore = 65
OUTPUT
    INSERTED.Id,
	INSERTED.Title,
    DELETED.PassingScore,
    INSERTED.PassingScore,
    SYSUTCDATETIME(),
    SUSER_SNAME()
INTO operations.PassMarkHistory
(
    CourseId,
	Title,
    OldPassMark,
    NewPassMark,
    ChangedAt,
    ChangedBy
)
FROM [academic].[Courses] c
WHERE c.DepartmentId = 1;

SELECT *
FROM operations.PassMarkHistory

-- 12.2
CREATE TABLE dbo.AnnouncementsArchive
(
    Id BIGINT,
	SectionId BIGINT,
    Title NVARCHAR(200),
    Body NVARCHAR(MAX),
	PublishedAtUtc DATETIME2,
	ExpiredAtUtc DATETIME2,
	Status tinyint
);

DELETE FROM [communication].[Announcements]
OUTPUT
	DELETED.Id
