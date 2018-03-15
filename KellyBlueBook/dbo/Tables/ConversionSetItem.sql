CREATE TABLE [dbo].[ConversionSetItem] (
    [ConversionRuleId]   INT NOT NULL,
    [ConversionSetId]    INT NULL,
    [VehicleTypeId]      INT NULL,
    [OldKBBVehicleId]    INT NULL,
    [OldVehicleOptionId] INT NULL,
    [NewKBBVehicleId]    INT NULL,
    [NewVehicleOptionId] INT NULL,
    CONSTRAINT [PK_ConversionSetItem] PRIMARY KEY CLUSTERED ([ConversionRuleId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_ConversionSetItem_ConversionSet] FOREIGN KEY ([ConversionSetId]) REFERENCES [dbo].[ConversionSet] ([ConversionSetId])
);

