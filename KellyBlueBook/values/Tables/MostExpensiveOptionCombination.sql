CREATE TABLE [values].[MostExpensiveOptionCombination] (
    [KBBVehicleId] INT NOT NULL,
    [OptionId]     INT NOT NULL,
    [PriceTypeId]  INT NOT NULL,
    CONSTRAINT [PK_tblMostExpensiveOptionCombination] PRIMARY KEY CLUSTERED ([KBBVehicleId] ASC, [OptionId] ASC, [PriceTypeId] ASC) WITH (FILLFACTOR = 90)
);

