
CREATE PROCEDURE [PreEvaluate].[stpGetOptionsForVehicle]   
 @kbbVehicleId int 
 
-- =============================================
-- Author:           Eric Blatz
-- Create date:      2/14/2014
-- Description:      Gets all options for vehicle
--
-- Updated date:	1/13/2017
-- Updated by:		Shawn Livermore
-- Description:		Now explicitly uses the preEvaluate schema in the table queries instead of relying on SQL Server to detect the schema.
-- =============================================

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
  CategorySortOrder INT NULL  
 )  
  
 INSERT INTO @Options  
  SELECT  
   VO.VehicleOptionId,  
   VO.DisplayName AS OptionDisplayName,  
   VO.IsDefaultConfiguration AS IsDefaultOption,  
   VO.SortOrder AS SortOrder,  
   VOC.CategoryId AS OptionCategory,  
   C.SortOrder  
  FROM  
   PreEvaluate.VehicleOption VO  
   INNER JOIN PreEvaluate.VehicleOptionCategory VOC ON VO.VehicleOptionId = VOC.VehicleOptionId  
   INNER JOIN PreEvaluate.Category C ON VOC.CategoryId = C.CategoryId  
  WHERE  
   VO.KBBVehicleId = @kbbVehicleId  
   AND VO.OptionTypeDisplayName <> 'Equipment'
   AND C.CategoryId = 36
  
  ORDER BY C.SortOrder, VO.SortOrder  
    
 SELECT * FROM @Options  
   
 SELECT  
  OPR.ContextValueId AS ParentOptionId,  
  OPR.OptionRelationshipTypeId,  
  ORS.ContextValueId AS ChildOptionId  
 FROM  
  @Options O  
  INNER JOIN PreEvaluate.OptionRelationship OPR ON O.VehicleOptionId = OPR.ContextValueId AND OPR.ContextDisplayName = 'VehicleOption'  
  LEFT JOIN PreEvaluate.OptionRelationshipSet ORS ON OPR.VehicleOptionRelationshipId = ORS.VehicleOptionRelationshipId  
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



