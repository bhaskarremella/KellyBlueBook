CREATE TABLE [dbo].[EditorialText] (
    [ContentItemId]              INT          NOT NULL,
    [ContentId]                  INT          NULL,
    [ContentSectionId]           INT          NULL,
    [ContentItemTypeId]          INT          NULL,
    [ContentItemTypeDisplayName] VARCHAR (25) NULL,
    [Sequence]                   INT          NULL,
    [Text]                       TEXT         NULL,
    [HtmlText]                   TEXT         NULL,
    CONSTRAINT [PK_EditorialText] PRIMARY KEY CLUSTERED ([ContentItemId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_EditorialText_EditorialContent] FOREIGN KEY ([ContentId]) REFERENCES [dbo].[EditorialContent] ([ContentId]),
    CONSTRAINT [fk_EditorialText_EditorialSectionHeader] FOREIGN KEY ([ContentSectionId]) REFERENCES [dbo].[EditorialSectionHeader] ([ContentSectionId])
);

