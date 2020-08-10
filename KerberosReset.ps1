Import-Module ActiveDirectory

Function GenerateStrongPassword ([Parameter(Mandatory=$true)][int]$PasswordLenght)
{
Add-Type -AssemblyName System.Web
$PassComplexCheck = $false
do {
$newPassword=[System.Web.Security.Membership]::GeneratePassword($PasswordLenght,1)
If ( ($newPassword -cmatch "[A-Z\p{Lu}\s]") `
-and ($newPassword -cmatch "[a-z\p{Ll}\s]") `
-and ($newPassword -match "[\d]") `
-and ($newPassword -match "[^\w]")
)
{
$PassComplexCheck=$True
}
} While ($PassComplexCheck -eq $false)
return $newPassword
}

$secureKerbTGTPassword = GenerateStrongPassword(24)


Set-ADAccountPassword -Identity testkrbtgt -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$secureKerbTGTPassword" -Force)
Write-Host ' '
Write-Host ' '
Write-Host ' '
Write-Host 'Congratulations, you have successfully updated the Kerberos password.'
