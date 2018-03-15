CREATE TABLE [PreEvaluate].[VehicleRegion] (
    [VehicleTypeRegionId] INT NOT NULL,
    [VehicleTypeId]       INT NULL,
    [RegionId]            INT NULL,
    CONSTRAINT [PK_VehicleRegion] PRIMARY KEY CLUSTERED ([VehicleTypeRegionId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_VehicleRegion_Region] FOREIGN KEY ([RegionId]) REFERENCES [PreEvaluate].[Region] ([RegionId])
);

