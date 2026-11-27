-- Task 4 
INSERT INTO [delivery].[Sections]
(CourseId, TermId, SectionCode, Capacity, Location, DeliveryMode, Status)
SELECT CourseId,
    13,
    SectionCode,
    Capacity,
    Location,
    DeliveryMode,
    Status
FROM [delivery].[Sections]
WHERE TermId = 6;


SELECT *
FROM [delivery].[Sections]
WHERE TermId = 13;