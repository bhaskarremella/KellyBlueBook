CREATE TABLE [dbo].[VehicleCompetitiveSet] (
    [KBBVehicleId] INT NOT NULL,
    [CompetitorId] INT NOT NULL,
    [SortOrder]    INT NULL,
    CONSTRAINT [PK_VehicleCompetitiveSet] PRIMARY KEY CLUSTERED ([KBBVehicleId] ASC, [CompetitorId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_VehicleCompetitiveSet_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [dbo].[KBBVehicle] ([KBBVehicleId])
);

