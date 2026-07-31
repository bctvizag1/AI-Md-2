The proper solution is to configure **PM2 startup**, so PM2 automatically restarts your Node.js applications whenever Ubuntu boots.

### Step 1: Start Both Applications

```bash
cd /home/bsnlproxy/Desktop/ITSERVER/nodeserver_adodb
pm2 start index.js --name nodeserver_adodb


cd /home/bsnlproxy/Desktop/ITSERVER/ServiceDir/backend
pm2 start src/index.js --name backend
```

Verify:

```bash
pm2 list
```

---

### Step 2: Save the PM2 Process List

```bash
pm2 save
```

You should see:

```text
[PM2] Successfully saved in ~/.pm2/dump.pm2
```

---

### Step 3: Configure PM2 to Start on Boot

Run:

```bash
pm2 startup
```

PM2 will output a command similar to:

```bash
sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u bsnlproxy --hp /home/bsnlproxy
```

Copy and execute the exact command PM2 displays.

Example:

```bash
sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u bsnlproxy --hp /home/bsnlproxy
```

---

### Step 4: Save Again

After enabling startup:

```bash
pm2 save
```

---

### Step 5: Test

Reboot the server:

```bash
sudo reboot
```

After login:

```bash
pm2 list
```

Both applications should already be running.

---

### Verify Systemd Service

```bash
systemctl status pm2-bsnlproxy
```

It should show:

```text
active (running)
```

---

### If Applications Still Don't Start

Check logs:

```bash
pm2 logs
```

and

```bash
journalctl -u pm2-bsnlproxy
```

---

### Alternative (Recommended for Production)

Instead of relying solely on PM2, you can create dedicated **systemd services** for each application. This gives better control, automatic restarts on crashes, startup ordering, and easier monitoring.

If this is a production server, I can provide complete `systemd` service files for:

* `/home/bsnlproxy/Desktop/ITSERVER/nodeserver_adodb/index.js`
* `/home/bsnlproxy/Desktop/ITSERVER/ServiceDir/backend/src/index.js`

which is generally more robust than manual `pm2 start` commands.
