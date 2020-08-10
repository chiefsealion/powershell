#This script will enable the audit of successful queries of various items Windows audit.

#Created by: Tanner Cline

#Backup the current auditing
auditpol /backup /file:C:\Temp\PingCastleAutomation\Policy-Audit\auditpolicy.csv

#Set all policies to be enabled (that are checked by PingCastle)
auditpol /set /category:"System","Detailed Tracking","Object Access","Account Management","Account Logon","Logon/Logoff","Policy Change" /success:enable     

#Output results of full audit of categories to a text file
auditpol /get /Category:* > C:\Temp\PingCastleAutomation\Policy-Audit\PolicyAuditResults.txt

#Read and save results for Automate
Get-Content -LiteralPath C:\Temp\PingCastleAutomation\Policy-Audit\PolicyAuditResults.txt



