#Set the path for each variable
$pathTemp = "C:\Temp"
$pathWindowsTemp = "C:\Windows\Temp"
$pathTempIntFiles = "C:\Users\username\AppData\Local\Temporary Internet Files"
$pathLocalTemp = "C:\Users\username\AppData\Local\Temp"
$pathMicroTempIntFiles = "C:\Users\username\AppData\Microsoft\Windows\Temporary Internet Files"

#Create txt file to store information for size of each directory
New-Item -Path "C:\Windows\LTSvc\packages\Disk Cleanup Logs" -Name "SizeofEachDirectory_PreScan.txt" -ItemType "File"

#Check to see the size of the directories targeted for deletion
$temp = "{0:N2} GB" -f ((gci $pathTemp | measure Length -s).Sum /1GB)
$windowsTemp = "{0:N2} GB" -f ((gci $pathWindowsTemp | measure Length -s).Sum /1GB)
$TempIntFiles = "{0:N2} GB" -f ((gci $pathTempIntFiles | measure Length -s).Sum /1GB)
$LocalTemp = "{0:N2} GB" -f ((gci $pathLocalTemp | measure Length -s).Sum /1GB)
$MicroTempIntFiles = "{0:N2} GB" -f ((gci $pathMicroTempIntFiles | measure Length -s).Sum /1GB)

#Store variables just gathered for prescan results to correct directory
Add-Content -Path 'C:\Windows\LTSvc\packages\Disk Cleanup Logs\SizeofEachDirectory_PreScan.txt' -Value "The size of the $pathTemp is $temp"
Add-Content -Path 'C:\Windows\LTSvc\packages\Disk Cleanup Logs\SizeofEachDirectory_PreScan.txt' -Value "The size of the $pathWindowsTemp is $windowsTemp"
Add-Content -Path 'C:\Windows\LTSvc\packages\Disk Cleanup Logs\SizeofEachDirectory_PreScan.txt' -Value "The size of the $pathTempIntFiles is $TempIntFiles"
Add-Content -Path 'C:\Windows\LTSvc\packages\Disk Cleanup Logs\SizeofEachDirectory_PreScan.txt' -Value "The size of the $pathLocalTemp is $LocalTemp"
Add-Content -Path 'C:\Windows\LTSvc\packages\Disk Cleanup Logs\SizeofEachDirectory_PreScan.txt' -Value "The size of the $pathMicroTempIntFiles is $MicroTempIntFiles"

#Grab the values just gathered for user to see
Get-Content -Path 'C:\Windows\LTSvc\packages\Disk Cleanup Logs\SizeofEachDirectory_PreScan.txt'

#Force a cleaning of the Recycle Bin
Clear-RecycleBin -Force

#Transcript the deletion of C:\Temp
Start-Transcript -Path "C:\Windows\LTSvc\packages\Disk Cleanup Logs\DiskClean_Temp.txt"
Remove-Item -Path $pathTemp -Include '*' -Recurse -WhatIf
Stop-Transcript

#Transcript the deletion of C:\Windows Temp
Start-Transcript -Path "C:\Windows\LTSvc\packages\Disk Cleanup Logs\DiskClean_WindowsTemp.txt"
Remove-Item -Path $pathWindowsTemp -Include '*' -Recurse -WhatIf
Stop-Transcript

#Transcript the deletion of C:\Users\username\AppData\Local\Temporary Internet Files
Start-Transcript -Path "C:\Windows\LTSvc\packages\Disk Cleanup Logs\DiskClean_TempIntFiles.txt"
Remove-Item -Path $pathTempIntFiles -Include '*' -Recurse -WhatIf
Stop-Transcript

#Transcript the deletion of C:\Users\username\AppData\Local\Temp
Start-Transcript -Path "C:\Windows\LTSvc\packages\Disk Cleanup Logs\DiskClean_LocalTemp.txt"
Remove-Item -Path $pathLocalTemp -Include '*' -Recurse -WhatIf
Stop-Transcript

#Transcript the deletion of C:\Users\username\AppData\Microsoft\Windows\Temporary Internet Files
Start-Transcript -Path "C:\Windows\LTSvc\packages\Disk Cleanup Logs\DiskClean_MicroTempFiles.txt"
Remove-Item –path $pathMicroTempIntFiles -Include '*' -Recurse -WhatIf
Stop-Transcript

#***ACTUALLY DELETING THE FILES HERE***
Remove-Item -Path $pathTemp -Include '*' -Recurse
Remove-Item -Path $pathWindowsTemp -Include '*' -Recurse
Remove-Item -Path $pathTempIntFiles -Include '*' -Recurse
Remove-Item -Path $pathLocalTemp -Include '*' -Recurse
Remove-Item –path $pathMicroTempIntFiles -Include '*' -Recurse

Write-Host "The process is complete. The directories have been cleaned successfully to your best permission level."
