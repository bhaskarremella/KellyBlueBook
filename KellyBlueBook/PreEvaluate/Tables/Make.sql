CREATE TABLE [PreEvaluate].[Make] (
    [MakeId]      INT          NOT NULL,
    [DisplayName] VARCHAR (30) NULL,
    CONSTRAINT [PK_Make] PRIMARY KEY CLUSTERED ([MakeId] ASC) WITH (FILLFACTOR = 90)
);

