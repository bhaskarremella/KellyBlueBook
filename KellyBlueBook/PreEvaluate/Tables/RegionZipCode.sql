CREATE TABLE [PreEvaluate].[RegionZipCode] (
    [RegionId]              INT          NOT NULL,
    [ZipCodeId]             INT          NOT NULL,
    [RegionTypeId]          INT          NULL,
    [RegionTypeDisplayName] VARCHAR (50) NULL,
    CONSTRAINT [PK_RegionZipCode] PRIMARY KEY CLUSTERED ([RegionId] ASC, [ZipCodeId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_RegionZipCode_Region] FOREIGN KEY ([RegionId]) REFERENCES [PreEvaluate].[Region] ([RegionId]),
    CONSTRAINT [fk_RegionZipCode_ZipCode] FOREIGN KEY ([ZipCodeId]) REFERENCES [PreEvaluate].[ZipCode] ([ZipCodeId])
);


GO
CREATE NONCLUSTERED INDEX [idxRegionZipCode_ZipCodeId]
    ON [PreEvaluate].[RegionZipCode]([ZipCodeId] ASC)
    INCLUDE([RegionId]) WITH (FILLFACTOR = 90);

