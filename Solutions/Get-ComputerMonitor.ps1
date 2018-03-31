function Get-ComputerMonitor{
<#
.SYNOPSIS
    Gathers Information about your Computer's Monitors
.DESCRIPTION
    Gathers information about computer monitors using Get-CimInstance.
    For multiple computers a CimSession is created and used for all cmdlets.
    When the computers parameter is not used then it will execute without a cmisession

.EXAMPLE
    Get-ComputerMonitor

    Returns the information for the current computer
.EXAMPLE
    Get-ComputerMonitor -Computer MyHost1,MyHost2

    Returns the information about each individual host
.NOTES
    Puzzle 1 of IronScripter
    Author: Joshua Corrick
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
            Try{
                $sessions = New-CimSession -ComputerName $computer -ErrorAction Stop
            }
            Catch{
                Write-Output "Count not create a session for one or more computers in $computer"
            }
        }
        else{
            $sessions = 'localhost'
        }

    }

    process {
        foreach($session in $sessions){
            If($PSBoundParameters.ContainsKey('computer')){
                $node = Get-CimInstance -ClassName CIM_ComputerSystem -CimSession $session
                $monitors = Get-CimInstance -ClassName WmiMonitorID -namespace root\wmi -CimSession $session
            }
            else{
                $node = Get-CimInstance -ClassName CIM_ComputerSystem
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
        Get-CimSession -ComputerName $sessions.ComputerName | Remove-CimSession
    }
}