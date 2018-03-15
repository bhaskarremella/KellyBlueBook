CREATE TABLE [dbo].[ZipCode] (
    [ZipCodeId] INT          NOT NULL,
    [ZipCode]   VARCHAR (10) NULL,
    CONSTRAINT [PK_ZipCode] PRIMARY KEY CLUSTERED ([ZipCodeId] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxZipCode_ZipCode]
    ON [dbo].[ZipCode]([ZipCode] ASC) WITH (FILLFACTOR = 90);

