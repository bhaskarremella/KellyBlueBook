CREATE TABLE [dbo].[EditorialSectionHeader] (
    [ContentSectionId]              INT           NOT NULL,
    [ContentSectionTypeId]          INT           NULL,
    [ContentSectionTypeDisplayName] VARCHAR (25)  NULL,
    [DisplayName]                   VARCHAR (255) NULL,
    [HtmlDisplayName]               VARCHAR (255) NULL,
    [Sequence]                      INT           NULL,
    CONSTRAINT [PK_EditorialSectionHeader] PRIMARY KEY CLUSTERED ([ContentSectionId] ASC) WITH (FILLFACTOR = 90)
);

