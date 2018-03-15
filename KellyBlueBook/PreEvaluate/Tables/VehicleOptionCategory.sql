CREATE TABLE [PreEvaluate].[VehicleOptionCategory] (
    [VehicleOptionId]               INT NOT NULL,
    [CategoryId]                    INT NOT NULL,
    [VehicleOptionCategorySequence] INT NULL,
    CONSTRAINT [PK_VehicleOptionCategory] PRIMARY KEY CLUSTERED ([VehicleOptionId] ASC, [CategoryId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_vehicleoptioncategory_Category] FOREIGN KEY ([CategoryId]) REFERENCES [PreEvaluate].[Category] ([CategoryId])
);


GO
CREATE NONCLUSTERED INDEX [idx_VehicleOptionCategory_VehicleOptionID_CategoryID]
    ON [PreEvaluate].[VehicleOptionCategory]([VehicleOptionId] ASC, [CategoryId] ASC) WITH (FILLFACTOR = 90);

