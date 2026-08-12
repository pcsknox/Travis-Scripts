$Date = Get-Date
$raw = (query user 2>$null) -join "`n"
$hasUserSession = ($raw -like '*Active*')
if (-not ($Date.Hour -eq 12)) {Write-Host "Wrong hour"; break}
#if ($hasUserSession) {Write-Host "User is logged in, skipping"; break}
if ($Date.Hour -eq 2) {Write-Host "Would have rebooted"; break}
else {Write-Host "How did we get here?"; exit}