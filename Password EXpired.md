To set a user's password to never expire in Windows using the Command Prompt (CMD), you can use the `net user` command or the `wmic` command. Here are both methods:


### Method 1: Using `net user` Command
1. Open **Command Prompt (CMD)** as Administrator.
2. Run the following command:
   ```cmd
   net user [username] /expires:never
   ```
   Replace `[username]` with the actual username of the account.

   **Example:**
   ```cmd
   net user JohnDoe /expires:never
   ```

### Method 2: Using `wmic` Command
1. Open **Command Prompt (CMD)** as Administrator.
2. Run the following command:
   ```cmd
   wmic useraccount where name="[username]" set PasswordExpires=False
   ```
   Replace `[username]` with the actual username.

   **Example:**
   ```cmd
   wmic useraccount where name="JohnDoe" set PasswordExpires=False
   ```

### Verification:
To check if the password is set to never expire, you can use:
```cmd
net user [username] | find "Password expires"
```
or
```cmd
wmic useraccount where name="[username]" get PasswordExpires
```

**Example:**
```cmd
net user JohnDoe | find "Password expires"
```
or
```cmd
wmic useraccount where name="JohnDoe" get PasswordExpires
```

This will confirm whether the password expiration policy has been updated. 

Let me know if you need further assistance!