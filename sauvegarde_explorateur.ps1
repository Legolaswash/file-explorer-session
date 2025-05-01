# Script de sauvegarde pour les fenetres de l'explorateur Windows
# Journalisation pour le debogage
$logFile = "$env:USERPROFILE\explorateur_log.txt"
Add-Content -Path $logFile -Value "$(Get-Date) - Script demarre"

# Chemin de sauvegarde
$saveFile = "$env:USERPROFILE\explorateur_fenetres.txt"
Add-Content -Path $logFile -Value "Fichier de sauvegarde: $saveFile"

# Verifier et creer le fichier/repertoire si necessaire
$parentDir = Split-Path -Parent $saveFile
if (-not (Test-Path $parentDir)) {
    New-Item -ItemType Directory -Path $parentDir -Force
    Add-Content -Path $logFile -Value "Repertoire cree: $parentDir"
}

# Pause pour laisser le temps aux fenetres d'etre completement fermees
Start-Sleep -Seconds 1
Add-Content -Path $logFile -Value "Pause de 1 seconde effectuee"

# Creation de l'objet Shell
try {
    $shell = New-Object -ComObject Shell.Application
    Add-Content -Path $logFile -Value "Objet Shell cree avec succes"
} catch {
    Add-Content -Path $logFile -Value "Erreur lors de la creation de l'objet Shell: $_"
    exit
}

# Recuperation des fenetres de l'Explorateur
try {
    $explorers = $shell.Windows() | Where-Object { $_.Name -eq "Explorateur de fichiers" -or $_.FullName -like "*explorer.exe" }
    Add-Content -Path $logFile -Value "Nombre de fenetres trouvees: $($explorers.Count)"
} catch {
    Add-Content -Path $logFile -Value "Erreur lors de la recuperation des fenetres: $_"
    exit
}

# ecriture des chemins dans le fichier
$paths = @()
foreach ($window in $explorers) {
    try {
        $folder = $window.Document.Folder.Self.Path
        # Filtrer les entrees avec les identifiants speciaux GUID/CLSID
        if ($folder -and -not ($folder -like "::{*}")) {
            $paths += $folder
            Add-Content -Path $logFile -Value "Chemin ajoute: $folder"
        } else {
            Add-Content -Path $logFile -Value "Chemin ignore (GUID special): $folder"
        }
    } catch {
        Add-Content -Path $logFile -Value "Erreur lors de la recuperation d'un chemin: $_"
    }
}

# Verifier qu'on a des chemins à sauvegarder
if ($paths.Count -gt 0) {
    # Creer un fichier vide si necessaire
    if (-not (Test-Path $saveFile)) {
        New-Item -ItemType File -Path $saveFile -Force | Out-Null
        Add-Content -Path $logFile -Value "Fichier cree: $saveFile"
    }
    
    # ecrire les chemins dans le fichier
    $paths | Set-Content -Encoding UTF8 -Path $saveFile
    Add-Content -Path $logFile -Value "Chemins sauvegardes dans $saveFile ($($paths.Count) chemins)"
} else {
    Add-Content -Path $logFile -Value "Aucun chemin valide trouve, fichier non sauvegarde"
}

# Liberer les ressources COM
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($shell) | Out-Null
Add-Content -Path $logFile -Value "$(Get-Date) - Script termine"
