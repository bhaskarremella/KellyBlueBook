CREATE TABLE [dbo].[VehicleNote] (
    [NoteTypeId]    INT            NOT NULL,
    [KBBVehicleId]  INT            NOT NULL,
    [DisplayName]   VARCHAR (50)   NULL,
    [VehicleTypeId] INT            NULL,
    [Note]          VARCHAR (1000) NULL,
    CONSTRAINT [PK_VehicleNote] PRIMARY KEY CLUSTERED ([NoteTypeId] ASC, [KBBVehicleId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_VehicleNote_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [dbo].[KBBVehicle] ([KBBVehicleId])
);

