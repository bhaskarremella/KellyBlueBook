CREATE VIEW [values].[vMinimumOptionAdjustment]
AS
SELECT        V.KBBVehicleId, ORP.PriceTypeId, SUM(ORP.PriceAdjustment) AS Adjustment
FROM            dbo.KBBVehicle AS V INNER JOIN
                dbo.VehicleOption AS VO ON V.KBBVehicleId = VO.KBBVehicleId AND VO.OptionAvailabilityCode = 'S' INNER JOIN
                dbo.OptionRegionPriceAdjustment AS ORP ON ORP.VehicleOptionId = VO.VehicleOptionId AND ORP.KBBVehicleId = VO.KBBVehicleId
GROUP BY V.KBBVehicleId, ORP.PriceTypeId


