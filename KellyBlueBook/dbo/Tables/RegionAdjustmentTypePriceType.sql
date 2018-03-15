CREATE TABLE [dbo].[RegionAdjustmentTypePriceType] (
    [RegionAdjustmentTypeId] INT          NOT NULL,
    [PriceTypeId]            INT          NOT NULL,
    [DisplayName]            VARCHAR (50) NULL,
    CONSTRAINT [PK_RegionAdjustmentTypePriceType] PRIMARY KEY CLUSTERED ([RegionAdjustmentTypeId] ASC, [PriceTypeId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_RegionAdjustmentTypePriceType_PriceType] FOREIGN KEY ([PriceTypeId]) REFERENCES [dbo].[PriceType] ([PriceTypeId])
);

