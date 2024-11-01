$appsToRemove = @(
    "OneDriveSetup.exe",
    "OneDrive.exe",
    "Notion.exe",
    "Voicemod.exe",
    "Update.exe",  # Cela se réfère à Discord
    "FxSound.exe",
    "ied.exe",     # Cela se réfère à Sony Imaging Edge
    "SecurityHealthSystray.exe",
    "RtkAudUService64.exe"
)

foreach ($app in $appsToRemove) {
    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
    $appName = $app.Split('.')[0]  # Nom de l'application sans l'extension

    if (Get-ItemProperty -Path $regPath -Name $appName -ErrorAction SilentlyContinue) {
        Remove-ItemProperty -Path $regPath -Name $appName
        Write-Host "$($app) a été désactivé via le registre."
    } else {
        Write-Host "$($app) n'a pas été trouvé dans le registre."
    }
}
