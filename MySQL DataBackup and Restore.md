## Backup
```
mysqldump -u root -p my_database > D:\backup\my_database.sql
```
```
mysqldump -u root -p vmba_data > D:\MySQL\vmba_data_13012026.sql
```

For All Databases
```
mysqldump -u root -p --all-databases > D:\backup\full_backup.sql
```
**pwd:pcsc@2024**

### Automating Backups with Batch Files
```
@echo off
set username=root
set password=your_password
set database=my_database

set backup_file=backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.sql
mysqldump -u %username% -p%password% %database% > D:\backup\%backup_file%
```

## Restore
**Step 1: Ensure Database Exists**
```
mysql -u root -p -e "CREATE DATABASE my_database;"
```
**Step 2: Restore from Backup File**
```
mysql -u root -p my_database < D:\backup\my_database.sql
```

