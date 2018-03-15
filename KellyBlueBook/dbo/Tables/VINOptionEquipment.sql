CREATE TABLE [dbo].[VINOptionEquipment] (
    [VINOptionEquipmentPatternId] INT NOT NULL,
    [KBBVehicleId]                INT NOT NULL,
    [VehicleOptionId]             INT NOT NULL,
    CONSTRAINT [PK_VINOptionEquipment] PRIMARY KEY CLUSTERED ([VINOptionEquipmentPatternId] ASC, [KBBVehicleId] ASC, [VehicleOptionId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_VINOptionEquipment_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [dbo].[KBBVehicle] ([KBBVehicleId]),
    CONSTRAINT [fk_VINOptionEquipment_VehicleOption] FOREIGN KEY ([VehicleOptionId]) REFERENCES [dbo].[VehicleOption] ([VehicleOptionId]),
    CONSTRAINT [fk_VINOptionEquipment_VINOptionEquipmentPattern] FOREIGN KEY ([VINOptionEquipmentPatternId]) REFERENCES [dbo].[VINOptionEquipmentPattern] ([VINOptionEquipmentPatternId])
);

