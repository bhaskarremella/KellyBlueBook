CREATE TABLE [dbo].[NCBBRule] (
    [KBBVehicleId]            INT             NOT NULL,
    [AvailableFlag]           BIT             NULL,
    [PriceTypeId]             INT             NULL,
    [DescriptionContentId]    INT             NULL,
    [Percentage]              DECIMAL (9, 4)  NULL,
    [RangePercentage]         DECIMAL (9, 4)  NULL,
    [NCBBRuleTypeId]          INT             NULL,
    [NCBBRuleTypeDiplsayName] VARCHAR (50)    NULL,
    [RangeLow]                DECIMAL (18, 4) NULL,
    [RangeHigh]               DECIMAL (18, 4) NULL,
    CONSTRAINT [PK_NCBBRule] PRIMARY KEY CLUSTERED ([KBBVehicleId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_NCBBRule_EditorialContent] FOREIGN KEY ([DescriptionContentId]) REFERENCES [dbo].[EditorialContent] ([ContentId]),
    CONSTRAINT [fk_NCBBRule_PriceType] FOREIGN KEY ([PriceTypeId]) REFERENCES [dbo].[PriceType] ([PriceTypeId]),
    CONSTRAINT [fk_NCBBRule_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [dbo].[KBBVehicle] ([KBBVehicleId])
);

