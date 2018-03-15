CREATE TABLE [PreEvaluate].[EditorialContext] (
    [ContentId]          INT          NOT NULL,
    [ContextId]          INT          NOT NULL,
    [ContextValueId]     INT          NOT NULL,
    [ContextDisplayName] VARCHAR (25) NULL,
    CONSTRAINT [PK_EditorialContext] PRIMARY KEY CLUSTERED ([ContentId] ASC, [ContextId] ASC, [ContextValueId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_EditorialContext_EditorialContent] FOREIGN KEY ([ContentId]) REFERENCES [PreEvaluate].[EditorialContent] ([ContentId])
);

