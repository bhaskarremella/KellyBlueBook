CREATE TABLE [dbo].[GenerationTrim] (
    [GenerationGroupId] INT NOT NULL,
    [TrimId]            INT NOT NULL,
    CONSTRAINT [PK_GenerationTrim] PRIMARY KEY CLUSTERED ([GenerationGroupId] ASC, [TrimId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_GenerationTrim_GenerationGroup] FOREIGN KEY ([GenerationGroupId]) REFERENCES [dbo].[GenerationGroup] ([GenerationGroupId]),
    CONSTRAINT [fk_GenerationTrim_Trim] FOREIGN KEY ([TrimId]) REFERENCES [dbo].[Trim] ([TrimId])
);

