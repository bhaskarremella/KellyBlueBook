CREATE VIEW [values].[vMaximumEquipmentDefaultOptionsAdjustment]
AS
SELECT        V.KBBVehicleId, ORP.PriceTypeId, SUM(ORP.PriceAdjustment) AS Adjustment
FROM            dbo.KBBVehicle AS V INNER JOIN
                         dbo.VehicleOption AS VO ON V.KBBVehicleId = VO.KBBVehicleId INNER JOIN
                         dbo.OptionRegionPriceAdjustment AS ORP ON ORP.VehicleOptionId = VO.VehicleOptionId AND ORP.KBBVehicleId = VO.KBBVehicleId
						 LEFT OUTER JOIN (
							SELECT * FROM [values].[vMaximumValueVehicleEquipmentOptions]
							UNION ALL
							SELECT KBBVehicleId, PT.PriceTypeId, VehicleOptionId
								FROM VehicleOption
								CROSS JOIN PriceType PT
								WHERE OptionTypeDisplayName <> 'Equipment' AND IsDefaultConfiguration = 1
						 ) AS O ON V.KBBVehicleId = O.KBBVehicleId AND VO.VehicleOptionId = O.VehicleOptionId AND O.PriceTypeId = ORP.PriceTypeId
WHERE        (VO.OptionAvailabilityCode = 'A') AND (O.VehicleOptionId IS NOT NULL) OR
                         (VO.OptionAvailabilityCode = 'S') AND (O.VehicleOptionId IS NULL)
GROUP BY V.KBBVehicleId, ORP.PriceTypeId
