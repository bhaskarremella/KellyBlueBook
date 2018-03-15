CREATE TYPE [dbo].[tblVehicleTableType] AS TABLE (
    [RequestID]     INT NOT NULL,
    [KBBVehicleID]  INT NOT NULL,
    [Mileage]       INT NOT NULL,
    [PricingTypeID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([RequestID] ASC) WITH (IGNORE_DUP_KEY = ON));

