CREATE TABLE [PreEvaluate].[CategoryRelationship] (
    [ParentCategoryId] INT NOT NULL,
    [ChildCategoryId]  INT NOT NULL,
    CONSTRAINT [PK_CategoryRelationship] PRIMARY KEY CLUSTERED ([ParentCategoryId] ASC, [ChildCategoryId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_CategoryRelationship_ChildCategory] FOREIGN KEY ([ChildCategoryId]) REFERENCES [PreEvaluate].[Category] ([CategoryId]),
    CONSTRAINT [fk_CategoryRelationship_ParentCategory] FOREIGN KEY ([ParentCategoryId]) REFERENCES [PreEvaluate].[Category] ([CategoryId])
);

