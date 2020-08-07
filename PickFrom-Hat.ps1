$cred = Get-Credential

$WinnerWinnerChickenDinner = Get-Random -InputObject (Get-Content "C:\Users\tcline\Desktop\Powershell Scripts\Pick-From-Hat.txt")

Send-MailMessage -From 'tcline@isoutsource.com ' -To 'jthorson@isoutsource.com ', 'nchapman@isoutsource.com ' -Subject "Today's Winner is: $WinnerWinnerChickenDinner" -SmtpServer smtp.office365.com -UseSsl -Credential $cred -Port 587