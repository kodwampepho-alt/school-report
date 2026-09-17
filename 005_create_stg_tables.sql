SELECT TOP (1000) [student_id]
      ,[student_name]
      ,[grade]
      ,[mathematics_mark]
      ,[physical_science_mark]
      ,[life_sciences_mark]
      ,[english_home_language_mark]
      ,[life_orientation_mark]
      ,[information_technology_mark]
      ,[agricultural_science_mark]
      ,[total_mark]
      ,[average_mark]
  FROM [ec_college_stg].[bronze].[prelim_science_students_marks]


  --- grade 10 table
  SELECT TOP (1000) [student_id]
      ,[student_name]
      ,[grade]
      ,[mathematics_mark]
      ,[physical_science_mark]
      ,[life_sciences_mark]
      ,[english_home_language_mark]
      ,[life_orientation_mark]
      ,[information_technology_mark]
      ,[agricultural_science_mark]
      ,[total_mark]
      ,[average_mark]
  FROM [ec_college_stg].[bronze].[prelim_science_students_marks]
  WHERE grade in ('10A', '10B') 

  ---grade 11 table
  SELECT TOP (1000) [student_id]
      ,[student_name]
      ,[grade]
      ,[mathematics_mark]
      ,[physical_science_mark]
      ,[life_sciences_mark]
      ,[english_home_language_mark]
      ,[life_orientation_mark]
      ,[information_technology_mark]
      ,[agricultural_science_mark]
      ,[total_mark]
      ,[average_mark]
  FROM [ec_college_stg].[bronze].[prelim_science_students_marks]
  WHERE grade in ('11A', '11B')

  ---grade 12 table
  SELECT TOP (1000) [student_id]
      ,[student_name]
      ,[grade]
      ,[mathematics_mark]
      ,[physical_science_mark]
      ,[life_sciences_mark]
      ,[english_home_language_mark]
      ,[life_orientation_mark]
      ,[information_technology_mark]
      ,[agricultural_science_mark]
      ,[total_mark]
      ,[average_mark]
  FROM [ec_college_stg].[bronze].[prelim_science_students_marks]
  WHERE grade in ('12A', '12B')

  --- CREATING BROZE TABLES AND LOADING DATA
  USE ec_college_stg;
GO

-- =========================================
-- Grade 10 table
-- =========================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'prelim_science_grade10' AND schema_id = SCHEMA_ID('bronze'))
BEGIN
    CREATE TABLE bronze.prelim_science_grade10 (
        student_id                  VARCHAR(20),
        student_name                VARCHAR(100),
        grade                       VARCHAR(10),
        mathematics_mark            DECIMAL(5,2),
        physical_science_mark       DECIMAL(5,2),
        life_sciences_mark          DECIMAL(5,2),
        english_home_language_mark  DECIMAL(5,2),
        life_orientation_mark       DECIMAL(5,2),
        information_technology_mark DECIMAL(5,2),
        agricultural_science_mark   DECIMAL(5,2),
        total_mark                  DECIMAL(6,2),
        average_mark                DECIMAL(5,2)
    );
END
GO

INSERT INTO bronze.prelim_science_grade10
    (student_id, student_name, grade, mathematics_mark, physical_science_mark,
     life_sciences_mark, english_home_language_mark, life_orientation_mark,
     information_technology_mark, agricultural_science_mark, total_mark, average_mark)
SELECT [student_id]
      ,[student_name]
      ,[grade]
      ,[mathematics_mark]
      ,[physical_science_mark]
      ,[life_sciences_mark]
      ,[english_home_language_mark]
      ,[life_orientation_mark]
      ,[information_technology_mark]
      ,[agricultural_science_mark]
      ,[total_mark]
      ,[average_mark]
FROM [ec_college_stg].[bronze].[prelim_science_students_marks]
WHERE grade IN ('10A', '10B');
GO


-- =========================================
-- Grade 11 table
-- =========================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'prelim_science_grade11' AND schema_id = SCHEMA_ID('bronze'))
BEGIN
    CREATE TABLE bronze.prelim_science_grade11 (
        student_id                  VARCHAR(20),
        student_name                VARCHAR(100),
        grade                       VARCHAR(10),
        mathematics_mark            DECIMAL(5,2),
        physical_science_mark       DECIMAL(5,2),
        life_sciences_mark          DECIMAL(5,2),
        english_home_language_mark  DECIMAL(5,2),
        life_orientation_mark       DECIMAL(5,2),
        information_technology_mark DECIMAL(5,2),
        agricultural_science_mark   DECIMAL(5,2),
        total_mark                  DECIMAL(6,2),
        average_mark                DECIMAL(5,2)
    );
END
GO

INSERT INTO bronze.prelim_science_grade11
    (student_id, student_name, grade, mathematics_mark, physical_science_mark,
     life_sciences_mark, english_home_language_mark, life_orientation_mark,
     information_technology_mark, agricultural_science_mark, total_mark, average_mark)
SELECT [student_id]
      ,[student_name]
      ,[grade]
      ,[mathematics_mark]
      ,[physical_science_mark]
      ,[life_sciences_mark]
      ,[english_home_language_mark]
      ,[life_orientation_mark]
      ,[information_technology_mark]
      ,[agricultural_science_mark]
      ,[total_mark]
      ,[average_mark]
FROM [ec_college_stg].[bronze].[prelim_science_students_marks]
WHERE grade IN ('11A', '11B');
GO


-- =========================================
-- Grade 12 table
-- =========================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'prelim_science_grade12' AND schema_id = SCHEMA_ID('bronze'))
BEGIN
    CREATE TABLE bronze.prelim_science_grade12 (
        student_id                  VARCHAR(20),
        student_name                VARCHAR(100),
        grade                       VARCHAR(10),
        mathematics_mark            DECIMAL(5,2),
        physical_science_mark       DECIMAL(5,2),
        life_sciences_mark          DECIMAL(5,2),
        english_home_language_mark  DECIMAL(5,2),
        life_orientation_mark       DECIMAL(5,2),
        information_technology_mark DECIMAL(5,2),
        agricultural_science_mark   DECIMAL(5,2),
        total_mark                  DECIMAL(6,2),
        average_mark                DECIMAL(5,2)
    );
END
GO

INSERT INTO bronze.prelim_science_grade12
    (student_id, student_name, grade, mathematics_mark, physical_science_mark,
     life_sciences_mark, english_home_language_mark, life_orientation_mark,
     information_technology_mark, agricultural_science_mark, total_mark, average_mark)
SELECT [student_id]
      ,[student_name]
      ,[grade]
      ,[mathematics_mark]
      ,[physical_science_mark]
      ,[life_sciences_mark]
      ,[english_home_language_mark]
      ,[life_orientation_mark]
      ,[information_technology_mark]
      ,[agricultural_science_mark]
      ,[total_mark]
      ,[average_mark]
FROM [ec_college_stg].[bronze].[prelim_science_students_marks]
WHERE grade IN ('12A', '12B');
GO

DROP TABLE IF EXISTS bronze.prelim_science_grade10;
DROP TABLE IF EXISTS bronze.prelim_science_grade11;
DROP TABLE IF EXISTS bronze.prelim_science_grade12;

