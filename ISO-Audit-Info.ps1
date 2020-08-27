<#-------------------------------------------------------------
Collecting information from Active Directory into log files for analysis


-------------------------------------------------------------#>

Get-ADComputer -Filter * -Properties * | Sort LastLogonDate | ft CN, Created, LastLogonDate, PasswordLastSet, WhenChanged -AutoSize | out-file c:\temp\AD-ComputerAudit-a.txt

Get-ADUser -Filter * -Properties * | sort SAMAccountName | ft LastLogonDate, Name, SAMAccountName, Enabled, Passwordlastset, whencreated -AutoSize | out-file c:\temp\AD-UsersAudit-a.txt
Get-ADUser -Filter * -Properties * | sort SAMAccountName | ft SAMAccountName, PasswordLastSet -AutoSize | out-file c:\temp\AD-UsersAudit-b.txt
Get-ADUser -Filter * -Properties * | sort SAMAccountName | ft SAMAccountName, LastLogonDate, Enabled,  msExchHideFromAddressLists -AutoSize | out-file c:\temp\AD-UsersAudit-e.txt
Get-ADUser -Filter * -Properties * | sort SAMAccountName | ft SAMAccountName, msExchShadowProxyAddresses -AutoSize | out-file c:\temp\AD-UsersAudit-m1.txt
Get-ADUser -Filter * -Properties * | sort SAMAccountName | ft SAMAccountName, mail -AutoSize | out-file c:\temp\AD-UsersAudit-m2.txt
Get-ADUser -Filter * -Properties * | sort SAMAccountName | ft SAMAccountName, ProxyAddresses -AutoSize | out-file c:\temp\AD-UsersAudit-m3.txt

Get-adGroup -filter * -property * | where{($_.mail -ne $null)} | sort name | fl name, mail, groupcategory, groupscope, member, members | out-file c:\temp\AD-GroupAudit-a.txt
Get-adGroup -filter * -property * | sort name | fl name, Description, CreatedTimeStamp, ManagedBy, Modified  | out-file c:\temp\AD-GroupAudit-b.txt
