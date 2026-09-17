-- Staging database: holds raw, unprocessed (dirty) data
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'ec_college_stg')
BEGIN
    CREATE DATABASE ec_college_stg;
END
GO

USE ec_college_stg;
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
BEGIN
    EXEC('CREATE SCHEMA bronze'); -- raw/dirty data
END
GO


-- Data warehouse database: holds cleaned and modeled data
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'ec_college_dwh')
BEGIN
    CREATE DATABASE ec_college_dwh;
END
GO

USE ec_college_dwh;
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'silver')
BEGIN
    EXEC('CREATE SCHEMA silver'); -- cleaned/conformed data
END
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
BEGIN
    EXEC('CREATE SCHEMA gold'); -- business-ready/aggregated data
END
GO





