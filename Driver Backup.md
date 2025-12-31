To **back up an Ethernet (network) driver** in Windows using the **Command Prompt**, you can use the built-in **`pnputil`** tool or manually copy the driver files from the DriverStore. Here's how to do both:

---

### ✅ Method 1: **Using `pnputil` to export the Ethernet driver**

1. **Open Command Prompt as Administrator:**

   * Press `Windows + X`, then click **"Command Prompt (Admin)"** or **"Windows Terminal (Admin)"**.

2. **Find the Ethernet driver:**

```cmd
pnputil /enum-drivers
```

Look for a driver with a name like `Intel(R) Ethernet`, `Realtek`, `Broadcom`, etc.

Note the **Published Name**, e.g., `oem25.inf`.

3. **Export the driver:**

```cmd
pnputil /export-driver oem25.inf C:\DriverBackup
```

This command backs up the driver to `C:\DriverBackup`. You can change the destination as needed.

---

### ✅ Method 2: **Export all installed drivers (including Ethernet):**

If you're unsure which is the Ethernet driver, you can export all 3rd-party drivers:

```cmd
pnputil /export-driver * C:\DriverBackup
```

This creates a full backup of all installed drivers.

---

### ✅ Method 3: **Alternative using DISM:**

```cmd
dism /online /export-driver /destination:C:\DriverBackup
```

This exports **all 3rd-party drivers**, including network drivers, from the DriverStore.

---

### 🧪 To restore the driver later:

Use Device Manager or run:

```cmd
pnputil /add-driver C:\DriverBackup\YourDriver.inf /install
```

---

Let me know if you want to target a specific Ethernet driver by name or have issues locating it.
