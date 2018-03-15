--Views
CREATE VIEW [label].[vOptionGroupRepresentative]
AS
       SELECT o.SortOrder, vo.DisplayName OptionName, ma.DisplayName MakeName, mo.DisplayName ModelName, t.YearId, t.TrimName FROM (
             SELECT vo.SortOrder, MIN(vo.KbbVehicleId) KbbVehicleId FROM VehicleOption vo
                    JOIN VehicleCategory vc ON vc.KBBVehicleId = vo.KBBVehicleId
             WHERE vc.CategoryId=36 AND vo.OptionTypeId <> 4 AND vo.OptionTypeId <> 7
             GROUP BY vo.SortOrder
       ) AS o
       JOIN KBBVehicle v ON v.KBBVehicleId = o.KbbVehicleId
       JOIN Trim t ON v.TrimId = t.TrimId
       JOIN Model mo ON t.ModelId = mo.ModelId
       JOIN Make ma ON mo.MakeId = ma.MakeId
       OUTER APPLY (
             SELECT MIN(vo.DisplayName) DisplayName FROM VehicleOption vo
             WHERE o.SortOrder = vo.SortOrder AND o.KbbVehicleId = vo.KBBVehicleId
             GROUP BY vo.SortOrder
       ) vo

