#This script will enable the auditing of Powershell.

#Created by: Tanner Cline

#Set variables for all the new registry paths needing to be created:
$regPath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell"
$mlPath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging"
$sbPath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
$modulenamesPath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames"

#See if variables already exist
$regTest = Test-Path -Path $regPath
$mlTest = Test-Path -Path $mlpath
$sbTest = Test-Path -Path $sbPath
$modulesTest = Test-Path -Path $modulenamesPath

#Powershell Registry Test and Creation
if ($regTest -eq 'False')
    {
        New-Item -Path $regPath -Force | Out-Null
        Write-Output "Powershell Module successfully installed"
    }
else
    {
        Write-Host "Powershell registry already exists"
    }

#Powershell/ModuleLogging Registry Test
if ($mlTest -eq 'False')
    {
        New-Item -Path $mlPath -Force | Out-Null
        Write-Output "Powershell Module successfully installed"
    }
else
    {
        Write-Host "Powershell/ModuleLogging registry already exists"
    }

#Powershell/ScriptBlockingLogging Registry Test
if ($sbTest -eq 'False')
    {
        New-Item -Path $sbPath -Force | Out-Null
        Write-Output "Powershell Module successfully installed"
    }
else
    {
        Write-Host "Powershell/ScriptBlockingModule registry already exists"
    }

#Powershell/ModuleLogging/ModuleNames Registry Test
if ($modulesTest -eq 'False')
    {
        New-Item -Path $modulenamesPath -Force | Out-Null
        Write-Output "Powershell Module successfully installed"
    }
else
    {
        Write-Host "Powershell/ModuleLogging/ModuleNames registry already exists"
    }

#Create the DWORD/String values for auditing Powershell:
New-ItemProperty -Path $mlPath -Name EnableModuleLogging -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path $sbPath -Name EnableScriptBlockLogging -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path $modulenamesPath -Name "*" -Value "*" -PropertyType String -Force