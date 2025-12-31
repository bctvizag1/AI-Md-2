To run a `.ps1` PowerShell script file, follow these steps:

---

### ✅ **1. Open PowerShell**

Make sure you open **PowerShell** as an administrator if your script requires elevated privileges.

---

### ✅ **2. Set the Execution Policy (if needed)**

PowerShell may block script execution by default. You can check and change the execution policy:

```powershell
Get-ExecutionPolicy
```

If it's set to `Restricted`, change it with:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

> 🔐 This allows running local scripts, but still requires downloaded scripts to be signed.

---

### ✅ **3. Run the `.ps1` Script**

Use one of the following ways depending on your script location:

#### 🔹 If the script is in the **current directory**:

```powershell
.\scriptname.ps1
```

Example:

```powershell
.\myscript.ps1
```

#### 🔹 If the script is in a **different directory**:

```powershell
C:\Path\To\Your\Script\myscript.ps1
```

> Make sure to use the full path or navigate there with `cd`.

---

### 🧠 Tip: Tab completion helps

Start typing the script name and press **Tab** to auto-complete it.

---

Let me know if your script has parameters or if you need to run it from Task Scheduler, a batch file, or remotely.

---

To **"turn off"** or **revert** the execution policy change made with:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

You can **reset it back to the default** (which is usually `Undefined` at the `CurrentUser` scope) by running:

```powershell
Set-ExecutionPolicy Undefined -Scope CurrentUser
```

---

### 🔍 Explanation:

* `RemoteSigned -Scope CurrentUser` allows running local scripts but blocks unsigned remote ones—for that user only.
* `Undefined` removes the policy at that scope. If no other scopes (like `MachinePolicy`, `Process`, etc.) are set, PowerShell will default to the system-wide policy, often `Restricted`.

---

### 🔎 Check All Scopes:

To see all current execution policies:

```powershell
Get-ExecutionPolicy -List
```

This will show the effective policy at each scope (`MachinePolicy`, `UserPolicy`, `Process`, `CurrentUser`, `LocalMachine`).

---

Let me know if you'd like to permanently disable all script execution or lock down other users.
