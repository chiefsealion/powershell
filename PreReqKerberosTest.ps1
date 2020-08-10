#Set Variable for Repadmin.exe File Location
$testRepadminPath = Test-Path C:\Windows\System32\repadmin.exe

#Set Variable for RPCPING.EXE File Location
$testRpcpingPath = Test-Path C:\Windows\System32\RpcPing.exe

#Check to see if Server is ready to complete Kerberos PW Reset
Write-Host '     Checking for ActiveDirectory Powershell Module.........' -NoNewline
If (Get-Module -List ActiveDirectory) {Write-Host -ForegroundColor Green 'PASSED!'}
Else {Write-Host 'Failed. Attempting to install this module for you. Please re-run script in 1 minute. If still failing, install manually.';
        Install-WindowsFeature -Name RSAT-AD-PowerShell}

Write-Host '     Checking for GroupPolicy Powershell Module.......' -NoNewline
If (Get-Module -List GroupPolicy) {Write-Host -ForegroundColor Green 'PASSED!'}
Else {Write-Host 'Failed. Attempting to install this module for you. Please re-run script in 1 minute. If still failing, install manually.';
        Install-WindowsFeature -Name GPMC}

Write-Host '     Checking for REPADMIN.EXE.......' -NoNewline
If ($testRepadminPath -eq $true) {Write-Host -ForegroundColor Green 'PASSED!'}
Else {Write-Host -ForegroundColor Red 'FAILED! Make sure this is a Domain Controller!'}

Write-Host '     Checking for RPCPING.EXE.......' -NoNewline
If ($testRpcpingPath -eq $true) {Write-Host -ForegroundColor Green 'PASSED!'}
Else {Write-Host -ForegroundColor Red 'FAILED! Please install this and try again!'}