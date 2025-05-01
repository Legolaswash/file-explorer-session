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
        # Filtrer les entrées avec les identifiants spéciaux GUID/CLSID
        if ($folder -and -not ($folder -like "::{*}")) {
            $paths += $folder
            Write-Host "Chemin ajouté: $folder"
        } else {
            Write-Host "Chemin ignoré (GUID spécial): $folder"
        }
    } catch {
        Write-Host "Erreur lors de la récupération d'un chemin: $_"
    }
}

# Vérifier qu'on a des chemins à sauvegarder
if ($paths.Count -gt 0) {
    $paths | Set-Content -Encoding UTF8 -Path $saveFile
    Write-Host "Chemins sauvegardés dans $saveFile ($($paths.Count) chemins)"
} else {
    Write-Host "Aucun chemin valide trouvé, fichier non sauvegardé"
}
