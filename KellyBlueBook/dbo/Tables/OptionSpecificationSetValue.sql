﻿CREATE TABLE [dbo].[OptionSpecificationSetValue] (
    [VehicleOptionSetId] INT           NOT NULL,
    [SpecificationId]    INT           NOT NULL,
    [ValueIndex]         INT           NOT NULL,
    [Value]              VARCHAR (255) NULL,
    CONSTRAINT [PK_OptionSpecificationSetValue] PRIMARY KEY CLUSTERED ([VehicleOptionSetId] ASC, [SpecificationId] ASC, [ValueIndex] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_OptionSpecificationSetValue_OptionSpecificationSet] FOREIGN KEY ([VehicleOptionSetId]) REFERENCES [dbo].[OptionSpecificationSet] ([VehicleOptionSetId]),
    CONSTRAINT [fk_OptionSpecificationSetValue_Specification] FOREIGN KEY ([SpecificationId]) REFERENCES [dbo].[Specification] ([SpecificationId])
);

