Configuration InstallMSI {

    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost
    {
        MsiPackage Chrome
        {
            ProductId = '{9ABC27FD-AA4B-3C50-B76B-38FCFFCCDB03}'
            Path = 'https://github.com/jeircul/msi/raw/master/googlechromestandaloneenterprise64.msi'
            Ensure = 'Absent'
        }
    }
}
InstallMSI

#Start-DscConfiguration -Path C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\7ZIPMOF -Wait -Verbose -Force