CREATE TABLE [dbo].[VehicleOption] (
    [VehicleOptionId]                INT            NOT NULL,
    [OptionTypeId]                   INT            NULL,
    [OptionTypeDisplayName]          VARCHAR (50)   NULL,
    [DisplayName]                    VARCHAR (200)  NULL,
    [DisplayNameAdditionalData]      VARCHAR (2000) NULL,
    [ManufacturerAssignedOptionCode] VARCHAR (50)   NULL,
    [OptionAvailabilityId]           INT            NULL,
    [OptionAvailabilityDisplayName]  VARCHAR (15)   NULL,
    [OptionAvailabilityCode]         CHAR (1)       NULL,
    [IsDefaultConfiguration]         BIT            NULL,
    [KBBVehicleId]                   INT            NULL,
    [DetailName]                     VARCHAR (300)  NULL,
    [NonBoldName]                    VARCHAR (300)  NULL,
    [Footer]                         VARCHAR (2600) NULL,
    [SortOrder]                      INT            NULL,
    [NCBBAdjustmentTypeId]           INT            NULL,
    [NCBBAdjustmentTypeDisplayName]  VARCHAR (25)   NULL,
    [NCBBCanExceedMSRPFlag]          BIT            NULL,
    [NCBBAdjustmentValue]            DECIMAL (9, 3) NULL,
    [StartDate]                      DATETIME       NULL,
    [EndDate]                        DATETIME       NULL,
    [BlueBookName]                   VARCHAR (50)   NULL,
    CONSTRAINT [PK_VehicleOption] PRIMARY KEY CLUSTERED ([VehicleOptionId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_VehicleOption_Vehicle] FOREIGN KEY ([KBBVehicleId]) REFERENCES [dbo].[KBBVehicle] ([KBBVehicleId])
);


GO
CREATE NONCLUSTERED INDEX [idx_VehicleOption_OptionTypeDisplayName]
    ON [dbo].[VehicleOption]([OptionTypeDisplayName] ASC)
    INCLUDE([VehicleOptionId], [DisplayName], [IsDefaultConfiguration], [KBBVehicleId], [SortOrder]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxVehicleOption_KBBVehicleId_OptionAvailabilityCode]
    ON [dbo].[VehicleOption]([KBBVehicleId] ASC, [OptionAvailabilityCode] ASC)
    INCLUDE([VehicleOptionId]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxVehicleOption_KbbVehicleId_OptionTypeDisplayName]
    ON [dbo].[VehicleOption]([KBBVehicleId] ASC, [OptionTypeDisplayName] ASC)
    INCLUDE([DisplayName], [IsDefaultConfiguration], [SortOrder], [VehicleOptionId]) WITH (FILLFACTOR = 90);

