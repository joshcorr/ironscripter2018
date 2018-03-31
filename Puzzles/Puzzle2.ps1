Greetings Iron Scripters. You’ve overcome the first challenge on your path to Iron Scripter 2018. Victory will come to the faction that has mastered all aspects of the art of the scripter and your next challenge will move you closer to being a master.
One aspect of mastery of the art is embracing the concept of objects – the subject of this trial.
The oldest parts of the archives deal with the early days of PowerShell when other scripting languages were in use and the factions were new. The following fragment of code was discovered:
$objOperatingSystem = Get-WmiObject -Query "SELECT * FROM Win32_OperatingSystem"


 Write-Host "OS Name: "  $objOperatingSystem.Name
 Write-Host "Version: "  $objOperatingSystem.Version
 Write-Host "Service Pack: "  $objOperatingSystem.ServicePackMajorVersion "." $objOperatingSystem.ServicePackMinorVersion
 Write-Host "OS Manufacturer: "  $objOperatingSystem.Manufacturer
 Write-Host "Windows Directory: "  $objOperatingSystem.WindowsDirectory
 Write-Host "Locale: "  $objOperatingSystem.Locale
 Write-Host "Available Physical Memory: "  $objOperatingSystem.FreePhysicalMemory
 Write-Host "Total Virtual Memory: "  $objOperatingSystem.TotalVirtualMemorySize
 Write-Host "Available Virtual Memory: " $objOperatingSystem.FreeVirtualMemory

 $disks = Get-WmiObject -Query "SELECT * FROM Win32_LogicalDisk"
 foreach ($objDisk in $disks) {
     Write-Host  "Drive: " $objDisk.DeviceID
     Write-Host  "DriveType: " $objDisk.Description
     Write-Host  "Size:" $objDisk.Size
     Write-Host  "FreeSpace: " $objDisk.FreeSpace
     Write-Host  "Compressed:" $objDisk.Compressed
}


This code doesn’t fit with the view point of any existing faction – whether there ever was a faction that supported this style is unknown.
Your goal is to take this code. Modify it to output objects rather than text. The solution must be acceptable to your faction:
• Daybreak Faction - beautiful code
• Flawless Faction - flawless code
• Battle Faction - good enough to get the job done

Remember the following when creating your solution:
• Following your faction’s aims is the most important aspect of this challenge
• Use best practice if it doesn’t conflict with your faction’s aims
• Output a single type of named object – you can assign the name yourself
• Calculate the percentage used space on each disk and add it to the output object
• Create and use a format file or type file as appropriate to control the display of the object you’ll output
• Ensure the code works with remote machines?
• PowerShell v5.1 is the assumed standard for your code. If you can also make the solution work with PowerShell v6, on Windows, that is a bonus

Good luck and good coding.