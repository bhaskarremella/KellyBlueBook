CREATE TABLE [dbo].[ModelYear] (
    [ModelYearId]                INT            NOT NULL,
    [ModelId]                    INT            NULL,
    [YearId]                     INT            NULL,
    [Note]                       VARCHAR (1000) NULL,
    [EffectiveDate]              DATETIME       NULL,
    [EffectiveDateMissingReason] VARCHAR (50)   NULL,
    [RevisedFlag]                BIT            NULL,
    CONSTRAINT [PK_ModelYear] PRIMARY KEY CLUSTERED ([ModelYearId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_ModelYear_Model] FOREIGN KEY ([ModelId]) REFERENCES [dbo].[Model] ([ModelId]),
    CONSTRAINT [fk_ModelYear_Year] FOREIGN KEY ([YearId]) REFERENCES [dbo].[Year] ([YearId])
);

