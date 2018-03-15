CREATE VIEW [values].[vMaximumOptionAdjustment]
AS
SELECT        V.KBBVehicleId, ORP.PriceTypeId, SUM(ORP.PriceAdjustment) AS Adjustment
FROM            dbo.KBBVehicle AS V INNER JOIN
                         dbo.VehicleOption AS VO ON V.KBBVehicleId = VO.KBBVehicleId INNER JOIN
                         dbo.OptionRegionPriceAdjustment AS ORP ON ORP.VehicleOptionId = VO.VehicleOptionId AND ORP.KBBVehicleId = VO.KBBVehicleId LEFT OUTER JOIN
                         [values].MostExpensiveOptionCombination AS O ON V.KBBVehicleId = O.KBBVehicleId AND VO.VehicleOptionId = O.OptionId AND O.PriceTypeId = ORP.PriceTypeId
WHERE        (VO.OptionAvailabilityCode = 'A') AND (O.OptionId IS NOT NULL) OR
                         (VO.OptionAvailabilityCode = 'S') AND (O.OptionId IS NULL)
GROUP BY V.KBBVehicleId, ORP.PriceTypeId


