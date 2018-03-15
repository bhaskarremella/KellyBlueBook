
CREATE PROCEDURE [dbo].[stpConfigurationDataFromVIN] 
       @VIN char(17),
	   @priceTypeId int = NULL

/*
=============================================
Author:           Eric Blatz
Create date: 2/14/2014
Description:      Gets all information necessary to decode a vin if the VIN matches a VIN Vehicle Pattern.
                        This includes Vehicle IDs, Year, Make, Models, Engines, Drivetrains and Transmissions.

EXEC KelleyBlueBook.dbo.stpConfigurationDataFromVIN '1FBSS3BL9CDA01502'

Updated date:	March 31, 2015
Updated by:		Eric Blatz
Description:	Adding price adjustment for options given a PriceTypeID
=============================================
*/

AS
BEGIN
SET NOCOUNT ON
BEGIN TRY

DECLARE @tenthDigit CHAR(1)
DECLARE @seventhDigit CHAR(1)

--TESTING VINS
--SET @VIN = '1N4BA41E64C802523'
--SET @VIN = '1C3CDFBH0DD641434' --no vin level options
--SET @VIN = '1C3CDFBA1DD341825' --all NULLS
--SET @VIN = '1B3CC4FB8AN181634' --pattern AND NULL
--SET @VIN = '1FBSS3BL9CDA01502' --v8
--SET @VIN = '1FBNE3BS4CDB12874' --v10
SELECT      @tenthDigit = SUBSTRING(@VIN, 10, 1)
SELECT      @seventhDigit = SUBSTRING(@VIN, 7, 1)


	--Get all possible vehicle equipment options that match
	SELECT DISTINCT  VVP.KBBVehicleId
			,VO.VehicleOptionId
			,C.DisplayName
			,voep.Pattern
	INTO  #VehicleEquipmentOptionsThatMatch
	FROM dbo.VINVehiclePattern VVP
	INNER JOIN VehicleOption VO ON VO.KBBVehicleId = VVP.KBBVehicleId
	INNER JOIN VehicleOptionCategory VOC ON VO.VehicleOptionId = VOC.VehicleOptionId
	INNER JOIN Category C ON VOC.CategoryId = C.CategoryId 
	INNER JOIN VINOptionEquipment voe 
		ON VOE.KBBVehicleId = VVP.KBBVehicleId 
		AND vo.VehicleOptionId = VOE.VehicleOptionId
	INNER JOIN VINOptionEquipmentPattern voep ON voep.VINOptionEquipmentPatternId = voe.VINOptionEquipmentPatternId 
	WHERE       VO.OptionTypeDisplayName = 'Equipment'
				AND C.Note IS NOT NULL
				AND @VIN LIKE VVP.Pattern
				AND @VIN LIKE VOEP.Pattern


	SELECT V.KBBVehicleId 
			,Y.YearId 
			,Y.DisplayName AS YearDisplayName
			,Ma.MakeId 
			,Ma.DisplayName AS MakeDisplayName
			,M.ModelId 
			,M.DisplayName AS ModelDisplayName
			,T.TrimId 
			,T.DisplayName AS TrimDisplayName
			,T.TrimName AS TrimName
			,VO.VehicleOptionId 
			,VO.DisplayName AS OptionDisplayName 
			,VO.IsDefaultConfiguration AS IsDefaultOption 
			,VO.SortOrder AS OptionSortOrder 
			,VOC.CategoryId AS OptionCategory
			,C.DisplayName AS CategoryDisplayName
			,CASE WHEN @priceTypeId IS NULL THEN NULL ELSE COALESCE(orpa.PriceAdjustment, 0) END AS PriceAdjustment
	FROM        Year Y
				INNER JOIN VinVehiclePattern VVP ON Y.YearId = VVP.YearId
				INNER JOIN KBBVehicle V ON VVP.KBBVehicleId = V.KBBVehicleId
				LEFT JOIN Trim T ON V.TrimId = T.TrimId
				LEFT JOIN Model M ON T.ModelId = M.ModelId
				LEFT JOIN Make Ma ON M.MakeId = Ma.MakeId
				LEFT JOIN VehicleOption VO ON VO.KBBVehicleId = V.KBBVehicleId
				INNER JOIN VehicleOptionCategory VOC ON VO.VehicleOptionId = VOC.VehicleOptionId
				INNER JOIN Category C ON VOC.CategoryId = C.CategoryId 
				LEFT JOIN  #VehicleEquipmentOptionsThatMatch voe ON voe.VehicleOptionId = vo.VehicleOptionId
				LEFT JOIN OptionRegionPriceAdjustment orpa ON orpa.VehicleOptionId = VO.VehicleOptionId AND orpa.PriceTypeId = @priceTypeId
	WHERE       VO.OptionTypeDisplayName = 'Equipment'
				AND C.Note IS NOT NULL
				AND Y.VinCode = @tenthDigit
				AND ( ( ISNUMERIC(@seventhDigit) = 1
						AND Y.DisplayName < '2010'
						)
						OR ( ISNUMERIC(@seventhDigit) = 0
							AND Y.DisplayName >= '2010'
							)
					)
				AND @VIN LIKE VVP.Pattern
				--Returns all matches OR all Nulls for a specific Vehicle and Cateogry
				AND (NOT EXISTS (SELECT * 
								FROM #VehicleEquipmentOptionsThatMatch veotm
								WHERE veotm.KBBVehicleId = V.KBBVehicleId
									AND veotm.DisplayName = C.DisplayName)
					 OR voe.KBBVehicleId IS NOT NULL)
	ORDER BY V.KBBVehicleId


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
