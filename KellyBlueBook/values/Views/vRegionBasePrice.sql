CREATE VIEW [values].[vRegionBasePrice]
AS
SELECT        V.KBBVehicleId, ISNULL(VG.GroupId, 0) AS GroupId, ISNULL(R2.RegionId, 0) AS RegionId, PT.PriceTypeId, ISNULL(RGA.Adjustment, 0) AS AdjustmentFactor, ISNULL(RGA.AdjustmentTypeDisplayName, 'n/a') 
                         AS AdjustmentTypeDisplayName, ISNULL(RBP.Price, 0) AS NationalBase, ISNULL(RBPV.Price, 0) AS ValuationBase, ISNULL(RGA.Adjustment * RBPV.Price, 0) AS RegionalAdjustment, 
                         CASE WHEN RGA.AdjustmentTypeDisplayName = 'percent' THEN CAST(RBP.Price + (ISNULL(RBPV.Price, 0) * ISNULL(RGA.Adjustment, 0)) AS Int) 
                         WHEN RGA.AdjustmentTypeDisplayName = 'value' THEN CAST(RBP.Price + ISNULL(RGA.Adjustment, 0) AS Int) ELSE RBP.Price END AS RegionalBaseValue
FROM            dbo.KBBVehicle AS V INNER JOIN
                         dbo.RegionBasePrice AS RBP ON RBP.KBBVehicleId = V.KBBVehicleId INNER JOIN
                         dbo.VehicleRegion AS VR ON VR.VehicleTypeRegionId = RBP.VehicleTypeRegionId INNER JOIN
                         dbo.PriceType AS PT ON PT.PriceTypeId = RBP.PriceTypeId INNER JOIN
                         dbo.Region AS NR ON NR.RegionId = VR.RegionId AND NR.RegionTypeDisplayName = 'National Base' INNER JOIN
                         dbo.RegionBasePrice AS RBPV ON RBPV.KBBVehicleId = V.KBBVehicleId AND RBPV.PriceTypeId = 82 LEFT OUTER JOIN
                         dbo.VehicleGroup AS VG ON V.KBBVehicleId = VG.KBBVehicleId LEFT OUTER JOIN
                         dbo.Region AS R2 ON 1 = 1 LEFT OUTER JOIN
                         dbo.RegionAdjustmentTypePriceType AS RAPT ON PT.PriceTypeId = RAPT.PriceTypeId LEFT OUTER JOIN
                         dbo.RegionGroupAdjustment AS RGA ON RGA.GroupId = VG.GroupId AND RAPT.RegionAdjustmentTypeId = RGA.RegionAdjustmentTypeId AND RGA.RegionId = R2.RegionId
WHERE        (RBP.Price <> 0)

