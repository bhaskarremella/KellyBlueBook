CREATE TABLE [label].[OptionGroup] (
    [OptionGroupId] INT           IDENTITY (1, 1) NOT NULL,
    [SortOrder]     INT           NOT NULL,
    [Label]         VARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([OptionGroupId] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idx_OptionGroup_SortOrder]
    ON [label].[OptionGroup]([SortOrder] ASC)
    INCLUDE([Label]) WITH (FILLFACTOR = 90);

