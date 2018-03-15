CREATE TABLE [dbo].[VINOptionEquipmentPattern] (
    [VINOptionEquipmentPatternId] INT          NOT NULL,
    [Pattern]                     VARCHAR (17) NULL,
    CONSTRAINT [PK_VINOptionEquipmentPattern] PRIMARY KEY CLUSTERED ([VINOptionEquipmentPatternId] ASC) WITH (FILLFACTOR = 90)
);

