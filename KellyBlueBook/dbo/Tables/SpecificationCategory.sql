﻿CREATE TABLE [dbo].[SpecificationCategory] (
    [SpecificationId] INT NOT NULL,
    [CategoryId]      INT NOT NULL,
    CONSTRAINT [PK_SpecificationCategory] PRIMARY KEY CLUSTERED ([SpecificationId] ASC, [CategoryId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_SpecificationCategory_Category] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([CategoryId]),
    CONSTRAINT [fk_SpecificationCategory_Specification] FOREIGN KEY ([SpecificationId]) REFERENCES [dbo].[Specification] ([SpecificationId])
);

