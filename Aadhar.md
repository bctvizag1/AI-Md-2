
> 0704_Admin3  
> SARKhZ1PWS

> KAwJHEQEfD

```cmd
net stop "AADHAAR Camera Vendor Device Manager"
net stop "aouc"
net stop "mpdm"
net stop "qssitvs"
```

```cmd
cd "c:\UID Authority of India\Aadhaar Enrolment Client\data"
ren lvs "lvs_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%"

md lvs
```

```cmd
cd "c:\UID Authority of India\Aadhaar Enrolment Client\data"
ren packets-auto "packetsauto_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%"

md packets-auto
```

```cmd
net start "qssitvs"
net start "mpdm"
net start "aouc"
net start "AADHAAR Camera Vendor Device Manager"

```

## Unexpected PC Shutdown log
```cmd
wevtutil qe System /q:"*[System[(EventID=6008)]]" /c:5 /f:text /rd:true | find "unexpected"

```
## PC Serial Number
```
wmic bios get serialnumber
```

### user Account Expires
```cmd
wmic useraccount where name="ITAdmin" set PasswordExpires=False

net user ITAdmin  /expires:never

```

### open cmd as Admin

```cmd
runas /savecred /user:ITAdmin "cmd.exe"
```

# Run PowerShell as Administrator
```powershell
Add-Content -Path "$env:SystemRoot\System32\drivers\etc\hosts" -Value "10.198.215.33 smaxems.cdrdc.bsnl.co.in"
```