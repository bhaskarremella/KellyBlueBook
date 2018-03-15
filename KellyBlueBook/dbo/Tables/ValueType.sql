CREATE TABLE [dbo].[ValueType] (
    [ValueTypeId] INT          NOT NULL,
    [DisplayName] VARCHAR (50) NULL,
    CONSTRAINT [PK_ValueType] PRIMARY KEY CLUSTERED ([ValueTypeId] ASC) WITH (FILLFACTOR = 90)
);

