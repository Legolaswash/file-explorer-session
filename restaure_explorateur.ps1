$saveFile = "$env:USERPROFILE\explorateur_fenetres.txt"

if (Test-Path $saveFile) {
    $folders = Get-Content -Path $saveFile
    foreach ($folder in $folders) {
        if (Test-Path $folder) {
            Start-Process explorer.exe $folder
        }
    }
} else {
    Write-Host "Aucun fichier de sauvegarde trouvé."
}
