$folderPath = "C:\Windows\LTSvc"   # change me
$installerPath = "C:\Install\MyApp\MyAppInstaller.msi" # or exe; change me
$baseurl = "https://pcsknox.hostedrmm.com/LabTech/Deployment.aspx?InstallerToken="
$url = $baseurl + $token
Param([string]$token="")

if (-not $token){
    Write-Host "Token is missing" Exit
}

if (-not (Test-Path -LiteralPath $folderPath)) {
Remove-Item -ErrorAction SilentlyContinue -Force -Recurse -Path "C:\Windows\Temp\Agent"; New-Item -ItemType Directory -Force -Path C:\Windows\Temp\Agent; Invoke-RestMethod $url -OutFile "C:\Windows\Temp\Agent\Install.zip"; Expand-Archive -Path "C:\Windows\Temp\Agent\Install.zip" -DestinationPath "C:\Windows\Temp\Agent\Install" -Force; MsiExec.exe /i "C:\Windows\Temp\Agent\Install\Agent_Install.msi" TRANSFORMS="C:\Windows\Temp\Agent\Install\Agent_Install.mst" /qn

    # Optionally: verify
    if (Test-Path -LiteralPath $folderPath) {
        Exit 0
    } else {
        Exit 1
    }
} else {
    # Folder exists -> do nothing
    Exit 0
}
