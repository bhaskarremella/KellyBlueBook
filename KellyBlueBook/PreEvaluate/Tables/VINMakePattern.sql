CREATE TABLE [PreEvaluate].[VINMakePattern] (
    [YearId]  INT          NOT NULL,
    [Pattern] VARCHAR (17) NOT NULL,
    [MakeId]  INT          NOT NULL,
    CONSTRAINT [PK_VINMakePattern] PRIMARY KEY CLUSTERED ([YearId] ASC, [MakeId] ASC, [Pattern] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_VINMakePattern_Make] FOREIGN KEY ([MakeId]) REFERENCES [PreEvaluate].[Make] ([MakeId]),
    CONSTRAINT [fk_VINMakePattern_Year] FOREIGN KEY ([YearId]) REFERENCES [PreEvaluate].[Year] ([YearId])
);

