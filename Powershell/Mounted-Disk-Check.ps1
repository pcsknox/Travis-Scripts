$targetName = 'CCCOMA_X64FRE_EN-US_DV9'
$found = Get-CimInstance -ClassName Win32_Volume | Where-Object { $_.DriveLetter -and ($_.Label -eq $targetName) -and ($_.DriveType -ne 5) } | Select-Object -First 1
if ($found) { $true } else { $false }