CREATE TABLE [PreEvaluate].[EditorialContent] (
    [ContentId]              INT          NOT NULL,
    [ContentTypeId]          INT          NULL,
    [ContentTypeDisplayName] VARCHAR (50) NULL,
    [Sequence]               INT          NULL,
    CONSTRAINT [PK_EditorialContent] PRIMARY KEY CLUSTERED ([ContentId] ASC) WITH (FILLFACTOR = 90)
);

