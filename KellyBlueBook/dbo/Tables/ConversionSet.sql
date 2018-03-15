CREATE TABLE [dbo].[ConversionSet] (
    [ConversionSetId]  INT          NOT NULL,
    [UCRelaseVersion]  VARCHAR (25) NULL,
    [NCReleaseVersion] VARCHAR (25) NULL,
    CONSTRAINT [PK_ConversionSet] PRIMARY KEY CLUSTERED ([ConversionSetId] ASC) WITH (FILLFACTOR = 90)
);

