#Requires AutoHotkey v2
#SingleInstance Force

GroupAdd("IDE", "ahk_exe rider64.exe")
GroupAdd("IDE", "ahk_exe code.exe")
GroupAdd("IDE", "ahk_exe code-insiders.exe")
GroupAdd("IDE", "ahk_exe webstorm64.exe")
GroupAdd("IDE", "ahk_exe devenv.exe")

GroupAdd("Browser", "ahk_exe msedge.exe")
GroupAdd("Browser", "ahk_exe firefox.exe")

CapsLockState := false
HarpoonLastWindowIndex := 0

HarpoonRun(winTitle) {
    SetTitleMatchMode 2
    DetectHiddenWindows false

    windows := WinGetList(winTitle)

    if windows.Length = 0 {
        return
    }

    if WinActive(winTitle) {
        global HarpoonLastWindowIndex := Mod((HarpoonLastWindowIndex + 1), windows.Length)
    } else {
        global HarpoonLastWindowIndex := 0
    }

    WinActivate windows[HarpoonLastWindowIndex + 1]
}

CapsLock::LCtrl
<^[::Esc

RAlt & `::HarpoonRun("ahk_exe WindowsTerminal.exe")
RAlt & 1::HarpoonRun("ahk_exe Discord.exe")
RAlt & 2::HarpoonRun("ahk_group IDE")
RAlt & 3::HarpoonRun("ahk_group Browser")
RAlt & 4::HarpoonRun("ahk_exe Element.exe")
RAlt & 5::HarpoonRun("ahk_exe code.exe")
RAlt & 0::HarpoonRun("ahk_exe WINWORD.EXE")
RAlt & 9::HarpoonRun("ahk_class CabinetWClass")

RAlt & k::Send "#{Up}"
RAlt & j::Send "#{Down}"
RAlt & \::{
    global CapsLockState := not CapsLockState
    SetCapsLockState CapsLockState
}

Tab & h::Left
Tab & j::Down
Tab & k::Up
Tab & l::Right
Tab::Tab

RCtrl & Backspace::Reload
