function Get-ComputerCapacity {
<#
.SYNOPSIS
    Gathers Information about your Computer's OS, Memory and Storage
.DESCRIPTION
    Gathers information about computer monitors using Get-CimInstance.
    For multiple computers a CimSession is created and used for all cmdlets.
    When the computers parameter is not used then it will execute without a cmisession

.EXAMPLE
    Get-ComputerCapacity

    Returns the information for the current computer
.EXAMPLE
    Get-ComputerMonitor -Computer MyHost1,MyHost2

    Returns the information about each individual host
.NOTES
    Puzzle 2 of IronScripter
    Author: Joshua Corrick
#>
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$true,
            Position=0,
            HelpMessage='Provide a string value of the computer you want to connect to')]
        [string[]]$computer
    )
    begin {
        If($PSBoundParameters.ContainsKey('computer')){
            Try{
                $sessions = New-CimSession -ComputerName $computer -ErrorAction Stop
            }
            Catch{
                Write-Output "Could not create a session for one or more computers in $computer"
            }
        }
        else{
            $sessions = 'localhost'
        }

    }
    process {
        foreach ($session in $sessions){
            if($PSBoundParameters.ContainsKey('computer')){
                $objOperatingSystem = Get-CimInstance -Query "SELECT * FROM Win32_OperatingSystem" -CimSession $sessions
                $disks = Get-CimInstance -Query "SELECT * FROM Win32_LogicalDisk" -CimSession $sessions
            }
            else{
                $objOperatingSystem = Get-CimInstance -Query "SELECT * FROM Win32_OperatingSystem"
                $disks = Get-CimInstance -Query "SELECT * FROM Win32_LogicalDisk"
            }
            $properties = (@{ "ComputerName" = $objOperatingSystem.CSName;
            "OSName"  = $objOperatingSystem.Name;
            "Version" =  $objOperatingSystem.Version;
            "ServicePack" =  "$($objOperatingSystem.ServicePackMajorVersion).$($objOperatingSystem.ServicePackMinorVersion)";
            "OSManufacturer" = $objOperatingSystem.Manufacturer;
            "WindowsDirectory" = $objOperatingSystem.WindowsDirectory;
            "Locale" = $objOperatingSystem.Locale;
            "AvailablePhysicalMemory" = "$($objOperatingSystem.FreePhysicalMemory)";
            "TotalVirtualMemory" = "$($objOperatingSystem.TotalVirtualMemorySize)";
            "AvailableVirtualMemory" = "$($objOperatingSystem.FreeVirtualMemory)";
            "Drive" = foreach($objdisk in $disks){$objDisk.DeviceID};
            "DriveType" = foreach($objdisk in $disks){$objDisk.Description};
            "Size" = foreach($objdisk in $disks){"$($objDisk.Size)"};
            "FreeSpace" = foreach($objdisk in $disks){"$($objDisk.FreeSpace)"};
            "PercentageUsed" = foreach($objdisk in $disks){[math]::Round((($objdisk.Size - $objdisk.FreeSpace) / $objdisk.Size ) * 100)}
            "Compressed" = foreach($objdisk in $disks){$objDisk.Compressed}
            })

            $ComputerCapacity = New-Object -TypeName psobject -Property $properties
        }
    }

    end {

        $ComputerCapacity.psobject.TypeNames.Insert(0,'IronScripter.ComputerStats')

        $defaultDisplaySet = 'ComputerName','OSName','Version','AvailablePhysicalMemory','TotalVirtualMemory','Drive','Size','FreeSpace','PercentageUsed'
        $defaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet',[string[]]$defaultDisplaySet)
        $PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($defaultDisplayPropertySet)
        $ComputerCapacity | Add-Member MemberSet PSStandardMembers $PSStandardMembers


        $ComputerCapacity
    }
}