
CREATE PROCEDURE [dbo].[stpGetOptionsForVehicle]   
 @kbbVehicleId int,
 @priceTypeId int = NULL 
 
/*
=============================================
Author:           Eric Blatz
Create date:      2/14/2014
Description:      Gets all options for vehicle

Updated date:	March 31, 2015
Updated by:		Eric Blatz
Description:	Adding price adjustment for options given a PriceTypeID. Filtering out color options.
============================================= 
*/

AS  
BEGIN  
BEGIN TRY
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
 DECLARE @Options TABLE(  
  VehicleOptionId INT,  
  OptionDisplayName VARCHAR(50) NULL,  
  IsDefaultConfiguration BIT NULL,  
  SortOrder INT NULL,  
  CategoryId INT,  
  CategorySortOrder INT NULL,
  GroupLabel VARCHAR(100) NULL,
  PriceAdjustment DECIMAL NULL
 )  
  
 INSERT INTO @Options  
  SELECT  
   VO.VehicleOptionId,  
   VO.DisplayName AS OptionDisplayName,  
   VO.IsDefaultConfiguration AS IsDefaultOption,  
   VO.SortOrder AS SortOrder,  
   VOC.CategoryId AS OptionCategory,  
   C.SortOrder AS SortOrder,
   og.Label AS GroupLabel,
   CASE WHEN @priceTypeId IS NULL THEN NULL ELSE COALESCE(orpa.PriceAdjustment, 0) END AS PriceAdjustment
  FROM  
   VehicleOption VO  
   INNER JOIN VehicleOptionCategory VOC ON VO.VehicleOptionId = VOC.VehicleOptionId  
   INNER JOIN Category C ON VOC.CategoryId = C.CategoryId  
   LEFT JOIN [label].[OptionGroup] og ON VO.SortOrder = og.SortOrder
   LEFT JOIN OptionRegionPriceAdjustment orpa ON orpa.PriceTypeId = @priceTypeId AND orpa.VehicleOptionId = vo.VehicleOptionId
  WHERE  
   VO.KBBVehicleId = @kbbVehicleId  
   AND VO.OptionTypeDisplayName <> 'Equipment'
   AND C.CategoryId = 36
   AND vo.OptionTypeId <> 4
   AND vo.OptionTypeId <> 7
   AND vo.OptionTypeId <> 9
  
  ORDER BY C.SortOrder, VO.SortOrder  
    
 SELECT * FROM @Options ORDER BY CategorySortOrder, SortOrder, OptionDisplayName
   
 SELECT  
  OPR.ContextValueId AS ParentOptionId,  
  OPR.OptionRelationshipTypeId,  
  ORS.ContextValueId AS ChildOptionId  
 FROM  
  @Options O  
  INNER JOIN OptionRelationship OPR ON O.VehicleOptionId = OPR.ContextValueId AND OPR.ContextDisplayName = 'VehicleOption'  
  LEFT JOIN OptionRelationshipSet ORS ON OPR.VehicleOptionRelationshipId = ORS.VehicleOptionRelationshipId  
 ORDER BY  
  OPR.ContextValueId


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
