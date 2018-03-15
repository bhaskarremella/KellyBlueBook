CREATE TABLE [dbo].[Year] (
    [YearId]                     INT            NOT NULL,
    [DisplayName]                VARCHAR (25)   NULL,
    [VINCode]                    CHAR (1)       NULL,
    [MileageZeroPoint]           INT            NULL,
    [MaximumDeductionPercentage] DECIMAL (2, 1) NULL,
    CONSTRAINT [PK_Year] PRIMARY KEY CLUSTERED ([YearId] ASC) WITH (FILLFACTOR = 90)
);

