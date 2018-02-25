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
        [string[]]$computer
    )
    begin {
        $Session = New-CimSession -ComputerName $Computer
        $Monitors = Get-CimInstance -ClassName WmiMonitorID -namespace root\wmi
        $Computer = Get-CimInstance -ClassName CIM_ComputerSystem -CimSession $Session
    }

    process {
        foreach($sesh in $Session){
            $Computer = Get-CimInstance -ClassName CIM_ComputerSystem -CimSession $sesh
            $Monitors = Get-CimInstance -ClassName WmiMonitorID -namespace root\wmi -CimSession $sesh

        }
        foreach($monitor in $Monitors){
            [PSCustomObject]@{
                "ComputerName" = $monitor.ComputerName;
                "ComputerType" = $monitor.ComputerType;
                "ComputerSerial" = $monitor.ComputerSerial;
                "MonitorSerial" = $monitor.MonitorSerial;
                "MonitorType" = $monitor.MonitorType
            }

        }
    }

    end {
    }

$Monitor = Get-WmiObject wmiMonitorID -namespace root\wmi
$Computer = Get-WmiObject -Class Win32_ComputerSystem


$Monitor | % {
    $psObject = New-Object PSObject
    $psObject | Add-Member -MemberType NoteProperty  -Name ComputerName -Value $PSItem.ComputerName
    $psObject | Add-Member -MemberType NoteProperty -Name ComputerType -Value $PSItem.ComputerType
    $psObject | Add-Member -MemberType NoteProperty -Name ComputerSerial -Value $PSItem.ComputerSerial
    $psObject | Add-Member -MemberType NoteProperty -Name MonitorSerial -Value $PSItem.MonitorSerial
    $psObject | Add-Member -MemberType NoteProperty -Name MonitorType -Value $PSItem.MonitorType

    $psObject.ComputerName = $env:COMPUTERNAME
    $psObject.ComputerType = $Computer.model
    $psObject.ComputerSerial =  $Computer.Name

    $psObject.MonitorSerial = ($_.SerialNumberID -ne 0 | %{[char]$_}) -join ""
    $psObject.MonitorType = ($_.UserFriendlyName -ne 0 | %{[char]$_}) -join ""

    $ps0bject
    }
}