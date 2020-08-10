#This script will create a Global Security Group called Managed Service Accounts. Then, it will create a Fine Grained Password Policy, directly enforcing anything added to the Security Group created.

#Created by: Tanner Cline

#Create a Security Group called Managed Service Accounts within the Managed Service Accounts CN
New-ADGroup -Name "Managed Service Acccounts" -SamAccountName ManagedServiceAccounts -GroupCategory Security -GroupScope Global -DisplayName "Managed Service Accounts" -Path "CN=Managed Service Accounts,DC=SymmetryElect,DC=local" -Description "Per PingCastle, Created Security Group"

#Create a Fine Grained Password Policy, call it MSA_LongerPassword and apply variable changes as requested on PingCasle Reporting
New-ADFineGrainedPasswordPolicy -Name "MSA_LongerPassword" -Precedence 1 -ComplexityEnabled $true -Description "Per PingCastle, larger complexity for Managed Service Accounts" -DisplayName "Managed Service Accounts" -LockoutThreshold 10 -MaxPasswordAge "180.00:00:00" -MinPasswordLength 20

#Directly add the Managed Service Accounts Security Group to the newly created password policy
Add-ADFineGrainedPasswordPolicySubject MSA_LongerPassword -Subjects 'Managed Service Accounts'