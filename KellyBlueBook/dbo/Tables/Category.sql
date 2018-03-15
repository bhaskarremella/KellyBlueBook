--Testing
CREATE TABLE [dbo].[Category] (
    [CategoryId]              INT           NOT NULL,
    [CategoryTypeId]          INT           NULL,
    [CategoryTypeDisplayName] VARCHAR (25)  NULL,
    [DisplayName]             VARCHAR (50)  NULL,
    [SortOrder]               INT           NULL,
    [Note]                    VARCHAR (500) NULL,
    [ExclusivityFlag]         BIT           NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([CategoryId] ASC) WITH (FILLFACTOR = 90)
);

