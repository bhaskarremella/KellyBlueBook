CREATE TABLE [dbo].[EditorialGroup] (
    [ContentRelationshipId]          INT          NOT NULL,
    [ContentId]                      INT          NULL,
    [ContentRelationshipTypeId]      INT          NULL,
    [ContentRelationshipTypeDisplay] VARCHAR (25) NULL,
    [RelatedContentId]               INT          NULL,
    [Sequence]                       INT          NULL,
    CONSTRAINT [PK_EditorialGroup] PRIMARY KEY CLUSTERED ([ContentRelationshipId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_EditorialGroup_EditorialContent] FOREIGN KEY ([ContentId]) REFERENCES [dbo].[EditorialContent] ([ContentId])
);

