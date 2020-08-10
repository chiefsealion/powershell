function Get-NameFromAHat {
$WinnerWinnerChickenDinner = Get-Random -InputObject (Get-Content "C:\Users\tcline\Desktop\Powershell Scripts\Pick-From-Hat.txt")
Write-Host "Today's Winner is: $WinnerWinnerChickenDinner" | clip
}
