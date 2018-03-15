



CREATE PROCEDURE [dbo].[stpGetConfiguredVehicleValue] 


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

	SELECT 
		  V.RequestId AS RequestId
		, RBP.PriceTypeId
		, RBP.Price 		 As BasePrice
		, MGA.Adjustment AS MileageAdjustment
		, MGA.AdjustmentTypeId
	FROM
		VehicleRegion VR
		inner join RegionBasePrice RBP on RBP.VehicleTypeRegionId = VR.VehicleTypeRegionId
		inner join @vehicle V ON RBP.KBBVehicleId = V.KbbVehicleId
		INNER JOIN KBBVehicle KBBV ON V.KbbVehicleId = KBBV.KBBVehicleId
		INNER JOIN Trim T ON KBBV.TrimId = T.TrimId
		INNER JOIN MileageGroupAdjustment MGA ON MGA.MileageGroupId = KBBV.MileageGroupId 
		inner join MileageRange MR ON MR.MileageRangeId = MGA.MileageRangeId AND T.YearId = MR.YearId
	WHERE
		VR.RegionId = 9
		AND (RBP.PriceTypeId = V.PricingTypeId OR RBP.PriceTypeId = 82)
		AND V.Mileage between MR.MileageMin and MR.MileageMax


	SELECT
		  V.RequestId
		, VG.KBBVehicleId
		, RGA.Adjustment
		, AdjustmentTypeId
	From
		@vehicle V
		inner join VehicleGroup VG on V.KbbVehicleId = VG.KBBVehicleId
		inner join RegionGroupAdjustment RGA on RGA.GroupId = VG.GroupId
		inner join RegionAdjustmentTypePriceType RAPT on
				 RAPT.RegionAdjustmentTypeId = RGA.RegionAdjustmentTypeId
		inner join Region R on R.RegionId = RGA.RegionId
		inner join RegionZipCode RZ on RZ.RegionId = R.RegionId
		inner join ZipCode Z on Z.ZipCodeId = RZ.ZipCodeId
	WHERE
		RAPT.PriceTypeId = V.PricingTypeId
		and Z.ZipCode = @zipCode

	SELECT
		  V.RequestId
		, ORP.VehicleOptionId
		, ORP.KBBVehicleId
		, ORP.PriceAdjustment
	FROM
		@vehicle V
		INNER JOIN VehicleOption VO ON V.KbbVehicleId = VO.KBBVehicleId
		LEFT JOIN @option O ON V.RequestId = O.RequestId AND VO.VehicleOptionId = O.VehicleOptionId
		INNER JOIN OptionRegionPriceAdjustment ORP ON ORP.VehicleOptionId = VO.VehicleOptionId AND ORP.KBBVehicleId = VO.KBBVehicleId AND ORP.PriceTypeId = V.PricingTypeId
	WHERE
		(
			VO.OptionAvailabilityCode = 'A'
			AND O.VehicleOptionId IS NOT NULL
		) OR (
			VO.OptionAvailabilityCode = 'S'
			AND O.VehicleOptionId IS NULL
		)

	SELECT
		  V.RequestID
		, VPR.RangeLow
		, VPR.RangeHigh
	FROM
		@vehicle V
		INNER JOIN VehiclePriceRange VPR ON V.KBBVehicleId = VPR.KBBVehicleId AND V.PricingTypeId = VPR.PriceTypeId

	SELECT
		  V.RequestID
		, Y.MaximumDeductionPercentage
	FROM
		@vehicle V
		JOIN KBBVehicle KV ON V.KbbVehicleId = KV.KBBVehicleId
		JOIN Trim T ON KV.TrimId = T.TrimId
		JOIN [Year] Y ON T.YearID = Y.YearId

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



