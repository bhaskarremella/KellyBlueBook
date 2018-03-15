CREATE TABLE [dbo].[VehicleGroup] (
    [KBBVehicleId]         INT           NOT NULL,
    [GroupId]              INT           NOT NULL,
    [DisplayName]          VARCHAR (100) NULL,
    [GroupTypeId]          INT           NULL,
    [GroupTypeDisplayName] VARCHAR (50)  NULL,
    CONSTRAINT [PK_VehicleGroup] PRIMARY KEY CLUSTERED ([KBBVehicleId] ASC, [GroupId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_VehicleGroup_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [dbo].[KBBVehicle] ([KBBVehicleId])
);

