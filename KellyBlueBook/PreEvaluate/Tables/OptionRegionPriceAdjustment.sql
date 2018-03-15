CREATE TABLE [PreEvaluate].[OptionRegionPriceAdjustment] (
    [VehicleOptionId]     INT             NOT NULL,
    [VehicleTypeRegionId] INT             NOT NULL,
    [KBBVehicleId]        INT             NOT NULL,
    [PriceTypeId]         INT             NOT NULL,
    [PriceAdjustment]     DECIMAL (10, 2) NULL,
    [ValueTypeId]         INT             NULL,
    CONSTRAINT [PK_OptionRegionPriceAdjustment] PRIMARY KEY CLUSTERED ([VehicleOptionId] ASC, [VehicleTypeRegionId] ASC, [KBBVehicleId] ASC, [PriceTypeId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_OptionRegionPriceAdjustment_PriceType] FOREIGN KEY ([PriceTypeId]) REFERENCES [PreEvaluate].[PriceType] ([PriceTypeId]),
    CONSTRAINT [fk_OptionRegionPriceAdjustment_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [PreEvaluate].[KBBVehicle] ([KBBVehicleId]),
    CONSTRAINT [fk_OptionRegionPriceAdjustment_VehicleOption] FOREIGN KEY ([VehicleOptionId]) REFERENCES [PreEvaluate].[VehicleOption] ([VehicleOptionId]),
    CONSTRAINT [fk_OptionRegionPriceAdjustment_VehicleRegion] FOREIGN KEY ([VehicleTypeRegionId]) REFERENCES [PreEvaluate].[VehicleRegion] ([VehicleTypeRegionId])
);

