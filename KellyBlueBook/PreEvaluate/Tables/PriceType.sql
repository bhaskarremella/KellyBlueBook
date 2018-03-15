CREATE TABLE [PreEvaluate].[PriceType] (
    [PriceTypeId] INT          NOT NULL,
    [DisplayName] VARCHAR (50) NULL,
    CONSTRAINT [PK_PriceType] PRIMARY KEY CLUSTERED ([PriceTypeId] ASC) WITH (FILLFACTOR = 90)
);

