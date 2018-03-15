
CREATE PROCEDURE [values].[stpCreateMinMaxVehicleValues] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	TRUNCATE TABLE [values].[KBBVehiclePriceRange_stage]

	INSERT INTO [values].[KBBVehiclePriceRange_stage]
		SELECT V.KBBVehicleId,
			RBP.PriceTypeId AS PriceTypeId,
			RBP.RegionId,
			RBP.RegionalBaseValue + ISNULL(MinOA.Adjustment, 0) + ISNULL(MA2.MileageAdjustment, 0),
			RBP.RegionalBaseValue + ISNULL(MOA.Adjustment, 0) + ISNULL(MA.MileageAdjustment, 0)
		FROM KBBVehicle V
			JOIN [values].[vRegionBasePrice] RBP ON v.KBBVehicleId = RBP.KBBVehicleId
			LEFT JOIN [values].[vMaximumOptionAdjustment] MOA ON MOA.KBBVehicleId = V.KBBVehicleId AND MOA.PriceTypeId = RBP.PriceTypeId
			LEFT JOIN [values].[vMileageAdjustment] MA ON MA.KBBVehicleId = V.KBBVehicleId AND 0 BETWEEN MA.MileageMin AND MA.MileageMax
			LEFT JOIN [values].[vMinimumOptionAdjustment] MinOA ON MinOA.KBBVehicleId = V.KBBVehicleId AND MinOA.PriceTypeId = RBP.PriceTypeId
			LEFT JOIN [values].[vMileageAdjustment] MA2 ON MA2.KBBVehicleId = V.KBBVehicleId AND 2147483646 BETWEEN MA2.MileageMin AND MA2.MileageMax
		WHERE RBP.PriceTypeId = 2

	BEGIN TRANSACTION
		EXEC sp_rename N'[values].[KBBVehiclePriceRange]', N'KBBVehiclePriceRange_tmp'
		EXEC sp_rename N'[values].[KBBVehiclePriceRange_stage]', N'KBBVehiclePriceRange'
	COMMIT TRANSACTION
		EXEC sp_rename N'[values].[KBBVehiclePriceRange_tmp]', N'KBBVehiclePriceRange_stage'
END


