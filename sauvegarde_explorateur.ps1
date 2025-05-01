# Chemin de sauvegarde
$saveFile = "$env:USERPROFILE\explorateur_fenetres.txt"

# Création de l'objet Shell
$shell = New-Object -ComObject Shell.Application

# Récupération des fenêtres de l'Explorateur
$explorers = $shell.Windows() | Where-Object { $_.Name -eq "Explorateur de fichiers" -or $_.FullName -like "*explorer.exe" }

# Écriture des chemins dans le fichier
$paths = @()
foreach ($window in $explorers) {
    try {
        $folder = $window.Document.Folder.Self.Path
        if ($folder) {
            $paths += $folder
        }
    } catch {
        # ignore erreurs
    }
}

$paths | Set-Content -Encoding UTF8 -Path $saveFile
Write-Host "Chemins sauvegardés dans $saveFile"
