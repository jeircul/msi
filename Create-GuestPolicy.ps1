# ./MSI_installer.ps1
New-GuestConfigurationPackage `
  -Name 'InstallMSI' `
  -Configuration 'InstallMSI\localhost.mof' `
  -Type AuditAndSet `
  -Force
  
  # Made zip available on github 