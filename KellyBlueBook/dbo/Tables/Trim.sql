CREATE TABLE [dbo].[Trim] (
    [TrimId]      INT           NOT NULL,
    [ModelId]     INT           NULL,
    [YearId]      INT           NULL,
    [DisplayName] VARCHAR (255) NULL,
    [SortOrder]   INT           NULL,
    [TrimName]    VARCHAR (255) NULL,
    CONSTRAINT [PK_Trim] PRIMARY KEY CLUSTERED ([TrimId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_Trim_Model] FOREIGN KEY ([ModelId]) REFERENCES [dbo].[Model] ([ModelId]),
    CONSTRAINT [fk_Trim_Year] FOREIGN KEY ([YearId]) REFERENCES [dbo].[Year] ([YearId])
);

