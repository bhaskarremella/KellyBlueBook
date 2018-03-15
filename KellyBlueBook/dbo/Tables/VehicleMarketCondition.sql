CREATE TABLE [dbo].[VehicleMarketCondition] (
    [KBBVehicleId]                   INT            NOT NULL,
    [MarketConditionTypeId]          INT            NOT NULL,
    [MarketConditionTypeDisplayName] VARCHAR (50)   NULL,
    [Rating]                         DECIMAL (4, 1) NULL,
    [RatingText]                     VARCHAR (1000) NULL,
    CONSTRAINT [PK_VehicleMarketCondition] PRIMARY KEY CLUSTERED ([KBBVehicleId] ASC, [MarketConditionTypeId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_VehicleMarketCondition_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [dbo].[KBBVehicle] ([KBBVehicleId])
);

