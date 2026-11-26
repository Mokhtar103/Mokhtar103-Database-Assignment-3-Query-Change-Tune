-- 2.1
INSERT INTO [academic].[Departments] (Code, Name)
VALUES ('DSAI', 'Data Science & Artificial Intelligence')

-- 2.2
INSERT INTO [academic].[Courses]
(DepartmentId, Code, Title, CreditHours, PassingScore)
VALUES (18, 'DSAI-101', ' Introduction to Data Analysis', 3, 60)

-- 2.3
INSERT INTO [delivery].[AcademicTerms]
(AcademicYear, TermCode, Name, StartDate, EndDate,
RegistrationStartDate, RegistrationEndDate)
VALUES (2027, 'SUMMER', 'Summer 2027', '2027-06-15', '2027-08-31',
	'2027-05-01', '2027-06-10')

-- 2.4
INSERT INTO [communication].[Announcements]
(Title, Body, PublishedAtUtc, ExpiresAtUtc, CreatedByUserId)
VALUES ('Summer 2027 Registration',
'Summer 2027 registration opens on 1 May 2027',
GETUTCDATE(),
'2027-06-10',
1)

-- 2.5
INSERT INTO [identity].[Roles] (Code, Name)
VALUES ('TEACHING_ASSISTANT', 'Teaching Assistant')