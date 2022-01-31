<#
    .SYNOPSIS
        Creates a file at the given file path with the specified content through the Script resource.

    .PARAMETER FilePath
        The path at which to create the file.

    .PARAMETER FileContent
        The content to set for the new file.
#>
Configuration ScriptExample {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $FilePath,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $FileContent1
    )

    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost
    {
        Script ScriptExample
        {
            SetScript = {
                $streamWriter = New-Object -TypeName 'System.IO.StreamWriter' -ArgumentList @( $using:FilePath )
                $streamWriter.WriteLine($using:FileContent1)
                $streamWriter.Close()
            }
            TestScript = {
                if (Test-Path -Path $using:FilePath)
                {
                    $fileContent = Get-Content -Path $using:filePath -Raw
                    # return $false
                    return $fileContent -eq $using:FileContent1
                }
                else
                {
                    return $false
                }
            }
            GetScript = {
                $FileContent = $null

                if (Test-Path -Path $using:FilePath)
                {
                    # $fileContent = Get-Content -Path $using:filePath -Raw
                    return @{result = "bingo"}
                }
                else {
                    return @{result = "noooonooonoo"}
                }

                # return @{
                  #  Result = Get-Content -Path $fileContent
                #}
            }
        }
    }
}
ScriptExample -Filepath 'C:\file.ps1' -FileContent1 "Write-Output Hello"

New-GuestConfigurationPackage `
    -Name 'ScriptExample' `
    -Configuration 'C:\Users\ove.aursland\git\msi\ScriptExample\localhost.mof' `
    -Type AuditAndSet `
    -Force

Start-GuestConfigurationPackageRemediation `
    -Path 'C:\Users\ove.aursland\git\msi\ScriptExample\ScriptExample.zip' -force