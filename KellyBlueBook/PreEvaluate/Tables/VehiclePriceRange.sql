CREATE TABLE [PreEvaluate].[VehiclePriceRange] (
    [KBBVehicleId] INT             NOT NULL,
    [PriceTypeId]  INT             NOT NULL,
    [RangeLow]     DECIMAL (18, 4) NULL,
    [RangeHigh]    DECIMAL (18, 4) NULL,
    CONSTRAINT [PK_VehiclePriceRange] PRIMARY KEY CLUSTERED ([KBBVehicleId] ASC, [PriceTypeId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_VehiclePriceRange_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [PreEvaluate].[KBBVehicle] ([KBBVehicleId])
);

