CREATE TABLE [dbo].[MileageRange] (
    [MileageRangeId] INT NOT NULL,
    [YearId]         INT NULL,
    [VehicleTypeId]  INT NULL,
    [MileageMin]     INT NULL,
    [MileageMax]     INT NULL,
    CONSTRAINT [PK_MilageRange] PRIMARY KEY CLUSTERED ([MileageRangeId] ASC) WITH (FILLFACTOR = 90)
);

