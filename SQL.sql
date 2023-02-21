-- Create a new table called 'ImageData' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.ImageData', 'U') IS NOT NULL
DROP TABLE dbo.ImageData
GO
-- Create the table in the specified schema
CREATE TABLE dbo.ImageData
(
    IndexVal INT NOT NULL PRIMARY KEY, -- primary key column
    LibraryID [NVARCHAR](53)  NOT NULL,
    LibraryIDShort [NVARCHAR](25)  NOT NULL,
    Polymer [NVARCHAR](50) NOT NULL,
    Colour [NVARCHAR](53)  NOT NULL,
    Morphology [NVARCHAR](53)  NOT NULL,
    Source [NVARCHAR](53)  NOT NULL,
    SourceType [NVARCHAR](53)  NOT NULL,
    Laser [INT](53)  NOT NULL,
    Grating [INT](53)  NOT NULL,
    HoleSize [INT](53)  NOT NULL,
    AvgTime [INT](53)  NOT NULL,
    Accumulation [INT](53)  NOT NULL,
    DelayTime [INT](53)  NOT NULL
);
GO
