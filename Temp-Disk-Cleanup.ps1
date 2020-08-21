#Set variable to Retrieve the usernames for all users that have used this computer and store them in a txt file to be used for later
$getUsers = (Get-ChildItem -Path C:\Users).Name | Out-File C:\Windows\LTSvc\Users.txt

#Grab the list of each user that has ever signed into the computer
$Users = Get-Content -Path C:\Windows\LTSvc\Users.txt

#Set the path for each variable
$pathTemp = "C:\Temp"
$pathWindowsTemp = "C:\Windows\Temp"
$pathTempIntFiles = "C:\Users\$User\AppData\Local\Temporary Internet Files"
$pathLocalTemp = "C:\Users\$User\Appdata\Local\Temp"
$pathMicroTempIntFiles = "C:\Users\$User\AppData\Microsoft\Windows\Temporary Internet Files"

#Get size of Windows directories
$Temp = "{0:N2} GB" -f ((gci $pathTemp | measure Length -s).Sum /1GB)
$WindowsTemp = "{0:N2} GB" -f ((gci $pathWindowsTemp | measure Length -s).Sum /1GB)

#Create txt file to store information for size of each directory
New-Item -Path "C:\Windows\LTSvc\packages\DiskCleanupLogs" -Name "SizeofEachDirectory_PreScan.txt" -ItemType "File"

#Store variables just gathered for prescan results to correct directory
Add-Content -Path 'C:\Windows\LTSvc\packages\DiskCleanupLogs\SizeofEachDirectory_PreScan.txt' -Value "The size of the $pathTemp is $temp"
Add-Content -Path 'C:\Windows\LTSvc\packages\DiskCleanupLogs\SizeofEachDirectory_PreScan.txt' -Value "The size of the $pathWindowsTemp is $windowsTemp"

#Force a cleaning of the Recycle Bin
Clear-RecycleBin -Force

#Transcript the deletion of C:\Temp
Start-Transcript -Path "C:\Windows\LTSvc\packages\DiskCleanupLogs\DiskClean_Temp.txt"
Remove-Item -Path $pathTemp -Include '*' -Recurse -WhatIf
Stop-Transcript

#Transcript the deletion of C:\Windows Temp
Start-Transcript -Path "C:\Windows\LTSvc\packages\DiskCleanupLogs\DiskClean_WindowsTemp.txt"
Remove-Item -Path $pathWindowsTemp -Include '*' -Recurse -WhatIf
Stop-Transcript

#Transcript the deletion of C:\Users\username\AppData\Local\Temporary Internet Files

Start-Transcript -Path "C:\Windows\LTSvc\packages\DiskCleanupLogs\DiskClean_TempIntFiles.txt"

foreach($User in $Users){

$pathTempIntFiles = "C:\Users\$User\AppData\Local\Temporary Internet Files"
$TempIntFiles = "{0:N2} GB" -f ((gci $pathTempIntFiles | measure Length -s).Sum /1GB)
Add-Content -Path 'C:\Windows\LTSvc\packages\DiskCleanupLogs\SizeofEachDirectory_PreScan.txt' -Value "The size of the $pathTempIntFiles is $TempIntFiles"
Remove-Item -Path $pathTempIntFiles -Include '*' -Recurse -WhatIf
Remove-Item -Path $pathTempIntFiles -Include '*' -Recurse

}

Stop-Transcript

#Transcript the deletion of C:\Users\username\AppData\Local\Temp

Start-Transcript -Path "C:\Windows\LTSvc\packages\DiskCleanupLogs\DiskClean_LocalTemp.txt"

foreach($User in $Users){

$pathLocalTemp = "C:\Users\$User\Appdata\Local\Temp"
$LocalTemp = "{0:N2} GB" -f ((gci $pathMicroTempIntFiles | measure Length -s).Sum /1GB)
Add-Content -Path 'C:\Windows\LTSvc\packages\DiskCleanupLogs\SizeofEachDirectory_PreScan.txt' -Value "The size of the $pathLocalTemp is $LocalTemp"
Remove-Item -Path $pathLocalTemp -Include '*' -Recurse -WhatIf
Remove-Item -Path $pathLocalTemp -Include '*' -Recurse

}

Stop-Transcript

#Transcript the deletion of C:\Users\username\AppData\Microsoft\Windows\Temporary Internet Files

Start-Transcript -Path "C:\Windows\LTSvc\packages\DiskCleanupLogs\DiskClean_MicroTempFiles.txt"

foreach($User in $Users){

$pathMicroTempIntFiles = "C:\Users\$User\AppData\Microsoft\Windows\Temporary Internet Files"
$MicroTempIntFiles = "{0:N2} GB" -f ((gci $pathMicroTempIntFiles | measure Length -s).Sum /1GB)
Add-Content -Path 'C:\Windows\LTSvc\packages\DiskCleanupLogs\SizeofEachDirectory_PreScan.txt' -Value "The size of the $pathMicroTempIntFiles is $MicroTempIntFiles"
Remove-Item -Path $pathMicroTempIntFiles -Include '*' -Recurse -WhatIf
Remove-Item -Path $pathMicroTempIntFiles -Include '*' -Recurse

}

Stop-Transcript

#Grab the values just gathered for user to see
Get-Content -Path 'C:\Windows\LTSvc\packages\DiskCleanupLogs\SizeofEachDirectory_PreScan.txt'
Copy-Item 'C:\Windows\LTSvc\packages\DiskCleanupLogs\SizeofEachDirectory_PreScan.txt' -Destination 'C:\Windows\LTSvc' -Force


#Deleting the Windows Temp Files Here

Remove-Item -Path $pathTemp -Include '*' -Recurse
Remove-Item -Path $pathWindowsTemp -Include '*' -Recurse

#Remove Size of Directory txt file for next use
Remove-Item -Path "C:\Windows\LTSvc\packages\DiskCleanupLogs\SizeofEachDirectory_PreScan.txt"

#Script Completion
Write-Host "The process is complete. The directories have been cleaned successfully to your best permission level."
