On Windows, collecting “complete logs” usually means pulling **Event Viewer logs, firewall logs, and possibly system/network traces**. Here are the key commands you’d use as an administrator:

---

### 🔹 1. Export Event Logs (System, Security, Application)

Using **wevtutil** (built-in CLI tool):

```cmd
wevtutil epl System C:\Logs\System.evtx
wevtutil epl Security C:\Logs\Security.evtx
wevtutil epl Application C:\Logs\Application.evtx
```

You can also export all logs:

```cmd
wevtutil el > C:\Logs\loglist.txt
for /F "tokens=*" %i in (C:\Logs\loglist.txt) do wevtutil epl "%i" "C:\Logs\%i.evtx"
```

---

### 🔹 2. Use PowerShell to Export Logs

```powershell
New-Item -ItemType Directory -Path C:\Logs

Get-WinEvent -LogName System | Export-Clixml C:\Logs\System.xml
Get-WinEvent -LogName Security | Export-Clixml C:\Logs\Security.xml
Get-WinEvent -LogName Application | Export-Clixml C:\Logs\Application.xml
```

---

### 🔹 3. Collect Firewall Logs

Check if logging is enabled and locate the file:

```cmd
netsh advfirewall show currentprofile logging
```

Default log location is usually:

```cmd
C:\Windows\System32\LogFiles\Firewall\pfirewall.log
```

Copy it:

```cmd
copy C:\Windows\System32\LogFiles\Firewall\pfirewall.log C:\Logs\
```

---

### 🔹 4. Capture Network Trace (for malicious communication)

```cmd
netsh trace start capture=yes tracefile=C:\Logs\nettrace.etl
```

Stop after some time:

```cmd
netsh trace stop
```

---

### 🔹 5. Check Active Connections (quick snapshot)

```cmd
netstat -ano > C:\Logs\netstat.txt
```

---

### 🔹 6. System Information (useful for investigation)

```cmd
systeminfo > C:\Logs\systeminfo.txt
tasklist > C:\Logs\tasks.txt
```

---

### 🔹 7. Optional: Use Windows Built-in Diagnostic Tool

```cmd
perfmon /report
```

---

### 📌 Notes

* Run all commands **as Administrator**
* Ensure `C:\Logs` exists before exporting
* Focus especially on **Security logs** (Event IDs like 4624, 4625, 4688, etc.) for suspicious activity

---

If you want, I can narrow this down to a **minimal incident-response checklist** or provide **specific event IDs to investigate for malicious outbound traffic**.
