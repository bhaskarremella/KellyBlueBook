CREATE TABLE [PreEvaluate].[OptionRelationshipSet] (
    [VehicleOptionRelationshipId] INT          NOT NULL,
    [ContextId]                   INT          NOT NULL,
    [ContextValueId]              INT          NOT NULL,
    [ContextDisplayName]          VARCHAR (25) NULL,
    [ExcludeFlag]                 BIT          NULL,
    CONSTRAINT [PK_OptionRelationshipSet] PRIMARY KEY CLUSTERED ([VehicleOptionRelationshipId] ASC, [ContextId] ASC, [ContextValueId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_OptionRelationshipSet_OptionRelationship] FOREIGN KEY ([VehicleOptionRelationshipId]) REFERENCES [PreEvaluate].[OptionRelationship] ([VehicleOptionRelationshipId])
);

