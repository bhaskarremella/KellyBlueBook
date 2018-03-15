CREATE TABLE [dbo].[RegionBasePrice] (
    [KBBVehicleId]        INT             NOT NULL,
    [VehicleTypeRegionId] INT             NOT NULL,
    [PriceTypeId]         INT             NOT NULL,
    [Price]               DECIMAL (10, 2) NULL,
    CONSTRAINT [PK_RegionBasePrice] PRIMARY KEY CLUSTERED ([KBBVehicleId] ASC, [VehicleTypeRegionId] ASC, [PriceTypeId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_RegionBasePrice_PriceType] FOREIGN KEY ([PriceTypeId]) REFERENCES [dbo].[PriceType] ([PriceTypeId]),
    CONSTRAINT [fk_RegionBasePrice_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [dbo].[KBBVehicle] ([KBBVehicleId]),
    CONSTRAINT [fk_RegionBasePrice_VehicleRegion] FOREIGN KEY ([VehicleTypeRegionId]) REFERENCES [dbo].[VehicleRegion] ([VehicleTypeRegionId]),
    CONSTRAINT [fk_VehiclePriceRange_PriceType] FOREIGN KEY ([PriceTypeId]) REFERENCES [dbo].[PriceType] ([PriceTypeId])
);

