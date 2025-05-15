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
ShiftLockState := false
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

#HotIf GetKeyState("CapsLock", "P")
\::{
    global CapsLockState := not CapsLockState
    SetCapsLockState CapsLockState
}
Enter::{
    global ShiftLockState := not ShiftLockState
    if ShiftLockState {
        SendInput "{LShift Down}"
    } else {
        SendInput "{LShift Up}"
    }
}
+Enter::{
    global ShiftLockState := not ShiftLockState
    if ShiftLockState {
        SendInput "{LShift Down}"
    } else {
        SendInput "{LShift Up}"
    }
}

; vim motion
h::Left
j::Down
k::Up
l::Right

y::^Left
u::^Down
i::^Up
o::^Right

n::Home
m::PgDn
,::PgUp
.::End

; vim motion w select
+h::+Left
+j::+Down
+k::+Up
+l::+Right

+y::^+Left
+u::^+Down
+i::^+Up
+o::^+Right

+n::+Home
+m::+PgDn
+,::+PgUp
+.::+End

; harpoon
`::HarpoonRun("ahk_exe WindowsTerminal.exe")
1::HarpoonRun("ahk_exe Discord.exe")
2::HarpoonRun("ahk_group IDE")
3::HarpoonRun("ahk_group Browser")
4::HarpoonRun("ahk_exe Element.exe")
5::HarpoonRun("ahk_exe code.exe")
0::HarpoonRun("ahk_exe WINWORD.EXE")
e::HarpoonRun("ahk_class CabinetWClass")

Esc::Run "taskmgr"

; window manipulation
!h::#Left
!j::#Down
!k::#Up
!l::#Right

!y::#+Left
!u::#+Down
!i::#+Up
!o::#+Right

; desktop switching
!,::^#Left
!m::^#Right

q::Esc
#HotIf

CapsLock::{
    KeyWait "CapsLock"
    if A_ThisHotkey = "CapsLock" {
        Send "{Escape}"
    }
}

!CapsLock::{
    return
}
^CapsLock::{
    return
}
^!CapsLock::{
    return
}
+CapsLock::{
    return
}

Esc::F13
