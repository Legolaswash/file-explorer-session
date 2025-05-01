#SingleInstance Force  ; Une seule instance du script peut s'exécuter à la fois
#NoTrayIcon
#Persistent
explorerWasOpen := false

WinGet, initialExplorerCount, Count, ahk_class CabinetWClass

; Si l'explorateur est déjà ouvert au lancement, définir l'état
if (initialExplorerCount > 0) {
    explorerWasOpen := true
}

SetTimer, CheckExplorer, 1000  ; Vérifie toutes les 1 sec

CheckExplorer:
WinGet, explorerCount, Count, ahk_class CabinetWClass

if (explorerCount > 0 && !explorerWasOpen) {
    explorerWasOpen := true
    ; L'explorateur vient d’être ouvert
    ; Run, "C:\Users\User\OneDrive\Bureau\CodesProjects\Repos\file-explorer-session\restaure_explorateur.ahk"    
    Run, "%A_ScriptDir%\restaure_explorateur.ahk"    
}

if (explorerCount = 0 && explorerWasOpen) {
    explorerWasOpen := false
    ; L'explorateur vient d’être fermé
    ; Run, powershell.exe -ExecutionPolicy Bypass -File "C:\Users\User\OneDrive\Bureau\CodesProjects\Repos\file-explorer-session\sauvegarde_explorateur.ps1"
    Run, powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "%A_ScriptDir%\sauvegarde_explorateur.ps1"
}
return
