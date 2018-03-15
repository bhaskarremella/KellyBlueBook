

CREATE VIEW [dbo].[vDetermineCarvanaTradeInList]
/********************************************************************************************************
Created By  : Cody Stone
Created On  : December 17, 2014
Application : informatice
Description : Informatica pushes the data of this view up to Azure to be used in Trade In selction to determine the
                           value of the trade in

              Used in workflow:
                wf_Carvana_Load_tblKelleyBlueBookTradeInList
              Used in mapping:
                m_Carvana_Load_tblKelleyBlueBookTradeInList

Changed By  : Cody Stone
Changed On  : February 26, 2015
Description : Changed Trim to TrimName instead of DisplayName
********************************************************************************************************/
AS

SELECT DISTINCT 
             v.KBBVehicleId As VehicleId
             , my.YearId
             , ma.DisplayName As Make
             , mo.DisplayName As model
             , t.TrimName As Trim
FROM ModelYear my with(nolock)
JOIN Model mo with(nolock) ON my.ModelID = mo.ModelId
JOIN Make ma with(nolock) ON mo.MakeID = ma.MakeID
JOIN Trim t with(nolock) ON t.ModelId = my.ModelId AND t.YearId = my.YearID
JOIN KbbVehicle v with(nolock) on t.TrimId = v.TrimId



