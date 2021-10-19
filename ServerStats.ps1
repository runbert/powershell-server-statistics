#Create new file
$FilePath = "Sample.txt"
Out-File -FilePath $FilePath

#HDD
$RemainingStorage = [Math]::Round((Get-Volume -DriveLetter 'C').SizeRemaining/1GB)
$TotalStorage = [Math]::Round((Get-Volume -DriveLetter 'C').Size/1GB)
Add-Content $FilePath "Free HDD: $($RemainingStorage)GB / $($TotalStorage)GB"

#Mem
$TotalMem = (Get-WmiObject -Class win32_physicalmemory -Property Capacity | Measure-Object -Property Capacity -Sum | Select-Object -ExpandProperty Sum) / 1MB
$FreeMem = [Math]::Round((Get-CIMInstance Win32_OperatingSystem | Select FreePhysicalMemory | Measure-Object -Property FreePhysicalMemory -Sum | Select-Object -ExpandProperty Sum) / 1Kb)
Add-Content $FilePath "Free MEM: $($FreeMem)MB / $($TotalMem)MB"

#CPU Name
$CPUName = (Get-WmiObject Win32_Processor).Name
Add-Content $FilePath "CPU Name: $($CPUName)"

#CPU Usage in percentage
$CPUUsage = (Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
Add-Content $FilePath "    Usage: $($CPUUsage)%"

#CPU Temperature
$CPUTempKelvin = (Get-WMIObject -Query "SELECT * FROM Win32_PerfFormattedData_Counters_ThermalZoneInformation" -Namespace "root/CIMV2").Temperature
$CPUTempCelsius = $CPUTempKelvin - 273.15
Add-Content $FilePath "    Temp: $($CPUTempCelsius) C"

#IPAddress Wi-Fi
$IPAddress = (Get-NetIPAddress -AddressFamily IPV4 -InterfaceAlias Wi-Fi).IPAddress
Add-Content $FilePath "IP Address: $($IPAddress) (Wi-Fi)"

#Battery Percentage
#Since laptops can have multiple batteries installed, we get remaining percentage for all of them.
$Batteries = (Get-WmiObject win32_battery);
$BatteriesPercentage;
Foreach ($battery in $Batteries)
{

 $BatCharge = $battery.EstimatedChargeRemaining
 $BatteriesPercentage += "$BatCharge %"

  if($battery -Ne ($Batteries | Select-Object -Last 1)) {
  	$BatteriesPercentage += ", ";
  }

}
Add-Content $FilePath "Remaining battery: $($BatteriesPercentage)"

#Uptime
$UptDays = ((Get-Date) - (gcim Win32_OperatingSystem).LastBootUpTime).Days
$UptHours = ((Get-Date) - (gcim Win32_OperatingSystem).LastBootUpTime).Hours
$UptMinutes = ((Get-Date) - (gcim Win32_OperatingSystem).LastBootUpTime).Minutes
Add-Content $FilePath "Uptime: $($UptDays) days, $($UptHours) hours and $($UptMinutes) minutes"

#Windows Version
$WinFolder = (Get-WmiObject -Class win32_OperatingSystem).SystemDirectory
$WinVersion = (Get-WmiObject -Class win32_OperatingSystem).Version
Add-Content $FilePath "OS Version: Windows $($WinVersion) @ $($WinFolder)"

#Screen
$ScreenManufacturer = (Get-WmiObject -Class Win32_DesktopMonitor).MonitorManufacturer
$ScreenName = (Get-WmiObject -Class Win32_DesktopMonitor).Name
Add-Content $FilePath "Screen: $($ScreenManufacturer) $($ScreenName)"

#Graphics
$GraphDesc = (Get-WmiObject -Class Win32_VideoController).Description
$GraphResHor =(Get-WmiObject -Class Win32_VideoController).CurrentHorizontalResolution;
$GraphResVer = (Get-WmiObject -Class Win32_VideoController).CurrentVerticalResolution;
$GraphRefRate = (Get-WmiObject -Class Win32_VideoController).CurrentRefreshRate;
Add-Content $FilePath "Graphics: $($GraphDesc) @ $($GraphResHor)x$($GraphResVer), $($GraphRefRate) Hz"

#Date
$CurrentDate = Get-Date -DisplayHint Date
Add-Content $FilePath "Latest update: $($CurrentDate)"

Write-Host("Done! Server stats written to $($FilePath) @ $($CurrentDate)")