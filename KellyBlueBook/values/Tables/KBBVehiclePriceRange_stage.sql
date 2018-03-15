CREATE TABLE [values].[KBBVehiclePriceRange_stage] (
    [KBBVehicleId] INT   NOT NULL,
    [PriceTypeId]  INT   NOT NULL,
    [RegionId]     INT   NOT NULL,
    [PriceLow]     MONEY NULL,
    [PriceHigh]    MONEY NULL,
    CONSTRAINT [PK_VehiclePriceRange_2] PRIMARY KEY CLUSTERED ([KBBVehicleId] ASC, [PriceTypeId] ASC, [RegionId] ASC) WITH (FILLFACTOR = 90)
);

