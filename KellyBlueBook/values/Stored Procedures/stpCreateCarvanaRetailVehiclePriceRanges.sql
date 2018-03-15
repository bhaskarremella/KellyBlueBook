
CREATE PROCEDURE [values].[stpCreateCarvanaRetailVehiclePriceRanges] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	TRUNCATE TABLE [values].[CarvanaRetailVehiclePriceRange_stage]

	INSERT INTO [values].[CarvanaRetailVehiclePriceRange_stage]
		SELECT V.KBBVehicleId,
			RBP.PriceTypeId AS PriceTypeId,
			RBP.RegionId,
			RBP.RegionalBaseValue + MaxDeductApplied.Val,
			RBP.RegionalBaseValue + ISNULL(MEDOA.Adjustment, 0) + ISNULL(MA.MileageAdjustment, 0)
		FROM KBBVehicle V
			JOIN [values].[vRegionBasePrice] RBP ON v.KBBVehicleId = RBP.KBBVehicleId
			JOIN [dbo].[VehicleTypicalMiles] VTM ON VTM.KBBVehicleId = v.KBBVehicleId
			JOIN [dbo].[Trim] T ON T.TrimId = V.TrimId
			JOIN [dbo].[Year] Y ON T.YearId = Y.YearId
			LEFT JOIN [values].[vMaximumEquipmentDefaultOptionsAdjustment] MEDOA ON MEDOA.KBBVehicleId = V.KBBVehicleId AND MEDOA.PriceTypeId = RBP.PriceTypeId
			LEFT JOIN [values].[vMileageAdjustment] MA ON MA.KBBVehicleId = V.KBBVehicleId AND VTM.TypicalMiles * 0.8 BETWEEN MA.MileageMin AND MA.MileageMax
			LEFT JOIN [values].[vMinimumOptionAdjustment] MinOA ON MinOA.KBBVehicleId = V.KBBVehicleId AND MinOA.PriceTypeId = RBP.PriceTypeId
			LEFT JOIN [values].[vMileageAdjustment] MA2 ON MA2.KBBVehicleId = V.KBBVehicleId AND VTM.TypicalMiles * 1.2 BETWEEN MA2.MileageMin AND MA2.MileageMax
			CROSS APPLY [values].[fnMax](RBP.RegionalBaseValue * -Y.MaximumDeductionPercentage, ISNULL(MA2.MileageAdjustment, 0) + ISNULL(MinOA.Adjustment,0)) MaxDeductApplied
		WHERE RBP.PriceTypeId = 2

	BEGIN TRANSACTION
		EXEC sp_rename N'[values].[CarvanaRetailVehiclePriceRange]', N'CarvanaRetailVehiclePriceRange_tmp'
		EXEC sp_rename N'[values].[CarvanaRetailVehiclePriceRange_stage]', N'CarvanaRetailVehiclePriceRange'
	COMMIT TRANSACTION
		EXEC sp_rename N'[values].[CarvanaRetailVehiclePriceRange_tmp]', N'CarvanaRetailVehiclePriceRange_stage'
END

