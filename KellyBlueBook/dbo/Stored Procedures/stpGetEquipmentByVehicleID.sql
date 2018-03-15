
CREATE PROCEDURE [dbo].[stpGetEquipmentByVehicleID]
	@VehicleID INT,
	@PriceTypeID INT = NULL
	/*
	=============================================
	Author:		Eric Blatz
	Create date: 2/19/2015
	Description:	Gets Equipment Options for a KBB Vehicle ID
	
	Updated On  : March 31, 2015
	Updated By  : Eric Blatz
	Description : Adding price adjustment for options given a PriceTypeID
	=============================================
	*/
AS
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

BEGIN TRY
	SELECT DISTINCT  VO.VehicleOptionId
		,VO.DisplayName AS OptionDisplayName
		,VO.IsDefaultConfiguration
		,C.DisplayName AS CategoryDisplayName
		,CASE WHEN @priceTypeId IS NULL THEN NULL ELSE COALESCE(orpa.PriceAdjustment, 0) END AS PriceAdjustment
	FROM VehicleOption VO
		INNER JOIN VehicleOptionCategory VOC ON VO.VehicleOptionId = VOC.VehicleOptionId
		INNER JOIN Category C ON VOC.CategoryId = C.CategoryId
		LEFT JOIN OptionRegionPriceAdjustment orpa ON orpa.VehicleOptionId = VO.VehicleOptionId AND orpa.PriceTypeId = @PriceTypeID
	WHERE VO.KBBVehicleId = @VehicleID
			AND VO.OptionTypeDisplayName = 'Equipment'
			AND C.Note IS NOT NULL
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
