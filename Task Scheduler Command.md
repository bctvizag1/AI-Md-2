```bat
schtasks /create /tn "IPScanTask" /tr "F:\Desktop\IP Scan\IPSCAN.bat" /sc hourly /st 17:15 /f
```

Rename PC
```
wmic computersystem where name="%computername%" call rename name="MDF-KOM"
```


---------------------


Yes. Open **Command Prompt as Administrator** and run this command:

```cmd
schtasks /create /tn "OLT Offline Download" /tr "D:\Rao_Projects\FTTH\backend\upload\run_olt_offline.bat" /sc hourly /mo 3 /f
```

This creates a Windows scheduled task that runs the batch file **every 3 hours**.

To test immediately:

```cmd
schtasks /run /tn "OLT Offline Download"
```

To check task details:

```cmd
schtasks /query /tn "OLT Offline Download" /v /fo list
```

To delete the task later:

```cmd
schtasks /delete /tn "OLT Offline Download" /f
```

**Recommended command if it should run even when you are not logged in:**

```cmd
schtasks /create /tn "OLT Offline Download" /tr "D:\Rao_Projects\FTTH\backend\upload\run_olt_offline.bat" /sc hourly /mo 3 /ru SYSTEM /rl HIGHEST /f
```

I recommend the **SYSTEM version** for your Python automation.
