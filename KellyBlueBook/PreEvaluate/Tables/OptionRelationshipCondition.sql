CREATE TABLE [PreEvaluate].[OptionRelationshipCondition] (
    [VehicleOptionRelationshipConditionId]       INT          NOT NULL,
    [VehicleOptionRelationshipId]                INT          NULL,
    [Sequence]                                   INT          NULL,
    [GroupId]                                    INT          NULL,
    [OptionRelationshipConditionTypeId]          INT          NULL,
    [OptionRelationshipConditionTypeDisplayName] VARCHAR (50) NULL,
    CONSTRAINT [PK_OptionRelationshipCondition] PRIMARY KEY CLUSTERED ([VehicleOptionRelationshipConditionId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_OptionRelationshipCondition_OptionRelationship] FOREIGN KEY ([VehicleOptionRelationshipId]) REFERENCES [PreEvaluate].[OptionRelationship] ([VehicleOptionRelationshipId])
);

