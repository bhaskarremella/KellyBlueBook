CREATE TABLE [PreEvaluate].[OptionSpecificationValue] (
    [VehicleOptionId] INT           NOT NULL,
    [SpecificationId] INT           NOT NULL,
    [ValueIndex]      INT           NOT NULL,
    [Value]           VARCHAR (255) NULL,
    CONSTRAINT [PK_OptionSpecificationValue] PRIMARY KEY CLUSTERED ([VehicleOptionId] ASC, [SpecificationId] ASC, [ValueIndex] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_OptionSpecificationValue_Specification] FOREIGN KEY ([SpecificationId]) REFERENCES [PreEvaluate].[Specification] ([SpecificationId]),
    CONSTRAINT [fk_OptionSpecificationValue_VehicleOption] FOREIGN KEY ([VehicleOptionId]) REFERENCES [PreEvaluate].[VehicleOption] ([VehicleOptionId])
);

