#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2

; Chemin du fichier contenant les dossiers
saveFile := A_UserName "\explorateur_fenetres.txt"
fullPath := "C:\Users\" saveFile

; Lire les chemins
if !FileExist(fullPath) {
    MsgBox, Fichier introuvable: %fullPath%
    ExitApp
}

FileRead, folderList, %fullPath%
folders := StrSplit(folderList, "`n")

if (folders.Length() < 1) {
    MsgBox, Aucun dossier à restaurer.
    ExitApp
}

; Ouvrir le premier dossier dans une fenêtre
firstFolder := folders[1]
Run, explorer.exe "%firstFolder%"
Sleep, 1000

; Passer aux dossiers suivants
Loop % folders.Length() {
    if (A_Index = 1)
        continue  ; déjà ouvert

    folder := folders[A_Index]
    if folder = ""  ; ignorer les lignes vides
        continue

    ; Simuler Ctrl+T pour nouvel onglet
    Send ^t
    Sleep 100

    ; Aller dans la barre d'adresse
    Send ^l
    Sleep 100

    ; Coller le chemin
    Send %folder%
    Sleep 100

    ; Entrer
    Send {Enter}
    Sleep 100
}

ExitApp
