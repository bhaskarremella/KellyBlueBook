CREATE TABLE [dbo].[VINVehiclePattern] (
    [YearId]       INT          NOT NULL,
    [MakeId]       INT          NOT NULL,
    [Pattern]      VARCHAR (17) NOT NULL,
    [KBBVehicleId] INT          NOT NULL,
    CONSTRAINT [PK_VINVehiclePattern] PRIMARY KEY CLUSTERED ([YearId] ASC, [KBBVehicleId] ASC, [MakeId] ASC, [Pattern] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_VINVehiclePattern_Make] FOREIGN KEY ([MakeId]) REFERENCES [dbo].[Make] ([MakeId]),
    CONSTRAINT [fk_VINVehiclePattern_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [dbo].[KBBVehicle] ([KBBVehicleId]),
    CONSTRAINT [fk_VINVehiclePattern_Year] FOREIGN KEY ([YearId]) REFERENCES [dbo].[Year] ([YearId])
);


GO
CREATE NONCLUSTERED INDEX [idx_VINVehiclePattern_Pattern]
    ON [dbo].[VINVehiclePattern]([KBBVehicleId] ASC, [Pattern] ASC) WITH (FILLFACTOR = 90);

