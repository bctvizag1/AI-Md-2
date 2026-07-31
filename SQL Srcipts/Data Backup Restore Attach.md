### Attach database from bak file

```sql
USE [master]
RESTORE DATABASE [SOCRJY] FROM  DISK = N'D:\Rao_Projects\GoogleDrive-Naru12193\ADB SOC\SOCRJY_Close__17032026.bak' WITH  FILE = 1,  
MOVE N'SOCRJY' TO N'D:\MSSQL\SOCRJY.mdf',  
MOVE N'SOCRJY_log' TO N'D:\MSSQL\SOCRJY_log.ldf',  NOUNLOAD,  STATS = 5

GO

```