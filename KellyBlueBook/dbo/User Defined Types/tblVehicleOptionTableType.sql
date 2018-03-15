CREATE TYPE [dbo].[tblVehicleOptionTableType] AS TABLE (
    [RequestID]       INT NOT NULL,
    [VehicleOptionID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([RequestID] ASC, [VehicleOptionID] ASC) WITH (IGNORE_DUP_KEY = ON));

