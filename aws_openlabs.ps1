<#
Title:
AWS OpenLabs v2.

Last Updated:
9/5/2018





#>

# Import the Powershell Module
Import-Module AWSPowershell

# dot source the powershell scripts.
. "C:\Users\$env:username\Documents\GitHub\AWS-OpenLabs\aws_user_management.ps1"


# set the credentials and Region
$accessKey = "Key"
$secretkey = "SecretKey"

$Region = "us-east-1" 

# Store the AWS Credentials
Set-AWSCredential -StoreAs "LabProfile" -AccessKey $accesskey -SecretKey $secretkey

# Set the AWS Region
Set-DefaultAWSRegion -Region $Region

# Get the Account ID of the User
$accountID = (Get-STSCallerID).account
$url = -join('https://',$accountID,'/signin.aws.amazon.com/console')


#----------------------------------------

# Get the List of Users
$users = Get-content "C:\Users\$env:username\Documents\GitHub\AWS-OpenLabs\users.txt"

# Specify the group you would like the users to be joined to ( Group = Lab Scenario )

$group = "Intended Group"

# Provision the New Users
New-AWSIAMLabUsers -users $users -group