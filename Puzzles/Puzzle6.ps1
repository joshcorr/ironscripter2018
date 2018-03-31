Greetings Iron Scripters. You’re past the half way point on your journey to Iron Scripter when you complete this puzzle.
This week’s challenge is very simple – on the surface – but has some interesting quirks.
You’re required to create a PowerShell function that will return the uptime of the local machine or a remote system.

The properties of the returned object should include:
• Computer name
• Last Boot Time – as type System.DateTime
• Uptime – as the number of days since the last reboot.

The uptime should include partial days rounded to 3 decimal places – for example an uptime of 10 days and 8 hours would be 10.333
Ideally, your code should work with Linux systems as well as Windows.
If you don’t have access to a Linux system just concentrate on the Windows solution.
Hint: Physical Windows 8 and later machines enter a deep sleep when shutdown rather than being shut down.
The standard methods of finding the uptime may not work on these operating systems. Where else could you look for start-up information?

The function should accept pipeline input of computer names.
You may want to include operating system in the pipeline object.
Use best practice if it doesn’t conflict with your faction’s aims.

The solution must be acceptable to your faction:
• Daybreak Faction - beautiful code
• Flawless Faction - flawless code
• Battle Faction - good enough to get the job done
Good luck and good coding.
