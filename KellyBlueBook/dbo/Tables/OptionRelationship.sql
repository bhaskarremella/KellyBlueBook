CREATE TABLE [dbo].[OptionRelationship] (
    [VehicleOptionRelationshipId]       INT          NOT NULL,
    [ContextId]                         INT          NULL,
    [ContextDisplayName]                VARCHAR (25) NULL,
    [ContextValueId]                    INT          NULL,
    [OptionRelationshipTypeId]          INT          NULL,
    [OptionRelationshipTypeDisplayName] VARCHAR (50) NULL,
    [Sequence]                          INT          NULL,
    [GroupId]                           INT          NULL,
    CONSTRAINT [PK_OptionRelationship] PRIMARY KEY CLUSTERED ([VehicleOptionRelationshipId] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxOptionRelationship_ContextDisplayName_ContextValueId]
    ON [dbo].[OptionRelationship]([ContextDisplayName] ASC, [ContextValueId] ASC)
    INCLUDE([OptionRelationshipTypeId], [VehicleOptionRelationshipId]) WITH (FILLFACTOR = 90);

