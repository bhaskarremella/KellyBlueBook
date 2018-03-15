CREATE VIEW [values].[vMileageAdjustment]
AS
SELECT        V.KBBVehicleId, MR.YearId, MR.MileageRangeId, MGA.MileageGroupId, MGA.Adjustment, MR.MileageMin, MR.MileageMax, RBP.VehicleTypeRegionId, 
                         RBP.Price AS ValuationBase, CASE WHEN MGA.AdjustmentTypeDisplayName = 'percent' THEN CAST(RBP.Price * MGA.Adjustment AS int) 
                         WHEN MGA.AdjustmentTypeDisplayName = 'value' THEN CAST(RBP.Price + MGA.Adjustment AS int) END AS MileageAdjustment
FROM            dbo.KBBVehicle AS V INNER JOIN
                         dbo.Trim AS T ON V.TrimId = T.TrimId INNER JOIN
                         dbo.RegionBasePrice AS RBP ON RBP.KBBVehicleId = V.KBBVehicleId AND RBP.PriceTypeId = 82 INNER JOIN
                         dbo.VehicleRegion AS VR ON VR.VehicleTypeRegionId = RBP.VehicleTypeRegionId INNER JOIN
                         dbo.Region AS R ON R.RegionId = VR.RegionId AND R.RegionTypeDisplayName = 'National Base' INNER JOIN
                         dbo.MileageGroupAdjustment AS MGA ON MGA.MileageGroupId = V.MileageGroupId INNER JOIN
                         dbo.MileageRange AS MR ON MR.MileageRangeId = MGA.MileageRangeId AND MR.YearId = T.YearId


