# Ref. guide https://cloudsolutionist.com/virtual-machine-custom-guest-policies/

# First run ./MSI_installer.ps1 to generate mof

# Make zip package
New-GuestConfigurationPackage `
  -Name 'InstallMSIv2' `
  -Configuration 'InstallMSIv2\localhost.mof' `
  -Type AuditAndSet `
  -Force
  
# Make zip available on github

# Create policy
$ContentURIMSI = 'https://github.com/jeircul/msi/raw/master/InstallMSIv2/InstallMSIv2.zip'
New-GuestConfigurationPolicy `
  -PolicyId 'VM-Guest-Policy-MSIv2' `
  -ContentUri $ContentURIMSI `
  -DisplayName 'VM Guest Policy MSI Deploy v2' `
  -Description 'This Policy deploys several software applications on the Server' `
  -Path '.\policyv2' `
  -Platform 'Windows' `
  -Version 1.0.0 `
  -Mode 'ApplyAndAutoCorrect' `
  -Verbose

# Publish policy
$Subscription = Get-AzSubscription -SubscriptionName 'Q901-platform-dev'
New-AzPolicyDefinition `
    -Name 'VM-Guest-Policy-MSI-v2' `
    -Policy 'policyv2\DeployIfNotExists.json' `
    -SubscriptionId $($Subscription.Id)


# Test commands
Get-AzPolicyState -PolicyDefinitionName 'VM-Guest-Policy-MSI-v2'
Start-AzPolicyComplianceScan -ResourceGroupName 'rg-ovea' -Verbose