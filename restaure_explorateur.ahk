#NoEnv
#SingleInstance Force
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2

; Chemin du fichier contenant les dossiers - Chemin absolu pour éviter les problèmes
fullPath := "C:\Users\User\explorateur_fenetres.txt"

; Lire les chemins
if !FileExist(fullPath) {
    MsgBox, 16, Erreur, Fichier de session introuvable: %fullPath%
    ExitApp
}

; Lire et nettoyer le contenu du fichier
FileRead, folderList, %fullPath%
folderList := RegExReplace(folderList, "`r`n", "`n") ; Standardiser les fins de ligne
folderList := RegExReplace(folderList, "`n$", "") ; Supprimer la dernière ligne vide si présente
folders := StrSplit(folderList, "`n")

; Vérifier qu'il y a au moins un dossier valide
validFolders := 0
Loop % folders.Length() {
    folder := Trim(folders[A_Index])
    if (folder != "" && !InStr(folder, "::")) {
        validFolders += 1
    }
}

if (validFolders < 1) {
    MsgBox, 16, Erreur, Aucun dossier valide trouvé dans le fichier.
    ExitApp
}

; Trouver le premier dossier valide
firstFolder := ""
for i, folder in folders {
    folder := Trim(folder)
    if (folder != "" && !InStr(folder, "::")) {
        firstFolder := folder
        break
    }
}

; Ouvrir le premier dossier dans une fenêtre
if (firstFolder) {
    Run, explorer.exe "%firstFolder%"
    ; Attendre que l'explorateur soit ouvert
    WinWaitActive, ahk_class CabinetWClass,, 3
    if ErrorLevel {
        MsgBox, 16, Erreur, Impossible d'ouvrir le premier dossier.
        ExitApp
    }
    Sleep, 1000
    ; Passer aux dossiers suivants
    for i, folder in folders {
        folder := Trim(folder)
        ; Ignorer les entrées vides et le premier dossier (déjà ouvert)
        if (folder = "" || folder = firstFolder || InStr(folder, "::"))
            continue
        ; S'assurer que l'explorateur est actif
        WinActivate, ahk_class CabinetWClass
        Sleep, 200
        Send ^t ; Ctrl+T > nouvel onglet
        Sleep, 500
        Send ^l ; Aller dans la barre d'adresse
        Sleep, 300
        SendInput % folder ; Coller le chemin
        Sleep, 300
        Send {Enter} ; Enter
        Sleep, 200
    }
}
ExitApp