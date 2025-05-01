#Persistent
SetTimer, CheckExplorer, 1000  ; Vérifie toutes les 1 sec
explorerWasOpen := false

CheckExplorer:
WinGet, explorerCount, Count, ahk_class CabinetWClass

if (explorerCount > 0 && !explorerWasOpen) {
    explorerWasOpen := true
    ; L'explorateur vient d’être ouvert
    Run, "C:\Users\User\OneDrive\Bureau\CodesProjects\Repos\file-explorer-session\restaure_explorateur.exe"    
}

if (explorerCount = 0 && explorerWasOpen) {
    explorerWasOpen := false
    ; L'explorateur vient d’être fermé
    Run, powershell.exe -ExecutionPolicy Bypass -File "C:\Users\User\OneDrive\Bureau\CodesProjects\Repos\file-explorer-session\sauvegarde_explorateur.ps1"
}
return
