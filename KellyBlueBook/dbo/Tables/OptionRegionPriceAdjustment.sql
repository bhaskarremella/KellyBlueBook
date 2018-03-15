CREATE TABLE [dbo].[OptionRegionPriceAdjustment] (
    [VehicleOptionId]     INT             NOT NULL,
    [VehicleTypeRegionId] INT             NOT NULL,
    [KBBVehicleId]        INT             NOT NULL,
    [PriceTypeId]         INT             NOT NULL,
    [PriceAdjustment]     DECIMAL (10, 2) NULL,
    [ValueTypeId]         INT             NULL,
    CONSTRAINT [PK_OptionRegionPriceAdjustment] PRIMARY KEY CLUSTERED ([VehicleOptionId] ASC, [VehicleTypeRegionId] ASC, [KBBVehicleId] ASC, [PriceTypeId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_OptionRegionPriceAdjustment_PriceType] FOREIGN KEY ([PriceTypeId]) REFERENCES [dbo].[PriceType] ([PriceTypeId]),
    CONSTRAINT [fk_OptionRegionPriceAdjustment_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [dbo].[KBBVehicle] ([KBBVehicleId]),
    CONSTRAINT [fk_OptionRegionPriceAdjustment_VehicleOption] FOREIGN KEY ([VehicleOptionId]) REFERENCES [dbo].[VehicleOption] ([VehicleOptionId]),
    CONSTRAINT [fk_OptionRegionPriceAdjustment_VehicleRegion] FOREIGN KEY ([VehicleTypeRegionId]) REFERENCES [dbo].[VehicleRegion] ([VehicleTypeRegionId])
);

