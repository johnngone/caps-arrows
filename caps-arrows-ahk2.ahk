#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")   ; fast, low-overhead send mode

;─────────────────────────────────────────────────────────────
;  WIN + H   →  toggle “Show hidden files” in File Explorer
;─────────────────────────────────────────────────────────────
#h::{
    ; 2 = **hide** hidden items   1 = **show** hidden items
    key := "HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced"
    state := RegRead(key, "Hidden", 2)               ; default 2 if value missing
    newState := (state = 2) ? 1 : 2                  ; flip 2 ↔ 1
    RegWrite(newState, "REG_DWORD", key, "Hidden")

    ; refresh whatever Explorer window is active
    winClass := WinGetClass("A")
    if (winClass = "#32770" || A_OSVersion = "WIN_VISTA")   ; dialogs/Vista
        Send "{F5}"
    else
        PostMessage 0x111, 28931,,, "A"   ; WM_COMMAND + ID_REFRESH
}

;─────────────────────────────────────────────────────────────
;  Caps-layer navigation & mouse shortcuts
;─────────────────────────────────────────────────────────────
CapsLock & i:: Send GetKeyState("Alt","P") ? "+{Up}"    : "{Up}"
CapsLock & k:: Send GetKeyState("Alt","P") ? "+{Down}"  : "{Down}"
CapsLock & j:: Send GetKeyState("Alt","P") ? "+{Left}"  : "{Left}"
CapsLock & l:: Send GetKeyState("Alt","P") ? "+{Right}" : "{Right}"

CapsLock & h:: Send GetKeyState("Alt","P") ? "+{MButton}" : "{MButton}"
CapsLock & t:: Send "{WheelUp}"
CapsLock & g:: Send "{WheelDown}"

CapsLock & u:: Send GetKeyState("Alt","P") ? "+{XButton1}" : "{XButton1}"  ; back
CapsLock & o:: Send GetKeyState("Alt","P") ? "+{XButton2}" : "{XButton2}"  ; forward

CapsLock & Space:: Send "{Space}"

*CapsLock:: SetCapsLockState("AlwaysOff")   ; keep Caps key as a pure modifier
+CapsLock:: SetCapsLockState("On")          ; Shift + Caps → real CapsLock

;─────────────────────────────────────────────────────────────
;  Type three hyphens (---) → em-dash (—)
;─────────────────────────────────────────────────────────────
::---::—
