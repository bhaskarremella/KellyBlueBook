CREATE TABLE [dbo].[OptionRelationshipConditionSet] (
    [VehicleOptionRelationshipConditionId] INT          NOT NULL,
    [ContextId]                            INT          NOT NULL,
    [ContextValueId]                       INT          NOT NULL,
    [ContextDisplayName]                   VARCHAR (25) NULL,
    [ExcludeFlag]                          BIT          NULL,
    CONSTRAINT [PK_OptionRelationshipConditionSet] PRIMARY KEY CLUSTERED ([VehicleOptionRelationshipConditionId] ASC, [ContextId] ASC, [ContextValueId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_OptionRelationshipConditionSet_OptionRelationshipCondition] FOREIGN KEY ([VehicleOptionRelationshipConditionId]) REFERENCES [dbo].[OptionRelationshipCondition] ([VehicleOptionRelationshipConditionId])
);

