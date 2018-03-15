CREATE TABLE [PreEvaluate].[NewCarStandardEquipment] (
    [VehicleOptionId]  INT           NOT NULL,
    [EquipmentName]    VARCHAR (500) NULL,
    [EquipmentDetails] VARCHAR (500) NULL,
    CONSTRAINT [PK_NewCarStandardEquipment] PRIMARY KEY CLUSTERED ([VehicleOptionId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_NewCarStandardEquipment_VehicleOption] FOREIGN KEY ([VehicleOptionId]) REFERENCES [PreEvaluate].[VehicleOption] ([VehicleOptionId])
);

