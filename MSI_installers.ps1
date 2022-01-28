Configuration InstallMSI {

    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost
    {
        MsiPackage Powershell7
        {
            ProductId = '{395BA042-240F-404D-8B49-BDC2E812DBE5}'
            Path = 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.1/PowerShell-7.2.1-win-x64.msi'
            Ensure = 'Present'
        }
        MsiPackage Chrome
        {
            ProductId = '{9ABC27FD-AA4B-3C50-B76B-38FCFFCCDB03}'
            Path = 'https://github.com/jeircul/msi/raw/master/googlechromestandaloneenterprise64.msi'
            Ensure = 'Present'
        }
    }
}
InstallMSI

#Start-DscConfiguration -Path C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\7ZIPMOF -Wait -Verbose -Force