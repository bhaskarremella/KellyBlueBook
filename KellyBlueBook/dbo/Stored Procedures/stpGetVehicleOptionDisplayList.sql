CREATE procedure [dbo].stpGetVehicleOptionDisplayList
@VehicleOptionIDList VARCHAR(MAX),
@VehicleOptionsDisplayList AS VARCHAR(MAX) OUTPUT
/*----------------------------------------------------------------------------------------
Created By  : David
Created On  : June 29, 2017
Application : Informatica
Description : This proc will return a comma delimited string of vehicle display options for
			  each vehicleoptionIDlist that is passed in. 

Updated By  : LeAnne Jergensen
Updated On  : December 21, 2017
Description : Change the ## table to # table so there is no interference if the proc is run
              at the same time by different users.
------------------------------------------------------------------------------------------
*/
AS

BEGIN;
SET NOCOUNT ON;

BEGIN TRY;
DECLARE @TranCount int;
      --<other declarations including temp table creations & CTEs>

-- Get if the session is in transaction state yet or not
SET @TranCount = @@trancount;

-- Detect if the procedure was called from an active transaction and save that for later use. In the procedure, 
-- @TranCount = 0 means there was no active transaction and the procedure started one. @TranCount > 0 means 
-- an active transaction was started before the procedure was called.
IF @TranCount = 0
   -- No active transaction so begin one
   BEGIN TRANSACTION;
ELSE
   -- Create a savepoint to be able to roll back only the work done in the procedure if there is an error
   SAVE TRANSACTION stpGetVehicleOptionDisplayList

DECLARE @VehicleOptionsFormatted AS VARCHAR(MAX)
create TABLE #VehicleOptions (DisplayName VARCHAR(200))

SET @VehicleOptionsFormatted = 'INSERT INTO #VehicleOptions (displayname) 
                                SELECT vo.DisplayName
					            FROM KelleyBlueBook.dbo.VehicleOption AS vo
					            WHERE vo.VehicleOptionId IN (' + ISNULL(@VehicleOptionIDList,0) + ')'

EXEC  (@VehicleOptionsFormatted)


SELECT  @VehicleOptionsDisplayList = ( STUFF(( SELECT DISTINCT ','  + vo.DisplayName
                                                   FROM #VehicleOptions AS vo FOR
                                                    XML PATH('')
		                                     ), 1, 1, '')
	                                  );

SELECT @VehicleOptionsDisplayList


-- @TranCount = 0 means no transaction was started before the procedure was called.
-- The procedure must commit the transaction it started.
IF @TranCount = 0
   COMMIT TRANSACTION;

END TRY

/*------------------------------------------------------
Special catch logic only good for CUD type procedures
Because it does contains rollback code.
------------------------------------------------------*/
BEGIN CATCH
    DECLARE 
        @ErrorNumber     INT,
        @ErrorSeverity   INT,
        @ErrorState      INT,
        @ErrorLine       INT,
        @ErrorProcedure  NVARCHAR(200),
        @ErrorMessage    VARCHAR(4000),
        @XactState       INT,
        @CurrTranCount   INT;

    -- Get the state of the existing transaction so we can tell what type of rollback needs to occur
    --    If 1, the transaction is committable.  
    --    If -1, the transaction is uncommittable and should   
    --        be rolled back.  
    --    XACT_STATE = 0 means that there is no transaction and  
    --        a commit or rollback operation would generate an error. 
    SET @XactState = XACT_STATE();

    -- Get the current transaction count 
    -- It is possible for the @TranCount value to be set, but a transaction to not be opened 
    --    when an error occurs. When this happens, we cannot call the rollback statement as there is no
    --    transaction to rollback. An example of this is when the executing account does not have
    --    permissions to the underlying objects, but does have authorization to execute the procedure.  
    SET @CurrTranCount = @@TRANCOUNT;

    -- @TranCount = 0 means no transaction was started before the procedure was called.
    -- The procedure must rollback the transaction it started.
    IF @TranCount = 0 AND @CurrTranCount > 0
       ROLLBACK TRANSACTION;
    ELSE
       -- If the state of the transaction is stable, then rollback just the current save point work
       IF @XactState <> -1 AND @CurrTranCount > 0
            ROLLBACK TRANSACTION stpGetVehicleOptionDisplayList

    -- Assign variables to error-handling functions that capture information for RAISERROR.
    SELECT 
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-');

    -- Building the message string that will contain original error information.
    SELECT @ErrorMessage = N'Error %d, Level %d, State %d, Procedure %s, Line %d, ' + 
                           N'Message: '+ ERROR_MESSAGE();
            
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

    -- Return a negative number so that if the calling code is using a LINK server, it will
    -- be able to test that the procedure failed.  Without this, there are some lower type of 
    -- errors that do not show up across the LINK as an error.  This causes ProcessControl 
    -- in particular to not see that the procedure failed which is bad.
    RETURN -1;

END CATCH;
END;
								  
						
