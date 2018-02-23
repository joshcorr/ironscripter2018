#The Iron Scripter will soon be upon you. Only those truly skilled in the art of the Scripter will bring victory to their faction. In his wisdom the Keeper of the Iron Way has decreed that training opportunities be made available to all who aspire to compete in Iron Scripter. This is the first of a series of trials that will be made available to you in the short time before the ultimate challenge of Iron Scripter 2018.
#The following code was discovered in the archives:
$Monitor = Get-WmiObject wmiMonitorID -namespace root\wmi $Computer = Get-WmiObject -Class Win32_ComputerSystem

$Monitor ¦ %{     $psObject = New-Object PSObject    $psObject | Add-Member NoteProperty ComputerName ""     $psObject | Add-Member NateProperty ComputerType ""     $psObject | Add-Member NoteProperty ComputerSerial ""       $psObject | Add-Member NoteProperty MonitorSerial ""     $psObject | Add-Member NoteProperty MonitorType ""

    $psObject.ComputerName = $env:computernome     $psObject.ComputerType = $Computer.model     $psObject.ComputerSerial =  $Computer.Name

    $psObject.MonitorSerial = ($_.SerialNumberID -ne 0 | %{[char]$_}) -join ""     $psObject.MonitorType = ($_.UserFriendlyName -ne 0 | %{[char]$_}) -join ""

    $ps0bject

}
#This code is from the Dark Ages before the factions existed and coding was subject to error. The code contains a number of errors and doesn’t conform to your faction’s view point.
#Your goal for this challenge is to make the code work and a to create a re-usable artefact from the code.
#Your solution must follow the aims of your faction:
    #• Daybreak Faction - beautiful code
    #• Flawless Faction - flawless code
    #• Battle Faction - good enough to get the job done
#Remember the following when creating your solution:
    #• Following your faction’s aims is the most important aspect of this challenge
    #• Use best practice if it doesn’t conflict with your faction’s aims
    #• The solution must work for single or multiple monitors on the local machine
    #• How would this work with remote machines?
    #• PowerShell v5.1 is the assumed standard for your code. If you can also make the solution work with PowerShell v6 that is a bonus

#Good luck and good coding.