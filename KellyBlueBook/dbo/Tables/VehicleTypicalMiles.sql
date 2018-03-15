CREATE TABLE [dbo].[VehicleTypicalMiles] (
    [KBBVehicleId] INT NOT NULL,
    [TypicalMiles] INT NOT NULL,
    CONSTRAINT [PK_VehicleTypicalMiles] PRIMARY KEY CLUSTERED ([KBBVehicleId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_VehicleTypicalMiles_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [dbo].[KBBVehicle] ([KBBVehicleId])
);

