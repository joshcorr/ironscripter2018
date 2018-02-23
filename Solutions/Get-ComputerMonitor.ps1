$Monitor = Get-WmiObject wmiMonitorID -namespace root\wmi
$Computer = Get-WmiObject -Class Win32_ComputerSystem

<#foreach($m in $Monitor){
    [System.Management.Automation.PSCustomObject]{
        "ComputerName" = $m.ComputerName;
        "ComputerType" = $m.ComputerType;
        "ComputerSerial" = $m.ComputerSerial;
        "MonitorSerial" = $m.MonitorSerial;
        "MonitorType" = $m.MonitorType
    }

}#>
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