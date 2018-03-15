CREATE TABLE [PreEvaluate].[DataVersion] (
    [DataVersionId]  INT          NOT NULL,
    [ReleaseVersion] VARCHAR (25) NULL,
    [SchemaVersion]  VARCHAR (25) NULL,
    [VehicleTypeId]  INT          NOT NULL,
    [StartDate]      DATETIME     NULL,
    [EndDate]        DATETIME     NULL,
    [Edition]        VARCHAR (20) NULL,
    CONSTRAINT [PK_DataVersion] PRIMARY KEY CLUSTERED ([DataVersionId] ASC, [VehicleTypeId] ASC) WITH (FILLFACTOR = 90)
);

