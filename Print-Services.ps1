#This script will stop the print spooler service on a DC Server,  and uninstall Print Management if installed. 

#Please make sure, before continuing with this script, that you check with Primary and have the OK to follow through

#This script does not require a reboot

#Created by: Tanner Cline


#
#
#
#
#
#
#

#Set variable to get print spooler service status

$spoolerService = Get-Service Spooler

#Set variable to get status of Print Management Feature

$printFeature = Get-WindowsFeature -Name Print-Services

#If the Print Spooler service is Running, stop the Spooler service
if ($spoolerService.Status -eq 'Running')
    { 
        Write-Host "The service is running. Attempting to stop and disable."
        Stop-Service Spooler
        Set-Service -Name Spooler -StartupType Disabled
        
    }
else {
        Write-Host "The Spooler service either is stopped or does not exist."
    }

#If the Print Management feature is installed, uninstall it. 
if ($printFeature.InstallState -eq 'Installed')
    {
        Write-Host "The Print Management feature is installed. Attempting to uninstall."
        Uninstall-WindowsFeature -Name Print-Services
    }
else {
        Write-Host "The Print Management Feature is not installed."
    }
