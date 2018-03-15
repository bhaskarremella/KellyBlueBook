CREATE TABLE [PreEvaluate].[MileageGroupAdjustment] (
    [MileageRangeId]            INT             NOT NULL,
    [MileageGroupId]            INT             NOT NULL,
    [MileageGroupDisplayName]   VARCHAR (255)   NULL,
    [Adjustment]                DECIMAL (18, 6) NULL,
    [AdjustmentTypeId]          INT             NULL,
    [AdjustmentTypeDisplayName] VARCHAR (25)    NULL,
    CONSTRAINT [PK_MileageGroupAdjustment] PRIMARY KEY CLUSTERED ([MileageRangeId] ASC, [MileageGroupId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_MileageGroupAdjustment_MileageRange] FOREIGN KEY ([MileageRangeId]) REFERENCES [PreEvaluate].[MileageRange] ([MileageRangeId])
);

