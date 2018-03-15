CREATE TABLE [PreEvaluate].[Specification] (
    [SpecificationId]              INT          NOT NULL,
    [SpecificationTypeId]          INT          NULL,
    [SpecificationTypeDisplayName] VARCHAR (50) NULL,
    [DisplayName]                  VARCHAR (50) NULL,
    [Units]                        VARCHAR (50) NULL,
    CONSTRAINT [PK_Specification] PRIMARY KEY CLUSTERED ([SpecificationId] ASC) WITH (FILLFACTOR = 90)
);

