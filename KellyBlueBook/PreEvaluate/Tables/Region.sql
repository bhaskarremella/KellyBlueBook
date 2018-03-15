CREATE TABLE [PreEvaluate].[Region] (
    [RegionId]              INT          NOT NULL,
    [DisplayName]           VARCHAR (25) NULL,
    [RegionTypeId]          INT          NULL,
    [RegionTypeDisplayName] VARCHAR (50) NULL,
    CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED ([RegionId] ASC) WITH (FILLFACTOR = 90)
);

