# Powershell-ServerStats
> A minimalistic Powershell script for writing server statistics to file.


## Script
The script is currently writing the following properties to file:
- Free hard drive space
- Free memory
- CPU name
- CPU usage in percentage
- CPU temperature in Celsius
- IP Address for Wi-Fi
- Remaining battery percentage for one or more installed batteries
- Uptime
- OS Version and system path
- Monitor name and description
- Graphics card with current running resolution and refresh rate

See [Sample.txt](https://github.com/runbert/Powershell-ServerStats/blob/master/Sample.txt) for expected output.

## Other
Set execution policy to unrestricted using 'Set-ExecutionPolicy Unrestricted' to be able to run script from Powershell.\
Run using '.\ServerStats.ps1'

