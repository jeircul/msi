Configuration InstallMSI {

    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost
    {
        MsiPackage Powershell7
        {
            ProductId = '{11E117C7-01D0-4C4E-9096-2E90843A173E}'
            Path = 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.1/PowerShell-7.2.1-win-x64.msi'
            Ensure = 'Present'
        }
    }
}
InstallMSI

#Start-DscConfiguration -Path C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\7ZIPMOF -Wait -Verbose -Force