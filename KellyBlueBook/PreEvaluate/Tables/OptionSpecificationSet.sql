CREATE TABLE [PreEvaluate].[OptionSpecificationSet] (
    [VehicleOptionSetId] INT NOT NULL,
    [KBBVehicleId]       INT NULL,
    CONSTRAINT [PK_OptionSpecificationSet] PRIMARY KEY CLUSTERED ([VehicleOptionSetId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_OptionSpecificationSet_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [PreEvaluate].[KBBVehicle] ([KBBVehicleId])
);

