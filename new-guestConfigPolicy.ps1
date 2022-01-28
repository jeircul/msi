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