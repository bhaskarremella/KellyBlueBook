CREATE VIEW [values].[vMaximumValueVehicleEquipmentOptions]
AS
SELECT        V.KBBVehicleId, PT.PriceTypeId, MIN(VO.VehicleOptionId) AS VehicleOptionId
FROM            dbo.KBBVehicle AS V CROSS JOIN
                         dbo.PriceType AS PT INNER JOIN
                         dbo.VehicleOption AS VO ON VO.KBBVehicleId = V.KBBVehicleId INNER JOIN
                         dbo.VehicleOptionCategory AS VOC ON VO.VehicleOptionId = VOC.VehicleOptionId INNER JOIN
                         dbo.Category AS C ON VOC.CategoryId = C.CategoryId LEFT OUTER JOIN
                         dbo.OptionRegionPriceAdjustment AS ORPA ON ORPA.VehicleOptionId = VO.VehicleOptionId AND ORPA.PriceTypeId = PT.PriceTypeId INNER JOIN
                             (SELECT        V.KBBVehicleId, PT.PriceTypeId, C.Note, MAX(ISNULL(CASE WHEN VO.OptionAvailabilityCode = 'S' THEN - ORPA.PriceAdjustment ELSE ORPA.PriceAdjustment END, 0)) AS Value
                               FROM            dbo.KBBVehicle AS V CROSS JOIN
                                                         dbo.PriceType AS PT INNER JOIN
                                                         dbo.VehicleOption AS VO ON VO.KBBVehicleId = V.KBBVehicleId INNER JOIN
                                                         dbo.VehicleOptionCategory AS VOC ON VO.VehicleOptionId = VOC.VehicleOptionId INNER JOIN
                                                         dbo.Category AS C ON VOC.CategoryId = C.CategoryId LEFT OUTER JOIN
                                                         dbo.OptionRegionPriceAdjustment AS ORPA ON ORPA.VehicleOptionId = VO.VehicleOptionId AND ORPA.PriceTypeId = PT.PriceTypeId
                               WHERE        (C.Note IN ('Engine', 'Drivetrain', 'Transmission'))
                               GROUP BY V.KBBVehicleId, C.Note, PT.PriceTypeId) AS MaxValue ON MaxValue.Value = ISNULL(CASE WHEN VO.OptionAvailabilityCode = 'S' THEN - ORPA.PriceAdjustment ELSE ORPA.PriceAdjustment END, 
                         0) AND MaxValue.KBBVehicleId = V.KBBVehicleId AND MaxValue.PriceTypeId = PT.PriceTypeId AND MaxValue.Note = C.Note
GROUP BY V.KBBVehicleId, PT.PriceTypeId, C.Note