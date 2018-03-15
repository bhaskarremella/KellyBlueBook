﻿CREATE TABLE [dbo].[VehicleCategory] (
    [CategoryId]              INT NOT NULL,
    [KBBVehicleId]            INT NOT NULL,
    [VehicleCategorySequence] INT NULL,
    CONSTRAINT [PK_VehicleCategory] PRIMARY KEY CLUSTERED ([CategoryId] ASC, [KBBVehicleId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_VehicleCategory_Category] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([CategoryId]),
    CONSTRAINT [fk_VehicleCategory_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [dbo].[KBBVehicle] ([KBBVehicleId])
);

