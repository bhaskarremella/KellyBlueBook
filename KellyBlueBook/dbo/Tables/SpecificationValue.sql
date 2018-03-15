CREATE TABLE [dbo].[SpecificationValue] (
    [KBBVehicleId]    INT           NOT NULL,
    [SpecificationId] INT           NOT NULL,
    [ValueIndex]      INT           NOT NULL,
    [Value]           VARCHAR (255) NULL,
    CONSTRAINT [PK_SpecificationValue] PRIMARY KEY CLUSTERED ([KBBVehicleId] ASC, [SpecificationId] ASC, [ValueIndex] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_SpecificationValue_Specification] FOREIGN KEY ([SpecificationId]) REFERENCES [dbo].[Specification] ([SpecificationId]),
    CONSTRAINT [fk_SpecificationValue_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [dbo].[KBBVehicle] ([KBBVehicleId])
);

