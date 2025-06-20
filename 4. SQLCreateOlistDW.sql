/****** Object:  Database OlistDWTest    Script Date: 24/05/2025 6:41:20 SA ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE OlistDWTest
GO
CREATE DATABASE OlistDWTest
GO
ALTER DATABASE OlistDWTest
SET RECOVERY SIMPLE
GO
*/
USE OlistDWTest
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;





-- Create a schema to hold user views (set schema name on home page of workbook).
-- It would be good to do this only if the schema doesn't exist already.
GO
CREATE SCHEMA MDWT
GO






/* Drop table dbo.DimAudit */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimAudit') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimAudit 
;

/* Create table dbo.DimAudit */
CREATE TABLE dbo.DimAudit (
   [AuditKey]  int IDENTITY  NOT NULL
,  [ParentAuditKey]  int   NOT NULL
,  [TableName]  nvarchar(50)  DEFAULT 'Unknown' NOT NULL
,  [PkgName]  nvarchar(50)  DEFAULT 'Unknown' NOT NULL
,  [PkgGUID]  uniqueidentifier   NULL
,  [PkgVersionGUID]  uniqueidentifier   NULL
,  [PkgVersionMajor]  smallint   NULL
,  [PkgVersionMinor]  smallint   NULL
,  [ExecStartDT]  datetime  DEFAULT getdate() NOT NULL
,  [ExecStopDT]  datetime   NULL
,  [ExecutionInstanceGUID]  uniqueidentifier   NULL
,  [ExtractRowCnt]  bigint   NULL
,  [InsertRowCnt]  bigint   NULL
,  [UpdateRowCnt]  bigint   NULL
,  [ErrorRowCnt]  bigint   NULL
,  [TableInitialRowCnt]  bigint   NULL
,  [TableFinalRowCnt]  bigint   NULL
,  [TableMaxSurrogateKey]  bigint   NULL
,  [SuccessfulProcessingInd]  nchar(1)  DEFAULT 'N' NOT NULL
, CONSTRAINT [PK_dbo.DimAudit] PRIMARY KEY CLUSTERED 
( [AuditKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Audit', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimAudit
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Audit', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimAudit
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Audit dimension tags each data row with the the process that added or updated it.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimAudit
;

SET IDENTITY_INSERT dbo.DimAudit ON
;
INSERT INTO dbo.DimAudit (AuditKey, ParentAuditKey, TableName, PkgName, PkgGUID, PkgVersionGUID, PkgVersionMajor, PkgVersionMinor, ExecStartDT, ExecStopDT, ExecutionInstanceGUID, ExtractRowCnt, InsertRowCnt, UpdateRowCnt, ErrorRowCnt, TableInitialRowCnt, TableFinalRowCnt, TableMaxSurrogateKey, SuccessfulProcessingInd)
VALUES (-1, -1, 'Audit', 'None: Dummy row', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Y')
;
SET IDENTITY_INSERT dbo.DimAudit OFF
;

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'AuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'AuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ParentAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ParentAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TableName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PkgName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PkgGUID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgGUID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PkgVersionGUID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgVersionGUID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PkgVersionMajor', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgVersionMajor'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PkgVersionMinor', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgVersionMinor'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ExecStartDT', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExecStartDT'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ExecStopDT', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExecStopDT'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ExecutionInstanceGUID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExecutionInstanceGUID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ExtractRowCnt', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExtractRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'InsertRowCnt', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'InsertRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'UpdateRowCnt', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'UpdateRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ErrorRowCnt', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ErrorRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TableInitialRowCnt', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableInitialRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TableFinalRowCnt', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableFinalRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TableMaxSurrogateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableMaxSurrogateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SuccessfulProcessingInd', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'SuccessfulProcessingInd'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'AuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Foreign key to self, to identify calling package execution', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ParentAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the main table loaded by this package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the SSIS package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Identifier for the package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgGUID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Identifier for the package version', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgVersionGUID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Major version number for the package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgVersionMajor'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Minor version number for the package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgVersionMinor'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Date-time the package started executing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExecStartDT'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Date-time the package finished executing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExecStopDT'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Identifier for the execution of the package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExecutionInstanceGUID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Count of rows extracted from the source(s)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExtractRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Count of rows inserted in the destination table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'InsertRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Count of rows updated in the destination table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'UpdateRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Count of error rows', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ErrorRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Count of rows in target table before we begin', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableInitialRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Count of rows in target table after package ends', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableFinalRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Maximum surrogate key value in table (if we''re maintaining ourselves)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableMaxSurrogateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Did the package finish executing successfully?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'SuccessfulProcessingInd'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'AuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ParentAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'SuccessfulProcessingInd'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'AuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ParentAuditKey'; 
;





/* Drop table dbo.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimDate 
;

/* Create table dbo.DimDate */
CREATE TABLE dbo.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  date    NOT NULL
,  [DayOfWeek]  varchar(50)   NOT NULL
,  [DayOfMonth]  int   NOT NULL
,  [Month]  int   NOT NULL
,  [MonthName]  varchar(50)   NULL
,  [Quarter]  int   NOT NULL
,  [Year]  int   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  date   NULL
,  [RowEndDate]  date  DEFAULT '9999-12-31' NULL
,  [RowChangeReason]  varchar(200)   NULL
,  [InsertAuditKey]  int   NULL
,  [UpdateAuditKey]  int   NULL
, CONSTRAINT [PK_dbo.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimDate', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Dimension table for date attributes to support reporting and analysis.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
;

INSERT INTO dbo.DimDate (DateKey, Date, DayOfWeek, DayOfMonth, Month, MonthName, Quarter, Year, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason, InsertAuditKey, UpdateAuditKey)
VALUES (-1, '', 'Unk Date', 0, 0, 'Unk Month', 0, 0, 1, '1899-12-31', '9999-12-31', 'N/A', -1, -1)
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[DimDate]'))
DROP VIEW [MDWT].[DimDate]
GO
CREATE VIEW [MDWT].[DimDate] AS 
SELECT [DateKey] AS [DateKey]
, [Date] AS [Date]
, [DayOfWeek] AS [DayOfWeek]
, [DayOfMonth] AS [DayOfMonth]
, [Month] AS [Month]
, [MonthName] AS [MonthName]
, [Quarter] AS [Quarter]
, [Year] AS [Year]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
, [InsertAuditKey] AS [Insert Audit Key]
, [UpdateAuditKey] AS [Update Audit Key]
FROM dbo.DimDate
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfWeek', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfMonth', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Month', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Month'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Quarter', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Year', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Insert Audit Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Update Audit Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Full Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The day of the week (Monday, Tuesday, etc.)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The day number in the month (1-31)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The month number (1-12)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Month'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Full name of the month (January, February, etc.)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The quarter of the year (1-4)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The year of the date (e.g., 2023)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process loaded this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process most recently updated this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20040722', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1900-01-01,...', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Monday', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'12', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'8', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Month'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'January', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1998', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 0', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1900-01-01,...', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1900-01-01,...', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Month'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Month'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderRevierws, OrderDataset', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'DATENAME(WEEKDAY, Date)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'DAY(Date)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'MONTH(Date)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Month'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'DATENAME(MONTH, Date)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'DATEPART(QUARTER, Date)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'YEAR(Date)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Month'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
;





/* Drop table dbo.DimProducts */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimProducts') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimProducts 
;

/* Create table dbo.DimProducts */
CREATE TABLE dbo.DimProducts (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  nvarchar(50)   NOT NULL
,  [ProductCategoryName]  nvarchar(50)   NULL
,  [ProductWeight]  decimal(10,1)   NULL
,  [ProductLength]  decimal(10,1)   NULL
,  [ProductHeight]  decimal(10,1)   NULL
,  [ProductWidth]  decimal(10,1)   NULL
,  [RowIsCurrent]  nvarchar(1)  DEFAULT '1' NOT NULL
,  [RowStartDate]  datetime   NULL
,  [RowEndDate]  datetime  DEFAULT '9999-12-31' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
,  [InsertAuditKey]  int   NULL
,  [UpdateAuditKey]  int   NULL
, CONSTRAINT [PK_dbo.DimProducts] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimProducts
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimProducts', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimProducts
;

SET IDENTITY_INSERT dbo.DimProducts ON
;
INSERT INTO dbo.DimProducts (ProductKey, ProductID, ProductCategoryName, ProductWeight, ProductLength, ProductHeight, ProductWidth, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason, InsertAuditKey, UpdateAuditKey)
VALUES (-1, '', '', NULL, NULL, NULL, NULL, 'Y', '1989-03-12', '9999-12-31', 'N/A', -1, -1)
;
SET IDENTITY_INSERT dbo.DimProducts OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[DimProducts]'))
DROP VIEW [MDWT].[DimProducts]
GO
CREATE VIEW [MDWT].[DimProducts] AS 
SELECT [ProductKey] AS [ProductKey]
, [ProductID] AS [ProductID]
, [ProductCategoryName] AS [ProductCategoryName]
, [ProductWeight] AS [ProductWeight]
, [ProductLength] AS [ProductLength]
, [ProductHeight] AS [ProductHeight]
, [ProductWidth] AS [ProductWidth]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
, [InsertAuditKey] AS [InsertAuditKey]
, [UpdateAuditKey] AS [UpdateAuditKey]
FROM dbo.DimProducts
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductCategoryName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductCategoryName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductWeight', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWeight'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductLength', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductLength'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductHeight', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductHeight'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductWidth', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWidth'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'InsertAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'UpdateAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Category or classification of the product.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductCategoryName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Weight of the product in grams.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWeight'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Length of the product in centimeters.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductLength'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Height of the product in centimeters.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductHeight'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Width of the product in centimeters.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWidth'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process loaded this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process most recently updated this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'00066f42aeeb9f3007548bb9d3f33c38', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'perfumaria', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductCategoryName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'300', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWeight'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductLength'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'16', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductHeight'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'16', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWidth'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'24/01/2011', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductCategoryName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWeight'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductLength'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductHeight'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWidth'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductCategoryName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWeight'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductLength'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductHeight'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWidth'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductCategoryName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWeight'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductLength'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductHeight'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWidth'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Products', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Product', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductCategoryName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Products', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWeight'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Products', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductLength'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Products', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductHeight'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Products', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWidth'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_category_name', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductCategoryName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_weight_g', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWeight'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_length_cm', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductLength'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_height_cm', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductHeight'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_width_cm', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWidth'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductCategoryName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(10,1)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWeight'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(10,1)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductLength'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(10,1)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductHeight'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(10,1)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimProducts', @level2type=N'COLUMN', @level2name=N'ProductWidth'; 
;





/* Drop table dbo.DimGeolocation */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimGeolocation') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimGeolocation 
;

/* Create table dbo.DimGeolocation */
CREATE TABLE dbo.DimGeolocation (
   [GeoLocationKey]  int IDENTITY  NOT NULL
,  [ZipCodePrefix]  int    NOT NULL
,  [Latitude]  decimal(9,4)   NULL
,  [Longitude]  decimal(9,4)   NULL
,  [City]  nvarchar(50)   NULL
,  [State]  nvarchar(50)   NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime   NULL
,  [RowEndDate]  datetime  DEFAULT '9999-12-31' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
,  [InsertAuditKey]  int   NULL
,  [UpdateAuditKey]  int   NULL
, CONSTRAINT [PK_dbo.DimGeolocation] PRIMARY KEY CLUSTERED 
( [GeoLocationKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimGeolocation
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimGeolocation', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimGeolocation
;

SET IDENTITY_INSERT dbo.DimGeolocation ON
;
INSERT INTO dbo.DimGeolocation (GeoLocationKey, ZipCodePrefix, Latitude, Longitude, City, State, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason, InsertAuditKey, UpdateAuditKey)
VALUES (-1, 1, NULL, NULL, '', '', 1, '1989-03-12', '9999-12-31', 'N/A', -1, -1)
;
SET IDENTITY_INSERT dbo.DimGeolocation OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[DimGeolocation]'))
DROP VIEW [MDWT].[DimGeolocation]
GO
CREATE VIEW [MDWT].[DimGeolocation] AS 
SELECT [GeoLocationKey] AS [GeoLocationKey]
, [ZipCodePrefix] AS [ZipCodePrefix]
, [Latitude] AS [Latitude]
, [Longitude] AS [Longitude]
, [City] AS [City]
, [State] AS [State]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
, [InsertAuditKey] AS [InsertAuditKey]
, [UpdateAuditKey] AS [UpdateAuditKey]
FROM dbo.DimGeolocation
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'GeoLocationKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'GeoLocationKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ZipCodePrefix', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'ZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Latitude', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Latitude'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Longitude', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Longitude'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'City', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'State', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'State'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'InsertAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'UpdateAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'GeoLocationKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The first digits of the postal code, used to group geographical areas at a district or regional level. ', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'ZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Geographic coordinate that specifies the north–south position of a location. ', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Latitude'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Geographic coordinate that specifies the east–west position of a location. ', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Longitude'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The name of the city associated with the zip code prefix.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The state or province in which the location is situated.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'State'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process loaded this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process most recently updated this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'GeoLocationKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1001', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'ZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'-23', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Latitude'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'-46', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Longitude'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'sao paulo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'SP', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'State'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 0', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'12/03/1989', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'GeoLocationKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'ZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Latitude'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Longitude'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'State'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Longitude'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Longitude'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'GeoLocationKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'ZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Latitude'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Longitude'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'State'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'ZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Latitude'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Longitude'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'State'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Geolocation', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'ZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Geolocation', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Latitude'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Geolocation', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Longitude'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Geolocation', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Geolocation', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'State'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'geolocation_zip_code_prefix', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'ZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'geolocation_lat', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Latitude'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'geolocation_lng', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Longitude'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'geolocation_city', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'geolocation_state', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'State'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'ZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(9,4)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Latitude'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(9,4)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'Longitude'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimGeolocation', @level2type=N'COLUMN', @level2name=N'State'; 
;





/* Drop table dbo.DimCustomers */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimCustomers') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimCustomers 
;

/* Create table dbo.DimCustomers */
CREATE TABLE dbo.DimCustomers (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerID]  nvarchar(50)   NULL
,  [CustomerUniqueID]  nvarchar(50)   NULL
,  [CustomerZipCodePrefix]  int   NULL
,  [CustomerCity]  nvarchar(50)   NULL
,  [CustomerState]  nvarchar(50)   NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime   NULL
,  [RowEndDate]  datetime  DEFAULT '9999-12-31' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
,  [InsertAuditKey]  int   NULL
,  [UpdateAuditKey]  int   NULL
, CONSTRAINT [PK_dbo.DimCustomers] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimCustomers
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimCustomers', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimCustomers
;

SET IDENTITY_INSERT dbo.DimCustomers ON
;
INSERT INTO dbo.DimCustomers (CustomerKey, CustomerID, CustomerUniqueID, CustomerZipCodePrefix, CustomerCity, CustomerState, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason, InsertAuditKey, UpdateAuditKey)
VALUES (-1, '', '', NULL, '', '', 1, '1989-03-12', '9999-12-31', 'N/A', -1, -1)
;
SET IDENTITY_INSERT dbo.DimCustomers OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[DimCustomers]'))
DROP VIEW [MDWT].[DimCustomers]
GO
CREATE VIEW [MDWT].[DimCustomers] AS 
SELECT [CustomerKey] AS [CustomerKey]
, [CustomerID] AS [CustomerID]
, [CustomerUniqueID] AS [CustomerUniqueID]
, [CustomerZipCodePrefix] AS [CustomerZipCodePrefix]
, [CustomerCity] AS [CustomerCity]
, [CustomerState] AS [CustomerState]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
, [InsertAuditKey] AS [InsertAuditKey]
, [UpdateAuditKey] AS [UpdateAuditKey]
FROM dbo.DimCustomers
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerUniqueID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerUniqueID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerZipCodePrefix', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerCity', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerState', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'InsertAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'UpdateAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Original customer ID from the system (business key)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Unique identifier for customer (if different from CustomerID)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerUniqueID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Postal code prefix (zip code prefix)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the Customer''s city', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'State or province for the customer', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process loaded this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process most recently updated this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'00012a2ce6f8dcda20d059ce98491703', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'248ffe10d632bebe4f7267f1f44844c9', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerUniqueID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'6273', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'osasco', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'SP', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 0', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'12/03/1989', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerUniqueID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerUniqueID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerUniqueID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerUniqueID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_unique_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerUniqueID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_zip_code_predix', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_city', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_state', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerUniqueID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerZipCodePrefix'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
;





/* Drop table dbo.DimSellers */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimSellers') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimSellers 
;

/* Create table dbo.DimSellers */
CREATE TABLE dbo.DimSellers (
   [SellerKey]  int IDENTITY  NOT NULL
,  [SellerID]  nvarchar(50)   NOT NULL
,  [SellerZip]  int   NOT NULL
,  [SellerCity]  nvarchar(50)   NOT NULL
,  [SellerState]  nvarchar(50)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime   NULL
,  [RowEndDate]  datetime  DEFAULT '9999-12-31' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_dbo.DimSellers] PRIMARY KEY CLUSTERED 
( [SellerKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimSellers
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimSellers', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimSellers
;

SET IDENTITY_INSERT dbo.DimSellers ON
;
INSERT INTO dbo.DimSellers (SellerKey, SellerID, SellerZip, SellerCity, SellerState, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, '', -1, '', '', 1, '1989-03-12', '9999-12-31', 'N/A')
;
SET IDENTITY_INSERT dbo.DimSellers OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[DimSellers]'))
DROP VIEW [MDWT].[DimSellers]
GO
CREATE VIEW [MDWT].[DimSellers] AS 
SELECT [SellerKey] AS [SellerKey]
, [SellerID] AS [SellerID]
, [SellerZip] AS [SellerZip]
, [SellerCity] AS [SellerCity]
, [SellerState] AS [SellerState]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM dbo.DimSellers
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SellerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SellerID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SellerZip', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerZip'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SellerCity', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerCity'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SellerState', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerState'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ZIP code prefix of the seller is location, used for regional analysis.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerZip'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'City where the seller is located.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerCity'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'State where the seller is located.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerState'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'0015a82c2db000af6aaaf3ae2ecb0532', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'9080', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerZip'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'santo andre', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerCity'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'SP', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerState'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 0', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'12/03/1989', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerZip'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerCity'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerState'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerZip'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerCity'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerState'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerZip'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerState'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sellers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sellers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerZip'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sellers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sellers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerState'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Seller_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Seller_zip_code_prefix', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerZip'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'seller_city', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'seller_state', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerState'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerZip'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSellers', @level2type=N'COLUMN', @level2name=N'SellerState'; 
;





/* Drop table dbo.FactSalesItem */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactSalesItem') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactSalesItem 
;

/* Create table dbo.FactSalesItem */
CREATE TABLE dbo.FactSalesItem (
   [OrderID]  nvarchar(50)   NOT NULL
,  [OrderItemID]  int   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [SellerKey]  int   NOT NULL
,  [ProductKey]  int   NOT NULL
,  [CustomerGeollocationKey]  int   NULL
,  [SellerGeolocationKey]  int   NULL
,  [OrderDateKey]  int   NOT NULL
,  [Revenue]  decimal(8,3)   NULL
,  [FreightValue]  decimal(8,3)   NULL
,  [GrossProfit]  decimal(8,3)   NULL
,  [InsertAuditKey]  int   NULL
,  [UpdateAuditKey]  int   NULL
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactSalesItem
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FactSalesItem', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactSalesItem
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[FactSalesItem]'))
DROP VIEW [MDWT].[FactSalesItem]
GO
CREATE VIEW [MDWT].[FactSalesItem] AS 
SELECT [OrderID] AS [OrderID]
, [OrderItemID] AS [OrderItemID]
, [CustomerKey] AS [CustomerKey]
, [SellerKey] AS [SellerKey]
, [ProductKey] AS [ProductKey]
, [CustomerGeollocationKey] AS [CustomerGeollocationKey]
, [SellerGeolocationKey] AS [SellerGeolocationKey]
, [OrderDateKey] AS [OrderDateKey]
, [Revenue] AS [Revenue]
, [FreightValue] AS [FreightValue]
, [GrossProfit] AS [GrossProfit]
, [InsertAuditKey] AS [Insert Audit Key]
, [UpdateAuditKey] AS [Update Audit Key]
FROM dbo.FactSalesItem
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderItemID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderItemID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SellerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerGeollocationKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerGeollocationKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SellerGeolocationKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerGeolocationKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderDateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Revenue', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'Revenue'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FreightValue', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'FreightValue'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'GrossProfit', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'GrossProfit'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Insert Audit Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Update Audit Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Unique identifier of the sales order', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Identifier of the specific item within the order', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderItemID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate key referencing the customer', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate key referencing the seller', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate key referencing the product', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key linking to customer''s geographical location', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerGeollocationKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key linking to seller''s geographical location', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerGeolocationKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key referencing the order purchase date in the date dimension', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Total price paid by customer for the item', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'Revenue'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Shipping cost charged for the item', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'FreightValue'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Revenue minus freight cost (estimated profit)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'GrossProfit'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Audit dimension for row insertion', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Audit dimension for row update', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'00012a2ce6f8dcda20d059ce98491703', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderItemID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'849751', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'21984', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'204604', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'155643', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerGeollocationKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'157593', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerGeolocationKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20170718', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'59', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'Revenue'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'13', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'FreightValue'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'46', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'GrossProfit'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderItemID'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerGeollocationKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerGeolocationKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Amount', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'Revenue'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Amount', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'FreightValue'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Amount', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'GrossProfit'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Surrogate key peipeline lookup for dimension key lookup using business key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Surrogate key peipeline lookup for dimension key lookup using business key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Surrogate key peipeline lookup for dimension key lookup using business key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Surrogate key peipeline lookup for dimension key lookup using business key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerGeollocationKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Surrogate key peipeline lookup for dimension key lookup using business key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerGeolocationKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'convert datetime to int of format YYYYMMDD', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderItemID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerGeollocationKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerGeolocationKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'Revenue'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'FreightValue'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'GrossProfit'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderItemID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerGeollocationKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerGeolocationKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'Revenue'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'FreightValue'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Orderitems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Orderitems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderItemID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimCustomers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimSellers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimProducts', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimGeolocation', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerGeollocationKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimGeolocation', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerGeolocationKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Orderitems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'Revenue'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Orderitems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'FreightValue'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Price - FreightValue', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'GrossProfit'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'order_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'order_item_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderItemID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'SellerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'ProductKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'GeolocationKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerGeollocationKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'GeolocationKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerGeolocationKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'price', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'Revenue'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'freight_value', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'FreightValue'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderItemID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'CustomerGeollocationKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'SellerGeolocationKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(8,3)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'Revenue'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(8,3)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSalesItem', @level2type=N'COLUMN', @level2name=N'FreightValue'; 
;





/* Drop table dbo.FactReview */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactReview') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactReview 
;

/* Create table dbo.FactReview */
CREATE TABLE dbo.FactReview (
   [ReviewID]  nvarchar(50)   NOT NULL
,  [OrderID]  nvarchar(50)   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [ReviewScore]  float   NULL
,  [DeliveryCost]  money   NULL
,  [ReviewAnswerTimestampKey]  int   NULL
,  [ReviewCreationDateKey]  int   NULL
,  [ResponseTime]  float   NULL
,  [InsertAuditKey]  int   NULL
,  [UpdateAuditKey]  int   NULL
, CONSTRAINT [PK_dbo.FactReview] PRIMARY KEY NONCLUSTERED 
( [ReviewID] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactReview
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FactReview', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactReview
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[FactReview]'))
DROP VIEW [MDWT].[FactReview]
GO
CREATE VIEW [MDWT].[FactReview] AS 
SELECT [ReviewID] AS [ReviewID]
, [OrderID] AS [OrderID]
, [CustomerKey] AS [CustomerKey]
, [ReviewScore] AS [ReviewScore]
, [DeliveryCost] AS [DeliveryCost]
, [ReviewAnswerTimestampKey] AS [ReviewAnswerTimestampKey]
, [ReviewCreationDateKey] AS [ReviewCreationDateKey]
, [ResponseTime] AS [ResponseTime]
, [InsertAuditKey] AS [Insert Audit Key]
, [UpdateAuditKey] AS [Update Audit Key]
FROM dbo.FactReview
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ReviewID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ReviewScore', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewScore'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DeliveryCost', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'DeliveryCost'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ReviewAnswerTimestampKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewAnswerTimestampKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ReviewCreationDateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewCreationDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ResponseTime', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ResponseTime'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Insert Audit Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Update Audit Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'FK to OrderReviews', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'FK to OrderItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'FK to DimCustomer', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer review score (1 to 5)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewScore'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Freight value of the order', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'DeliveryCost'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Time taken to respond to review in hours', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ResponseTime'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Audit dimension for row insertion', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Audit dimension for row update', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'0001239bc1de2e33cb583967c2ca4c67', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'fc046d7776171871436844218f817d7d', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3, 4, 5', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewScore'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'15.99, 25.50, 10.00', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'DeliveryCost'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'24.5, 48.0, 72.3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ResponseTime'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewID'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewScore'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'DeliveryCost'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewAnswerTimestampKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewCreationDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ResponseTime'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewScore'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'DeliveryCost'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewAnswerTimestampKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewCreationDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderReviews', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimCustomers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderReviews', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewScore'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'DeliveryCost'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewAnswerTimestampKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewCreationDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'review_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'order_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'review_score', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewScore'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'freight_value', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'DeliveryCost'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewAnswerTimestampKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewCreationDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewScore'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'float', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'DeliveryCost'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewAnswerTimestampKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactReview', @level2type=N'COLUMN', @level2name=N'ReviewCreationDateKey'; 
;





/* Drop table dbo.FactPayments */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactPayments') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactPayments 
;

/* Create table dbo.FactPayments */
CREATE TABLE dbo.FactPayments (
   [PaymentKey]  int IDENTITY  NOT NULL
,  [OrderID]  nvarchar(50)   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [ProductKey]  int   NOT NULL
,  [SellerKey]  int   NOT NULL
,  [DateKey]  int   NOT NULL
,  [PaymentType]  nvarchar(50)   NOT NULL
,  [PaymentInstallments]  int   NOT NULL
,  [PaymentValue]  decimal(18,2)   NOT NULL
,  [InsertAuditKey]  int   NULL
,  [UpdateAuditKey]  int   NULL
, CONSTRAINT [PK_dbo.FactPayments] PRIMARY KEY NONCLUSTERED 
( [PaymentKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactPayments
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FactPayments', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactPayments
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[FactPayments]'))
DROP VIEW [MDWT].[FactPayments]
GO
CREATE VIEW [MDWT].[FactPayments] AS 
SELECT [PaymentKey] AS [PaymentKey]
, [OrderID] AS [OrderID]
, [CustomerKey] AS [CustomerKey]
, [ProductKey] AS [ProductKey]
, [SellerKey] AS [SellerKey]
, [DateKey] AS [PaymentDate]
, [PaymentType] AS [PaymentType]
, [PaymentInstallments] AS [Installments]
, [PaymentValue] AS [PaymentValue]
, [InsertAuditKey] AS [Insert Audit Key]
, [UpdateAuditKey] AS [Update Audit Key]
FROM dbo.FactPayments
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PaymentKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SellerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PaymentDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PaymentType', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentType'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Installments', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentInstallments'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PaymentValue', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentValue'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Insert Audit Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Update Audit Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business identifier for the order ', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Foreign key to DimCustomer representing the customer who made the payment', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Foreign key to DimProduct representing the purchased product', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Foreign key to DimSeller representing the vendor fulfilling the order', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Foreign key to DimDate indicating the date the payment was made', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Method of payment used by the customer (e.g. credit_card, boleto)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentType'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of installments chosen by the customer for the payment', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentInstallments'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Actual amount paid by the customer in the transaction', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentValue'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Audit dimension for row insertion', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Audit dimension for row update', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentType'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentInstallments'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentValue'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentType'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentInstallments'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentValue'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderPayments', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimCustomers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimProducts', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimSellers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderPayments', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentType'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderPayments', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentInstallments'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderPayments', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentValue'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'order_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'ProductKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'SellerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'SellerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'payment_type', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentType'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'payment_installments', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentInstallments'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'payment_value', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentValue'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentType'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentInstallments'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPayments', @level2type=N'COLUMN', @level2name=N'PaymentValue'; 
;





/* Drop table dbo.FactOrderFullFilment */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactOrderFullFilment') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactOrderFullFilment 
;

/* Create table dbo.FactOrderFullFilment */
CREATE TABLE dbo.FactOrderFullFilment (
   [OrderKey]  int IDENTITY  NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [OrderID]  varchar(50)   NOT NULL
,  [DeliveryTime]  int  DEFAULT NULL NULL
,  [DeliveryDelay]  int  DEFAULT NULL NULL
,  [AcceptTime]  int  DEFAULT NULL NULL
,  [OrderPurchaseTimestampKey]  int  DEFAULT -1 NOT NULL
,  [OrderApprovedAtKey]  int  DEFAULT -1 NOT NULL
,  [OrderDeliveredCarrierDateKey]  int  DEFAULT -1 NOT NULL
,  [OrderDeliveredCustomerDateKey]  int  DEFAULT -1 NOT NULL
,  [OrderDeliveredEstimateDateKey]  int  DEFAULT -1 NOT NULL
,  [RowStartDate]  datetime   NULL
,  [RowEndDate]  datetime  DEFAULT '9999-12-31' NOT NULL
, CONSTRAINT [PK_dbo.FactOrderFullFilment] PRIMARY KEY NONCLUSTERED 
( [OrderKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactOrderFullFilment
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Order Fulfillment Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactOrderFullFilment
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactOrderFullFilment
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Lưu trữ các chỉ số liên quan đến quá trình thực hiện đơn hàng: thời gian giao, độ trễ, …', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactOrderFullFilment
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Order Fulfillment Fact]'))
DROP VIEW [MDWT].[Order Fulfillment Fact]
GO
CREATE VIEW [MDWT].[Order Fulfillment Fact] AS 
SELECT [OrderKey] AS [Order Key]
, [CustomerKey] AS [Customer Key]
, [OrderID] AS [Order ID]
, [DeliveryTime] AS [Delivery Time]
, [DeliveryDelay] AS [Delivery Delay]
, [AcceptTime] AS [Accept Time]
, [OrderPurchaseTimestampKey] AS [Order Purchase Timestamp Key]
, [OrderApprovedAtKey] AS [Order Approved At Key]
, [OrderDeliveredCarrierDateKey] AS [Order Delivered Carrier Date Key]
, [OrderDeliveredCustomerDateKey] AS [Order Delivered Customer Date Key]
, [OrderDeliveredEstimateDateKey] AS [Order Delivered Estimate Date Key]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
FROM dbo.FactOrderFullFilment
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Order Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Customer Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Order ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Delivery Time', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'DeliveryTime'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Delivery Delay', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'DeliveryDelay'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Accept Time', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'AcceptTime'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Order Purchase Timestamp Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderPurchaseTimestampKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Order Approved At Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderApprovedAtKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Order Delivered Carrier Date Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredCarrierDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Order Delivered Customer Date Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredCustomerDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Order Delivered Estimate Date Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredEstimateDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Foreign key linking to the customer dimension.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Unique identifier for each order', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Actual time duration taken for the product to be delivered to the customer after approval.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'DeliveryTime'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of days the actual delivery was later or earlier than the estimated delivery date.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'DeliveryDelay'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Time taken for the system to approve the order after it was placed.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'AcceptTime'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Date key representing when the order was placed.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderPurchaseTimestampKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Date key representing when the order was approved.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderApprovedAtKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Date key representing when the product was handed over to the delivery carrier.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredCarrierDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Date key representing when the product was delivered to the customer.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredCustomerDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Date key representing the estimated delivery date.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredEstimateDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'007c7cb12ef3567531307ca78d395758…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'DeliveryTime'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'DeliveryDelay'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'AcceptTime'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20240115', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderPurchaseTimestampKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20240116', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderApprovedAtKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20240118', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredCarrierDateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20240120', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredCustomerDateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20240119', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredEstimateDateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'12/03/1989', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'Key lookup from OrderFullFilment.CurrencyRate.CurrencyRateDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'PK', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Foreign Keys', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Foreign Keys', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Measures', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'DeliveryTime'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Measures', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'DeliveryDelay'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Measures', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'AcceptTime'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Date Keys', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderPurchaseTimestampKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Date Keys', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderApprovedAtKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Date Keys', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredCarrierDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Date Keys', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredCustomerDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Date Keys', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredEstimateDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Lookup DimCustomer bằng customer_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Lookup OrderDataset, OrderItem bằng order_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'DATEDIFF (day) between order_delivered_customer_date & order_approved_at', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'DeliveryTime'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'DATEDIFF(day) between order_delivered_carrier_date & order_estimated_delivery_date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'DeliveryDelay'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'DATEDIFF (hour) between order_approved_at & order_purchase_timestamp', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'AcceptTime'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'CONVERT int từ FORMAT(order_purchase_timestamp, ''yyyyMMdd'')', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderPurchaseTimestampKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'CONVERT int từ FORMAT(order_approved_at, ''yyyyMMdd'')', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderApprovedAtKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'CONVERT int từ FORMAT(order_delivered_carrier_date, ''yyyyMMdd'')', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredCarrierDateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'CONVERT int từ FORMAT(order_delivered_customer_date, ''yyyyMMdd'')', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredCustomerDateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'CONVERT int từ FORMAT(order_estimated_delivery_date, ''yyyyMMdd'')', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredEstimateDateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Olist', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'DeliveryTime'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'DeliveryDelay'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'AcceptTime'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderPurchaseTimestampKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderApprovedAtKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredCarrierDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredCustomerDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderDeliveredEstimateDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderDataset', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'order_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrderFullFilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
;
ALTER TABLE dbo.DimAudit ADD CONSTRAINT
   FK_dbo_DimAudit_ParentAuditKey FOREIGN KEY
   (
   ParentAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimDate ADD CONSTRAINT
   FK_dbo_DimDate_InsertAuditKey FOREIGN KEY
   (
   InsertAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimDate ADD CONSTRAINT
   FK_dbo_DimDate_UpdateAuditKey FOREIGN KEY
   (
   UpdateAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimProducts ADD CONSTRAINT
   FK_dbo_DimProducts_InsertAuditKey FOREIGN KEY
   (
   InsertAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimProducts ADD CONSTRAINT
   FK_dbo_DimProducts_UpdateAuditKey FOREIGN KEY
   (
   UpdateAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimGeolocation ADD CONSTRAINT
   FK_dbo_DimGeolocation_InsertAuditKey FOREIGN KEY
   (
   InsertAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimGeolocation ADD CONSTRAINT
   FK_dbo_DimGeolocation_UpdateAuditKey FOREIGN KEY
   (
   UpdateAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimCustomers ADD CONSTRAINT
   FK_dbo_DimCustomers_InsertAuditKey FOREIGN KEY
   (
   InsertAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimCustomers ADD CONSTRAINT
   FK_dbo_DimCustomers_UpdateAuditKey FOREIGN KEY
   (
   UpdateAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSalesItem ADD CONSTRAINT
   FK_dbo_FactSalesItem_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomers
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSalesItem ADD CONSTRAINT
   FK_dbo_FactSalesItem_SellerKey FOREIGN KEY
   (
   SellerKey
   ) REFERENCES DimSellers
   ( SellerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSalesItem ADD CONSTRAINT
   FK_dbo_FactSalesItem_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES DimProducts
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSalesItem ADD CONSTRAINT
   FK_dbo_FactSalesItem_CustomerGeollocationKey FOREIGN KEY
   (
   CustomerGeollocationKey
   ) REFERENCES DimGeolocation
   ( GeolocationKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSalesItem ADD CONSTRAINT
   FK_dbo_FactSalesItem_SellerGeolocationKey FOREIGN KEY
   (
   SellerGeolocationKey
   ) REFERENCES DimGeolocation
   ( GeolocationKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSalesItem ADD CONSTRAINT
   FK_dbo_FactSalesItem_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSalesItem ADD CONSTRAINT
   FK_dbo_FactSalesItem_InsertAuditKey FOREIGN KEY
   (
   InsertAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSalesItem ADD CONSTRAINT
   FK_dbo_FactSalesItem_UpdateAuditKey FOREIGN KEY
   (
   UpdateAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactReview ADD CONSTRAINT
   FK_dbo_FactReview_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomers
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactReview ADD CONSTRAINT
   FK_dbo_FactReview_ReviewAnswerTimestampKey FOREIGN KEY
   (
   ReviewAnswerTimestampKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactReview ADD CONSTRAINT
   FK_dbo_FactReview_ReviewCreationDateKey FOREIGN KEY
   (
   ReviewCreationDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactReview ADD CONSTRAINT
   FK_dbo_FactReview_InsertAuditKey FOREIGN KEY
   (
   InsertAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactReview ADD CONSTRAINT
   FK_dbo_FactReview_UpdateAuditKey FOREIGN KEY
   (
   UpdateAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPayments ADD CONSTRAINT
   FK_dbo_FactPayments_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomers
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPayments ADD CONSTRAINT
   FK_dbo_FactPayments_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES DimProducts
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPayments ADD CONSTRAINT
   FK_dbo_FactPayments_SellerKey FOREIGN KEY
   (
   SellerKey
   ) REFERENCES DimSellers
   ( SellerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPayments ADD CONSTRAINT
   FK_dbo_FactPayments_DateKey FOREIGN KEY
   (
   DateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPayments ADD CONSTRAINT
   FK_dbo_FactPayments_InsertAuditKey FOREIGN KEY
   (
   InsertAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPayments ADD CONSTRAINT
   FK_dbo_FactPayments_UpdateAuditKey FOREIGN KEY
   (
   UpdateAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrderFullFilment ADD CONSTRAINT
   FK_dbo_FactOrderFullFilment_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomers
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrderFullFilment ADD CONSTRAINT
   FK_dbo_FactOrderFullFilment_OrderPurchaseTimestampKey FOREIGN KEY
   (
   OrderPurchaseTimestampKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrderFullFilment ADD CONSTRAINT
   FK_dbo_FactOrderFullFilment_OrderApprovedAtKey FOREIGN KEY
   (
   OrderApprovedAtKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrderFullFilment ADD CONSTRAINT
   FK_dbo_FactOrderFullFilment_OrderDeliveredCarrierDateKey FOREIGN KEY
   (
   OrderDeliveredCarrierDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrderFullFilment ADD CONSTRAINT
   FK_dbo_FactOrderFullFilment_OrderDeliveredCustomerDateKey FOREIGN KEY
   (
   OrderDeliveredCustomerDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrderFullFilment ADD CONSTRAINT
   FK_dbo_FactOrderFullFilment_OrderDeliveredEstimateDateKey FOREIGN KEY
   (
   OrderDeliveredEstimateDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
