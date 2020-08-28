## Variables

 

# Restore folder location to check
    $restorePath = "C:\ISO-TestRestore" 
# Grabs the newest file from the test restore folder
    $file = gci $restorePath | sort LastWriteTime | select -last 1
# Grab the number of files in the restore folder to verify test restore has been done
    $filesCount = Get-ChildItem -Path $restorePath | Measure-Object
# Get todays date
    $today = Get-Date
# Subtract 1 month to verify test restores have been done within the last month
    $today = $today.AddMonths(-1)
# Gets last file 
    $currentFile = [datetime](Get-ItemProperty -Path $restorePath\$file -Name LastWriteTime).lastwritetime

 

## Functions

 

# Verifies test restore folder is created, if not note and exit
if (Test-Path $restorePath) {
# Verifies there is a file in the test restore folder, if not note and exit
    if ($filesCount.Count -eq 0) {
        Write-Host "No restore files found."
        } else {
# Verifies the date of the Test restore file has been created within the last month, if not note and exit
            if ($currentFile -lt $today) {
                write-host "Test restored file is out of date" 
            } else {
# If the test restore folder exists, AND there is a file in it, AND that file has been created within the last 30 days, write results
                Get-ItemProperty $restorePath\$file | select Name,LastWriteTime
                } 
        }
    } else {
        Write-Host "No restore folder found."
}