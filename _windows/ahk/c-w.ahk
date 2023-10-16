#Requires AutoHotkey v2
#SingleInstance Force

#HotIf WinActive("ahk_exe Discord.exe") || WinActive("ahk_exe firefox.exe") || WinActive("ahk_exe Element.exe")
^w::^Backspace
#HotIf
