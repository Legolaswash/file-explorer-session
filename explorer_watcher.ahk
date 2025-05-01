#SingleInstance Force
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

; Explorateur ouvert
if (explorerCount > 0 && !explorerWasOpen) {
    explorerWasOpen := true
    Run, "C:\Users\User\OneDrive\Bureau\CodesProjects\Repos\file-explorer-session\restaure_explorateur.ahk"    
}

; Explorateur fermé
if (explorerCount = 0 && explorerWasOpen) {
    explorerWasOpen := false
    Run, powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Users\User\OneDrive\Bureau\CodesProjects\Repos\file-explorer-session\sauvegarde_explorateur.ps1"
}
return
