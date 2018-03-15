CREATE TABLE [PreEvaluate].[OptionSpecificationSetItem] (
    [VehicleOptionSetId] INT NOT NULL,
    [VehicleOptionId]    INT NOT NULL,
    CONSTRAINT [PK_OptionSpecificationSetItem] PRIMARY KEY CLUSTERED ([VehicleOptionSetId] ASC, [VehicleOptionId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_OptionSpecificationSetItem_OptionSpecificationSet] FOREIGN KEY ([VehicleOptionSetId]) REFERENCES [PreEvaluate].[OptionSpecificationSet] ([VehicleOptionSetId]),
    CONSTRAINT [fk_OptionSpecificationSetItem_VehicleOption] FOREIGN KEY ([VehicleOptionId]) REFERENCES [PreEvaluate].[VehicleOption] ([VehicleOptionId])
);

