To enable .NET Framework 3.5 in Windows 10 using an installation USB drive, you need to use the Deployment Image Servicing and Management (DISM) command from an elevated Command Prompt. This method is suitable for offline installations where the computer cannot access Windows Update. [1, 2, 3, 4]  
Prerequisites 

• A Windows 10 installation USB drive. 
• The drive letter of your USB drive (e.g., , ). 
• Administrative privileges on the Windows 10 computer. [5, 6, 7, 8, 9]  

Steps 

1. Insert the Windows 10 installation USB drive into your computer. 
2. Open Command Prompt as an administrator: 

	• Click the Start button. 
	• Type  in the search bar. 
	• Right-click on Command Prompt in the results and select Run as administrator. 
	• Click Yes if prompted for User Account Control (UAC) consent. 

3. Run the DISM command to install the feature, replacing  with the actual letter of your USB drive: 
```cmd
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /LimitAccess /Source:<drive_letter>:\sources\sxs

```
4. For example, if your USB drive is , the command would be: 
```cmd
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /LimitAccess /Source:E:\sources\sxs

```
	• The  parameter targets the running operating system. 
	• The  parameter specifies the .NET Framework 3.5 feature. 
	• The  parameter enables all parent features. 
	• The  parameter prevents DISM from trying to contact Windows Update online, forcing it to use only the specified source. 
	• The  parameter specifies the path to the  folder on your installation media. 

5. Wait for the process to complete. A progress bar will appear, and once finished, it should indicate that the operation completed successfully. 
6. Restart your computer if prompted. Otherwise, you can type  and press Enter to close the Command Prompt window. [1, 2, 3, 10, 11]  

AI responses may include mistakes.

[1] https://docs.johnsoncontrols.com/bas/r/BCPro/en-US/BCT-Installation-Guide/13.2/Windows-10/Installing-Microsoft-.NET-Framework-3.5-Features-without-Internet-Connection
[2] https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/deploy-net-framework-35-by-using-deployment-image-servicing-and-management--dism?view=windows-11
[3] https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/deploy-net-framework-35-by-using-deployment-image-servicing-and-management--dism?view=windows-11
[4] https://community.spiceworks.com/t/how-to-enable-net-framework-3-5-on-windows-10-offline/1011027
[5] https://www.youtube.com/watch?v=w7hCd8Sum9Y
[6] https://learn.microsoft.com/en-ie/answers/questions/5648361/net-framework-3-5-offline-installer-for-windows-10
[7] https://learn.microsoft.com/en-us/answers/questions/5648361/net-framework-3-5-offline-installer-for-windows-10
[8] https://learn.microsoft.com/en-us/answers/questions/4114321/im-trying-to-use-windows-recovery-and-im-am-not-su
[9] https://www.professormesser.com/professor-messer-archives/220-1002/microsoft-command-line-tools/
[10] https://learn.microsoft.com/en-us/dotnet/framework/install/dotnet-35-windows
[11] https://www.youtube.com/watch?v=Cbw3zRryNUU

