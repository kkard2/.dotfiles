#Requires AutoHotkey v2
#SingleInstance Force

CapsLock::Esc

SetKeyDelay 1

global CurrentDesktop := 1

ShowCurrentWindows() {
    titles := []
    text := ""

    hwnds := WinGetList()
    for hwnd in hwnds {
        ; skip tool windows
        style := DllCall("GetWindowLongPtr", "Ptr", hwnd, "Int", -20, "Ptr")
        WS_EX_TOOLWINDOW := 0x80
        if style & WS_EX_TOOLWINDOW
            continue

        title := WinGetTitle("ahk_id " hwnd)
        if title = ""
            continue

        titles.Push(title)
        text .= title
        text .= "`n"
    }
    ToolTip text, 0, 0
    SetTimer ToolTip, -1000
}

SwitchDesktop(num) {
    global CurrentDesktop
    While CurrentDesktop > num {
        SendEvent "{Ctrl down}{LWin down}{Left}{LWin up}{Ctrl up}"
        CurrentDesktop--
    }
    While CurrentDesktop < num {
        SendEvent "{Ctrl down}{LWin down}{Right}{LWin up}{Ctrl up}"
        CurrentDesktop++
    }
    ShowCurrentWindows()
}

!1::SwitchDesktop(1)
!2::SwitchDesktop(2)
!3::SwitchDesktop(3)
!4::SwitchDesktop(4)
!5::SwitchDesktop(5)
!6::SwitchDesktop(6)
!7::SwitchDesktop(7)
!8::SwitchDesktop(8)
!9::SwitchDesktop(9)
!0::SwitchDesktop(10)

~^#Left::{
    global CurrentDesktop
    if (CurrentDesktop > 1)
        CurrentDesktop--
}

~^#Right::{
    global CurrentDesktop
    if (CurrentDesktop < 10)
        CurrentDesktop++
}

RCtrl & Backspace::Reload
