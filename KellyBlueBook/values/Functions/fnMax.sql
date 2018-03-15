
-- =============================================
-- Author:		Eric Blatz
-- Create date: 10-20-2015
-- Description:	Finds the max value
-- =============================================
CREATE FUNCTION [values].[fnMax] 
(	
	@value1 DECIMAL,
	@value2 DECIMAL
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT CASE
		WHEN @value1 > @value2 THEN @value1
		ELSE ISNULL(@value2, @value1) END AS Val
)

