USE ec_college_dwh;
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'prelim_science_marks' AND schema_id = SCHEMA_ID('silver'))
BEGIN
    CREATE TABLE silver.prelim_science_marks (
        student_id                  VARCHAR(20)   NOT NULL,
        student_name                VARCHAR(100)  NOT NULL,
        grade                       VARCHAR(10)   NOT NULL,
        mathematics_mark            INT           NULL,
        physical_science_mark       INT           NULL,
        life_sciences_mark          INT           NULL,
        english_home_language_mark  INT           NULL,
        life_orientation_mark       INT           NULL,
        information_technology_mark INT           NULL,
        agricultural_science_mark   INT           NULL,
        total_mark                  INT           NULL,
        average_mark                DECIMAL(5,2)  NULL,
        dwh_load_date               DATETIME2     NOT NULL DEFAULT SYSDATETIME()
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'prelim_science_grade10' AND schema_id = SCHEMA_ID('silver'))
BEGIN
    CREATE TABLE silver.prelim_science_grade10 (
        student_id                  VARCHAR(20)   NOT NULL,
        student_name                VARCHAR(100)  NOT NULL,
        grade                       VARCHAR(10)   NOT NULL,
        grade_band                  VARCHAR(5)    NOT NULL,
        mathematics_mark            INT           NULL,
        physical_science_mark       INT           NULL,
        life_sciences_mark          INT           NULL,
        english_home_language_mark  INT           NULL,
        life_orientation_mark       INT           NULL,
        information_technology_mark INT           NULL,
        agricultural_science_mark   INT           NULL,
        subjects_failed             INT           NOT NULL,
        overall_result              VARCHAR(4)    NOT NULL,
        dwh_load_date               DATETIME2     NOT NULL DEFAULT SYSDATETIME()
    );
END
GO
-- Repeat identically for grade11 and grade12 (just change the table name)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'prelim_science_grade11' AND schema_id = SCHEMA_ID('silver'))
BEGIN
    CREATE TABLE silver.prelim_science_grade11 (
        student_id                  VARCHAR(20)   NOT NULL,
        student_name                VARCHAR(100)  NOT NULL,
        grade                       VARCHAR(10)   NOT NULL,
        grade_band                  VARCHAR(5)    NOT NULL,
        mathematics_mark            INT           NULL,
        physical_science_mark       INT           NULL,
        life_sciences_mark          INT           NULL,
        english_home_language_mark  INT           NULL,
        life_orientation_mark       INT           NULL,
        information_technology_mark INT           NULL,
        agricultural_science_mark   INT           NULL,
        subjects_failed             INT           NOT NULL,
        overall_result              VARCHAR(4)    NOT NULL,
        dwh_load_date               DATETIME2     NOT NULL DEFAULT SYSDATETIME()
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'prelim_science_grade12' AND schema_id = SCHEMA_ID('silver'))
BEGIN
    CREATE TABLE silver.prelim_science_grade12 (
        student_id                  VARCHAR(20)   NOT NULL,
        student_name                VARCHAR(100)  NOT NULL,
        grade                       VARCHAR(10)   NOT NULL,
        grade_band                  VARCHAR(5)    NOT NULL,
        mathematics_mark            INT           NULL,
        physical_science_mark       INT           NULL,
        life_sciences_mark          INT           NULL,
        english_home_language_mark  INT           NULL,
        life_orientation_mark       INT           NULL,
        information_technology_mark INT           NULL,
        agricultural_science_mark   INT           NULL,
        subjects_failed             INT           NOT NULL,
        overall_result              VARCHAR(4)    NOT NULL,
        dwh_load_date               DATETIME2     NOT NULL DEFAULT SYSDATETIME()
    );
END
GO

--- Transformation#1: trim/ title case student_name
USE ec_college_dwh;
GO

CREATE OR ALTER FUNCTION silver.fn_TitleCase (@input VARCHAR(200))
RETURNS VARCHAR(200)
AS
BEGIN
    DECLARE @result VARCHAR(200) = '';
    DECLARE @i INT = 1;
    DECLARE @char CHAR(1);
    DECLARE @prevChar CHAR(1) = ' ';  -- treat start of string like it follows a space

    SET @input = LOWER(LTRIM(RTRIM(@input)));  -- trim + lowercase everything first

    WHILE @i <= LEN(@input)
    BEGIN
        SET @char = SUBSTRING(@input, @i, 1);

        IF @prevChar = ' '
            SET @result = @result + UPPER(@char);  -- capitalize after a space
        ELSE
            SET @result = @result + @char;          -- keep lowercase otherwise

        SET @prevChar = @char;
        SET @i = @i + 1;
    END

    RETURN @result;
END
GO


--- inserting data from the broze tables to the silver tables fro transformation
--- sliver Grade 10 table
INSERT INTO silver.prelim_science_grade10
    (student_id, student_name, grade, grade_band, mathematics_mark, physical_science_mark,
     life_sciences_mark, english_home_language_mark, life_orientation_mark,
     information_technology_mark, agricultural_science_mark, subjects_failed, overall_result)
SELECT
    TRIM(student_id),
    silver.fn_TitleCase(student_name),   -- transformation 1 applied here
    grade,
    grade,                                -- placeholder for now — we'll fix grade_band in a later step
    mathematics_mark,
    physical_science_mark,
    life_sciences_mark,
    english_home_language_mark,
    life_orientation_mark,
    information_technology_mark,
    agricultural_science_mark,
    0,                                     -- placeholder for subjects_failed, we'll calculate this later
    'PASS'                                 -- placeholder for overall_result, we'll calculate this later
FROM ec_college_stg.bronze.prelim_science_grade10;

select *
from silver.prelim_science_grade10

--- silver Grade 11 table
INSERT INTO silver.prelim_science_grade11
    (student_id, student_name, grade, grade_band, mathematics_mark, physical_science_mark,
     life_sciences_mark, english_home_language_mark, life_orientation_mark,
     information_technology_mark, agricultural_science_mark, subjects_failed, overall_result)
SELECT
    TRIM(student_id),
    silver.fn_TitleCase(student_name),   -- transformation 1 applied here
    grade,
    grade,                                -- placeholder for now — we'll fix grade_band in a later step
    mathematics_mark,
    physical_science_mark,
    life_sciences_mark,
    english_home_language_mark,
    life_orientation_mark,
    information_technology_mark,
    agricultural_science_mark,
    0,                                     -- placeholder for subjects_failed, we'll calculate this later
    'PASS'                                 -- placeholder for overall_result, we'll calculate this later
FROM ec_college_stg.bronze.prelim_science_grade11;

--- Silver Grade 12 table
INSERT INTO silver.prelim_science_grade12
    (student_id, student_name, grade, grade_band, mathematics_mark, physical_science_mark,
     life_sciences_mark, english_home_language_mark, life_orientation_mark,
     information_technology_mark, agricultural_science_mark, subjects_failed, overall_result)
SELECT
    TRIM(student_id),
    silver.fn_TitleCase(student_name),   -- transformation 1 applied here
    grade,
    grade,                                -- placeholder for now — we'll fix grade_band in a later step
    mathematics_mark,
    physical_science_mark,
    life_sciences_mark,
    english_home_language_mark,
    life_orientation_mark,
    information_technology_mark,
    agricultural_science_mark,
    0,                                     -- placeholder for subjects_failed, we'll calculate this later
    'PASS'                                 -- placeholder for overall_result, we'll calculate this later
FROM ec_college_stg.bronze.prelim_science_grade12;

--- Check if the marks from the data loaded from broze tables are decimals or integers.
SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    NUMERIC_PRECISION, 
    NUMERIC_SCALE
FROM ec_college_dwh.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'silver'
  AND TABLE_NAME = 'prelim_science_grade10'
  AND COLUMN_NAME LIKE '%mark%';


--- Transformation #3: Derive grade_band from grade
UPDATE silver.prelim_science_grade10
SET grade_band = LEFT(grade, LEN(grade) - 1);

select 
grade,
grade_band
from silver.prelim_science_grade10 

select *
from ec_college_dwh.silver.prelim_science_grade11

--- Add source_table for lineage
ALTER TABLE silver.prelim_science_grade10
ADD source_table VARCHAR(100) NULL;

ALTER TABLE silver.prelim_science_grade11
ADD source_table VARCHAR(100) NULL;

ALTER TABLE silver.prelim_science_grade12
ADD source_table VARCHAR(100) NULL;

--- populate source_table with bronze table
UPDATE silver.prelim_science_grade10
SET source_table = 'ec_college_stg.bronze.prelim_science_grade10';

UPDATE silver.prelim_science_grade11
SET source_table = 'ec_college_stg.bronze.prelim_science_grade11';

UPDATE silver.prelim_science_grade12
SET source_table = 'ec_college_stg.bronze.prelim_science_grade12';

SELECT student_id, student_name, source_table
FROM silver.prelim_science_grade10;

--- Transformation #4: Derive subjects_failed = count of subjects with mark < 40
UPDATE silver.prelim_science_grade10
SET subjects_failed = 
      CASE WHEN mathematics_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN physical_science_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN life_sciences_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN english_home_language_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN life_orientation_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN information_technology_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN agricultural_science_mark < 40 THEN 1 ELSE 0 END;

UPDATE silver.prelim_science_grade11
SET subjects_failed = 
      CASE WHEN mathematics_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN physical_science_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN life_sciences_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN english_home_language_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN life_orientation_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN information_technology_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN agricultural_science_mark < 40 THEN 1 ELSE 0 END;

UPDATE silver.prelim_science_grade12
SET subjects_failed = 
      CASE WHEN mathematics_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN physical_science_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN life_sciences_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN english_home_language_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN life_orientation_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN information_technology_mark < 40 THEN 1 ELSE 0 END
    + CASE WHEN agricultural_science_mark < 40 THEN 1 ELSE 0 END;


--- Transfromation #5: Derive overall_result = "FAIL" if subjects_failed > 0 else "PASS".
UPDATE silver.prelim_science_grade10
SET overall_result = 
    CASE WHEN subjects_failed > 0 THEN 'FAIL' ELSE 'PASS' END;

UPDATE silver.prelim_science_grade11
SET overall_result = 
    CASE WHEN subjects_failed > 0 THEN 'FAIL' ELSE 'PASS' END;

UPDATE silver.prelim_science_grade12
SET overall_result = 
    CASE WHEN subjects_failed > 0 THEN 'FAIL' ELSE 'PASS' END;

select *
from ec_college_dwh.silver.prelim_science_grade10;