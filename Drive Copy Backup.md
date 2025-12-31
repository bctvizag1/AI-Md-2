To back up a drive in Windows using Command Prompt (CMD), you can use built-in tools like **`xcopy`**, **`robocopy`**, or **`wbadmin`** (for system and image backups). Here's a quick breakdown depending on what you need:

---

### ✅ 1. **Copy files from one drive to another using `robocopy`** (recommended for file backups):

```cmd
robocopy D:\ E:\Backup /E /Z /XA:H /W:5 /R:3 /LOG:C:\backup_log.txt
```

**Explanation:**

* `D:\` – Source drive
* `E:\Backup` – Destination directory
* `/E` – Copy all subfolders, including empty ones
* `/Z` – Enables restartable mode (helpful if the connection is lost)
* `/XA:H` – Excludes hidden files
* `/W:5` – Wait 5 seconds between retries
* `/R:3` – Retry 3 times on failure
* `/LOG:` – Save a log of the backup

---

### ✅ 2. **Use `xcopy` for simpler file copying:**

```cmd
xcopy D:\* E:\Backup\ /E /H /C /I
```

**Explanation:**

* `/E` – Copy all subfolders, even if they are empty
* `/H` – Copy hidden and system files
* `/C` – Continue even if errors occur
* `/I` – Assume destination is a folder

---

### ✅ 3. **Create a system image using `wbadmin`** (for system or full volume backup):

```cmd
wbadmin start backup -backupTarget:E: -include:C: -allCritical -quiet
```

**Explanation:**

* `-backupTarget:E:` – Destination drive
* `-include:C:` – Source drive
* `-allCritical` – Includes system state and critical volumes
* `-quiet` – Runs without prompts

> ⚠️ Note: `wbadmin` requires administrator privileges and is only available in **Pro**, **Enterprise**, and **Server** editions of Windows.

---

### 🔐 **Run Command Prompt as Administrator**

For most of these commands (especially `wbadmin`), you must:

* Press `Windows + X`, choose **"Command Prompt (Admin)"** or **"Windows Terminal (Admin)"**.

---

Let me know if you're backing up to an external drive, network location, or need scheduled automatic backups.
