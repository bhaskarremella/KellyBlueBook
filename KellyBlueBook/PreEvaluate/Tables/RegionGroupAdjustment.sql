CREATE TABLE [PreEvaluate].[RegionGroupAdjustment] (
    [RegionId]                     INT             NOT NULL,
    [GroupId]                      INT             NOT NULL,
    [RegionAdjustmentTypeId]       INT             NOT NULL,
    [Adjustment]                   DECIMAL (18, 4) NULL,
    [AdjustmentTypeId]             INT             NULL,
    [AdjustmentTypeDisplayName]    VARCHAR (25)    NULL,
    [AdjustmentTypeRoundingTypeId] INT             NULL,
    CONSTRAINT [PK_RegionGroupAdjustment] PRIMARY KEY CLUSTERED ([RegionId] ASC, [GroupId] ASC, [RegionAdjustmentTypeId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_RegionGroupAdjustment_Region] FOREIGN KEY ([RegionId]) REFERENCES [PreEvaluate].[Region] ([RegionId])
);

