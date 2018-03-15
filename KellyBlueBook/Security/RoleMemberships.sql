ALTER ROLE [db_owner] ADD MEMBER [COEXIST\RG-MIS-DB Dev General];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [COEXIST\RG-MIS-App Dev General];


GO
ALTER ROLE [db_datareader] ADD MEMBER [COEXIST\svc-ssis-test];


GO
ALTER ROLE [db_datareader] ADD MEMBER [COEXIST\svc-inventory-dev];


GO
ALTER ROLE [db_datareader] ADD MEMBER [UGLYDUCKLING\svc-infa-dev];


GO
ALTER ROLE [db_datareader] ADD MEMBER [COEXIST\RG-MIS-DB Dev General];


GO
ALTER ROLE [db_datareader] ADD MEMBER [COEXIST\RG-MIS-Analytics General];


GO
ALTER ROLE [db_datareader] ADD MEMBER [COEXIST\RG-MIS-App Dev General];


GO
ALTER ROLE [db_datareader] ADD MEMBER [COEXIST\RG-MIS-BA General];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [UGLYDUCKLING\svc-infa-dev];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [COEXIST\RG-MIS-App Dev General];

