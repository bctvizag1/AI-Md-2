
### Windows activation sctipt

PowerShell as Administrator. 
```Powershell
irm https://get.activated.win | iex
```

----------------

That command is a **PowerShell one-liner** that downloads and executes code from the internet:

- **`irm`** is shorthand for `Invoke-RestMethod`. It fetches content from a URL (in this case, `https://get.activated.win`).
- The pipe (`|`) sends the downloaded content directly into the next command.
- **`iex`** is shorthand for `Invoke-Expression`. It takes whatever text it receives and runs it as PowerShell code.





[1] https://massgrave.dev/
[2] https://www.linkedin.com/posts/csebelal9_how-to-activate-windows-office-activity-7356972084440281088-nW99
[3] https://zenodo.org/records/13826287
[4] https://jamisonjohnson.me/blog/windows/using-microsoft-activation-scripts/
[5] https://blog.ssuiteoffice.com/articles/microsoft/how-to-activate-windows-with-powershell-without-a-key.htm
[6] https://www.sharepointdiary.com/2022/11/check-windows-activation-status-with-powershell.html

