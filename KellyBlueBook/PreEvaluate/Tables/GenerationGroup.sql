CREATE TABLE [PreEvaluate].[GenerationGroup] (
    [GenerationGroupId] INT          NOT NULL,
    [GenerationId]      INT          NULL,
    [Sequence]          SMALLINT     NULL,
    [BeginYear]         SMALLINT     NULL,
    [EndYear]           SMALLINT     NULL,
    [GenerationName]    VARCHAR (50) NULL,
    [MakeId]            INT          NULL,
    CONSTRAINT [PK_GenerationGroup] PRIMARY KEY CLUSTERED ([GenerationGroupId] ASC) WITH (FILLFACTOR = 90)
);

