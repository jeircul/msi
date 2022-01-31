# Ref. guide https://cloudsolutionist.com/virtual-machine-custom-guest-policies/

# First run ./MSI_installer.ps1 to generate mof

# Make zip package
New-GuestConfigurationPackage `
  -Name 'InstallMSI' `
  -Configuration 'InstallMSI\localhost.mof' `
  -Type AuditAndSet `
  -Force
  
# Make zip available on github

# Create policy
$ContentURIMSI = 'https://github.com/jeircul/msi/raw/master/InstallMSI/InstallMSI.zip'
New-GuestConfigurationPolicy `
  -PolicyId 'VM-Guest-Policy-MSI' `
  -ContentUri $ContentURIMSI `
  -DisplayName 'VM Guest Policy MSI Deploy' `
  -Description 'This Policy deploys several software applications on the Server' `
  -Path '.\policy' `
  -Platform 'Windows' `
  -Version 1.0.0 `
  -Mode 'ApplyAndAutoCorrect' `
  -Verbose

# Publish policy
$Subscription = Get-AzSubscription -SubscriptionName 'Q901-platform-dev'
New-AzPolicyDefinition `
    -Name 'VM-Guest-Policy-MSI' `
    -Policy 'policy\DeployIfNotExists.json' `
    -SubscriptionId $($Subscription.Id)


# Get-AzPolicyState -PolicyDefinitionName 'VM-Guest-Policy-MSI' 