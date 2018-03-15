

CREATE VIEW [dbo].[vDetermineVehicleTrim] 

AS 

SELECT kv.KBBVehicleId,
	   t.DisplayName ,
       t.TrimName
FROM dbo.KBBVehicle AS kv
JOIN dbo.Trim AS t
	ON t.TrimId = kv.TrimId


