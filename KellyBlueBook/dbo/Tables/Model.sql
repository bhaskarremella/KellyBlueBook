CREATE TABLE [dbo].[Model] (
    [ModelId]     INT          NOT NULL,
    [DisplayName] VARCHAR (50) NULL,
    [Description] VARCHAR (50) NULL,
    [MakeId]      INT          NULL,
    [SortOrder]   INT          NULL,
    [MarketName]  VARCHAR (50) NULL,
    [ShortName]   VARCHAR (50) NULL,
    CONSTRAINT [PK_Model] PRIMARY KEY CLUSTERED ([ModelId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_Model_Make] FOREIGN KEY ([MakeId]) REFERENCES [dbo].[Make] ([MakeId])
);

