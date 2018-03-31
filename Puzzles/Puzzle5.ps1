Greetings Iron Scripters. You’re nearing the half way point on your journey to Iron Scripter
This challenge involves working with performance counters.
You are required to create a reusable PowerShell artefact that will enable you to retrieve the following performance counters from the local machine or a remote machine:
• Processor: Percentage processor time (use the total if there are multiple processors in the system)
• Disk: Percentage Free space of the C: drive
• Memory: Percentage Committed Bytes in Use
• Network Adapter: Bytes Total per second (only select physical adapters which does include wireless)

For the network adapter data don’t include more than two adapters - use the busiest two.
The data should be presented in an object that also includes the date and time the information was retrieved and the machine name to which the counters apply.
There should also be an option to present the data in a HTML page.
An option should be available to store the data in a form suitable for future analysis.

Use best practice if it doesn’t conflict with your faction’s aims.
The solution must be acceptable to your faction:
• Daybreak Faction - beautiful code
• Flawless Faction - flawless code
• Battle Faction - good enough to get the job done

As in previous challenges the standard is PowerShell v5.1. Will the code work on PowerShell v6?
If not is there an option that’ll work in PowerShell v5.1 and v6.
Good luck and good coding.
