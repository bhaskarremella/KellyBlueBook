CREATE TABLE [PreEvaluate].[ProgramContext] (
    [ContextId]          INT            NOT NULL,
    [ContextValueId]     INT            NOT NULL,
    [ContextDisplayName] VARCHAR (25)   NULL,
    [DisplayName]        VARCHAR (200)  NULL,
    [Attribute]          VARCHAR (3000) NULL,
    [AttributeValue]     VARCHAR (3000) NULL,
    CONSTRAINT [PK_ProgramContext] PRIMARY KEY CLUSTERED ([ContextId] ASC, [ContextValueId] ASC) WITH (FILLFACTOR = 90)
);

