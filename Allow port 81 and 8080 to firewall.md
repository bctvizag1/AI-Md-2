You can allow ports **81** and **8080** through Windows Firewall using the `netsh` command. Run these in an **elevated Command Prompt (Run as Administrator):**

```bat
netsh advfirewall firewall add rule name="Allow Port 81" dir=in action=allow protocol=TCP localport=81
netsh advfirewall firewall add rule name="Allow Port 8080" dir=in action=allow protocol=TCP localport=8080
```

✅ Explanation:

* `name=` → Friendly rule name (can be anything).
* `dir=in` → Applies to incoming traffic.
* `action=allow` → Allows the traffic.
* `protocol=TCP` → Most common for web apps.
* `localport=` → Port number to allow.

If you also need **UDP**, run:

```bat
netsh advfirewall firewall add rule name="Allow Port 81 UDP" dir=in action=allow protocol=UDP localport=81
netsh advfirewall firewall add rule name="Allow Port 8080 UDP" dir=in action=allow protocol=UDP localport=8080
```

---

👉 Do you want me to give you a **PowerShell version** too (simpler with `New-NetFirewallRule`), or will you stick to `netsh`?

----------------------
----------------------
Great 👍 Here’s the **PowerShell equivalent** for allowing ports **81** and **8080** in Windows Firewall. Run these in an **elevated PowerShell (Run as Administrator):**

```powershell
# Allow TCP ports 81 and 8080
New-NetFirewallRule -DisplayName "Allow Port 81 TCP" -Direction Inbound -Protocol TCP -LocalPort 81 -Action Allow
New-NetFirewallRule -DisplayName "Allow Port 8080 TCP" -Direction Inbound -Protocol TCP -LocalPort 8080 -Action Allow

# If you also need UDP
New-NetFirewallRule -DisplayName "Allow Port 81 UDP" -Direction Inbound -Protocol UDP -LocalPort 81 -Action Allow
New-NetFirewallRule -DisplayName "Allow Port 8080 UDP" -Direction Inbound -Protocol UDP -LocalPort 8080 -Action Allow
```

✅ **Notes:**

* `-DisplayName` is the friendly name you’ll see in the Firewall UI.
* `-Direction Inbound` → allows incoming traffic.
* Works on Windows 8/2012 and later (PowerShell v4+).

---

Do you want me to also show you a **single command to allow a range (81–8080)** instead of separate rules?

-------------
--------------
Got it 👍 If you want a **single firewall rule for a port range (81–8080)**, here are the commands:

### PowerShell (preferred on modern Windows):

```powershell
# Allow TCP range 81-8080
New-NetFirewallRule -DisplayName "Allow TCP Ports 81-8080" -Direction Inbound -Protocol TCP -LocalPort 81-8080 -Action Allow

# Allow UDP range 81-8080 (if needed)
New-NetFirewallRule -DisplayName "Allow UDP Ports 81-8080" -Direction Inbound -Protocol UDP -LocalPort 81-8080 -Action Allow
```

### Command Prompt (`netsh` version):

```bat
netsh advfirewall firewall add rule name="Allow TCP Ports 81-8080" dir=in action=allow protocol=TCP localport=81-8080
netsh advfirewall firewall add rule name="Allow UDP Ports 81-8080" dir=in action=allow protocol=UDP localport=81-8080
```

---

👉 Do you want me to also show you how to **list all firewall rules** so you can verify the new ones got added?

--------
--------

Perfect 👍 Here’s how you can **list all Windows Firewall rules**:

---

### ✅ PowerShell (modern & flexible)

Run in **elevated PowerShell**:

```powershell
# List all firewall rules
Get-NetFirewallRule

# Show only enabled inbound rules
Get-NetFirewallRule -Direction Inbound -Enabled True

# Show rule details with ports and protocol
Get-NetFirewallRule | Get-NetFirewallPortFilter | Format-Table Name, Protocol, LocalPort
```

Example:

* `Name` → internal rule name
* `Protocol` → TCP/UDP
* `LocalPort` → which port is allowed

---

### ✅ Command Prompt (`netsh`)

Run in **elevated Command Prompt**:

```bat
netsh advfirewall firewall show rule name=all
```

This dumps all rules with their details (names, ports, action, direction).

---

👉 Do you want me to also show you a **filtered list (only rules for port 81 and 8080)** so you don’t have to scroll through hundreds of entries?


------
------


