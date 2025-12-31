```cmd
ssh bsnlproxy@10.34.130.254
```

```bash
cd /mnt/fileUploadVolume/nodeserver_adodb/
```

```bash
pm2 start index.js --name=localserver
```

```bash
cd /mnt/fileUploadVolume/ServiceDir/backend
```

```bash
pm2 start src/index.js --name=ipdata
```


```bash
pm2 monit
```

### Restart MySQL

```
sudo systemctl restart mysql
```