

CREATE VIEW [dbo].[vDetermineCarvanaRepresentativeZip]
/********************************************************************************************************
Created By  : Cody Stone
Created On  : August 22, 2014
Application : KellyBlueBook
Description : Used in KellyBlueBook pricing load to determine a pricing regions representative zipcode to be used by Carvana

              Used in workflow:
                wf_KellyBlueBook_CarvanaRepresentativeZip
              Used in mapping:
                m_KellyBlueBook_CarvanaRepresentativeZip
********************************************************************************************************/
AS

SELECT ZC.ZipCode AS ConstituentZip, ZC2.ZipCode AS RepresentativeZip
FROM RegionZipCode AS RZC
INNER JOIN (
    SELECT MIN(RZC2.ZipCodeId) AS value, RZC2.RegionId
    FROM RegionZipCode AS RZC2
    GROUP BY RZC2.RegionId
    ) AS MinZip 
	ON RZC.RegionId = MinZip.RegionId
INNER JOIN ZipCode AS ZC 
ON RZC.ZipCodeId = ZC.ZipCodeId
INNER JOIN ZipCode AS ZC2 
ON MinZip.value = ZC2.ZipCodeId

