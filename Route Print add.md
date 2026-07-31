You want to reach the **169.254.205.0/16 network via “Ethernet 3”**, which currently has an APIPA address (169.254.x.x). Windows usually already treats **169.254.0.0/16** as a link-local network, but if you need to explicitly add a route, you can do it manually.

### ✅ Add a route for 169.254.205.0 via Ethernet 3

First, find the **interface index** for *Ethernet 3*:

```
route print
```

Look for something like:

```
Interface List
... 15... Ethernet 3
```

Assume the interface index is `15` (replace if different).

### 👉 Add route command:

```
route add 169.254.205.0 mask 255.255.255.0 0.0.0.0 if 15
```

### 🔒 Make it persistent (optional):

```
route -p add 169.254.205.0 mask 255.255.255.0 0.0.0.0 if 15
```

---

### 💡 Important notes

* `0.0.0.0` as gateway means **directly reachable on that interface**.
* Since 169.254.x.x is **link-local (APIPA)**:

  * It only works if the target device is on the same physical network.
  * No router/gateway is involved.
* Your Ethernet 3 already has:

  ```
  IP: 169.254.205.110
  Mask: 255.255.0.0
  ```

  So it can already reach **169.254.0.0–169.254.255.255** without extra routes in most cases.

---

### ⚠️ If it's not working

Check:

* Cable / physical link
* Target device IP (must also be 169.254.x.x)
* Firewall blocking ICMP/traffic
* Correct subnet mask on both ends

---

If you tell me what device you're trying to reach (PLC, camera, another PC, etc.), I can help you fine-tune the setup 👍
