

CREATE PROCEDURE [dbo].[stpGetConfiguredVehicleValue_Slim_AdminTest] 

-- =============================================
-- Author:		Eric Blatz, Michael Nesvold
-- Create date: 02/16/2014
-- Description:	Gets all value-related records given a list of vehicles and a list of options
-- =============================================

 
	-- Add the parameters for the stored procedure here
	@vehicle tblVehicleTableType READONLY, 
	@option tblVehicleOptionTableType READONLY,
	@zipCode char(5)
	
AS
BEGIN
BEGIN TRY
SET NOCOUNT ON

DECLARE @zipcodeParam CHAR(5) = @zipCode -- to prevent Parameter Sniffing

;WITH FirstSet(RequestId,PriceTypeId,BasePrice,MileageAdjustment,MileageAdjustmentTypeId,MaximumDeductionPercentage,KbbVehicleId,PricingTypeId)
as
(
	SELECT 
		  V.RequestId AS RequestId
		, RBP.PriceTypeId
		, RBP.Price As BasePrice
		, MGA.Adjustment AS MileageAdjustment
		, MGA.AdjustmentTypeId AS MileageAdjustmentTypeId
		, Y.MaximumDeductionPercentage
		,V.KbbVehicleId
		,V.PricingTypeId
	FROM
		VehicleRegion VR
		--Base Price
		INNER JOIN RegionBasePrice RBP on RBP.VehicleTypeRegionId = VR.VehicleTypeRegionId
		INNER JOIN @vehicle V ON RBP.KBBVehicleId = V.KbbVehicleId
		INNER JOIN KBBVehicle KBBV ON V.KbbVehicleId = KBBV.KBBVehicleId
		--Mileage Adjustment
		INNER JOIN Trim T ON KBBV.TrimId = T.TrimId
		INNER JOIN MileageGroupAdjustment MGA ON MGA.MileageGroupId = KBBV.MileageGroupId 
		INNER JOIN MileageRange MR ON MR.MileageRangeId = MGA.MileageRangeId AND T.YearId = MR.YearId
		--Max Deduct
		INNER JOIN [Year] Y ON T.YearID = Y.YearId
	WHERE
		VR.RegionId = 9
		AND (RBP.PriceTypeId = V.PricingTypeId OR RBP.PriceTypeId = 82)
		AND V.Mileage between MR.MileageMin and MR.MileageMax
)
SELECT RequestId,
		FS.PriceTypeId,
		BasePrice,
		MileageAdjustment,
		MileageAdjustmentTypeId 
		, RGA.Adjustment AS RegionAdjustment
		, RGA.AdjustmentTypeId AS RegionAdjustmentTypeId
		, VPR.RangeLow AS RangeLow
		, VPR.RangeHigh AS RangeHigh
		,MaximumDeductionPercentage
FROM FirstSet FS
--Region Adjustment
		INNER JOIN VehicleGroup VG ON FS.KbbVehicleId = VG.KBBVehicleId
		INNER JOIN RegionGroupAdjustment RGA ON RGA.GroupId = VG.GroupId
		LEFT JOIN RegionAdjustmentTypePriceType RAPT ON RAPT.RegionAdjustmentTypeId = RGA.RegionAdjustmentTypeId
		LEFT JOIN Region R ON R.RegionId = RGA.RegionId
		LEFT JOIN RegionZipCode RZ ON RZ.RegionId = R.RegionId
		LEFT JOIN ZipCode Z ON Z.ZipCodeId = RZ.ZipCodeId
		--Price Range
		INNER JOIN VehiclePriceRange VPR ON FS.KBBVehicleId = VPR.KBBVehicleId AND FS.PricingTypeId = VPR.PriceTypeId
	WHERE	
		Z.ZipCode = @zipcodeParam
	AND RAPT.PriceTypeId = FS.PricingTypeId

	SELECT
		  V.RequestId
		, ORP.VehicleOptionId
		, ORP.KBBVehicleId
		, ORP.PriceAdjustment
	FROM
		@vehicle V
		INNER JOIN VehicleOption VO ON V.KbbVehicleId = VO.KBBVehicleId
		INNER JOIN OptionRegionPriceAdjustment ORP ON ORP.VehicleOptionId = VO.VehicleOptionId AND ORP.KBBVehicleId = VO.KBBVehicleId AND ORP.PriceTypeId = V.PricingTypeId
		LEFT JOIN @option O ON V.RequestId = O.RequestId AND VO.VehicleOptionId = O.VehicleOptionId
		
	WHERE
		(
			VO.OptionAvailabilityCode = 'A'
			AND O.VehicleOptionId IS NOT NULL
		) OR (
			VO.OptionAvailabilityCode = 'S'
			AND O.VehicleOptionId IS NULL
		)

END TRY

/*------------------------------------------------------
Special catch logic only good for SELECT type procedures
Because it does not contain rollback code.
------------------------------------------------------*/
BEGIN CATCH
    DECLARE 
        @ErrorNumber     INT,
        @ErrorSeverity   INT,
        @ErrorState      INT,
        @ErrorLine       INT,
        @ErrorProcedure  NVARCHAR(200),
        @ErrorMessage    VARCHAR(4000)

    -- Assign variables to error-handling functions that capture information for RAISERROR.
    SELECT 
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-');

    -- Building the message string that will contain original error information.
    SELECT @ErrorMessage = 
        N'Error %d, Level %d, State %d, Procedure %s, Line %d, ' + 
            'Message: '+ ERROR_MESSAGE();
            
    -- Use RAISERROR inside the CATCH block to return error
    -- information about the original error that caused
    -- execution to jump to the CATCH block.
    RAISERROR (@ErrorMessage, -- Message text.
               16,  -- must be 16 for Informatica to pick it up
               1,
               @ErrorNumber,
               @ErrorSeverity, -- Severity.
               @ErrorState, -- State.
               @ErrorProcedure,
               @ErrorLine
               );
END CATCH
END







