CREATE TABLE [PreEvaluate].[ModelYearCategoryNote] (
    [ModelYearID] INT           NOT NULL,
    [CategoryId]  INT           NOT NULL,
    [Note]        VARCHAR (500) NULL,
    CONSTRAINT [PK_ModelYearCategoryNote] PRIMARY KEY CLUSTERED ([ModelYearID] ASC, [CategoryId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_ModelYearCategoryNote_Category] FOREIGN KEY ([CategoryId]) REFERENCES [PreEvaluate].[Category] ([CategoryId]),
    CONSTRAINT [fk_ModelYearCategoryNote_ModelYear] FOREIGN KEY ([ModelYearID]) REFERENCES [PreEvaluate].[ModelYear] ([ModelYearId])
);

