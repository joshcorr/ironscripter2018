function Get-ComputerMonitor{
<#
.SYNOPSIS
    Gathers Information about your Computer's Monitors
.DESCRIPTION

.EXAMPLE
    Get-Monitor
.NOTES
    Puzzle 1 of IronScripter
#>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$true,
            Position=0,
            HelpMessage='Provide a string value of the computer you want to connect to')]
        [string[]]$computer
    )
    begin {
        If($PSBoundParameters.ContainsKey('computer')){
            $nodes = Get-CimInstance -ClassName CIM_ComputerSystem -ComputerName $computer
        }
        else{
            $nodes = Get-CimInstance -ClassName CIM_ComputerSystem
        }

    }

    process {
        foreach($node in $nodes){
            If($PSBoundParameters.ContainsKey('computer')){
                $monitors = Get-CimInstance -ClassName WmiMonitorID -namespace root\wmi -ComputerName $node
            }
            else{
                $monitors = Get-CimInstance -ClassName WmiMonitorID -namespace root\wmi
            }

            foreach($monitor in $monitors){
                [PSCustomObject]@{
                    "ComputerName" = $node.Name;
                    "ComputerType" = $node.Model;
                    "ComputerSerial" = $node.name;
                    "MonitorSerial" = ($monitor.SerialNumberID -ne 0 | ForEach-Object {[char]$_}) -join "";
                    "MonitorType" = if($null -ne $monitor.UserFriendlyName){($monitor.UserFriendlyName -ne 0 | ForEach-Object {[char]$_}) -join "";}
                }
            }

        }
    }

    end {
        #Get-CimSession -ComputerName $Session.ComputerName | Remove-CimSession
    }
}