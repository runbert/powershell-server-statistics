for(;;) {
 try {
  #Clear powershell window
  Clear-Host

  #Print start time
  $CurrentDate = Get-Date -DisplayHint Date
  Write-Host("Trying to run ServerStats.ps1 script at $($CurrentDate)...")
  
  #Invoke the stats script
  .\ServerStats.ps1
 }
 catch {
  #Log error ($_)
  Write-Host($_)
 }

 #Wait for 30 minutes
 Start-Sleep 1800
}