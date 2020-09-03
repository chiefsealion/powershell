# Loads Veeam Powershell Snapin
Add-PSSnapin -Name VeeamPSSnapIn


# Name of Server we are testing the restore for
$vmName = "SE-FILE"

# Path to the file we are restoring
$originalFiles = "C:\Temp\acctinfo.dll"


# Path to the folder we would like to restore the file TO
$destPath = "\\SE-FILE\c$\ISO-TestRestore"


# Loads the latest restore point for the server
$result = Get-VBRBackup | Get-VBRRestorePoint | sort CreationTime -Descending | where {$_.VMName -eq "$vmName"} | select -First 1
$restore = $result | Start-VBRWindowsFileRestore


# Copies the test restore file to the destination path
foreach ($file in $originalFiles) {
    
    # Find the Veeam Backup mount point for the specific drive letter
    $flrmountpoint = ($restore.MountSession.MountedDevices | ? {$_.DriveLetter -eq (Split-Path $file -Qualifier)}).MountPoint

    # Build the path to the file via the mount point
    $file = $flrmountpoint + (Split-Path $file -NoQualifier)

    # Copy/Restore the files to KTESTDB
    Copy-Item $file $destPath -Force
    }


# Removes the restore session
Stop-VBRWindowsFileRestore  $restore
