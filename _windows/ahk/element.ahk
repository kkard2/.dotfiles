#Requires AutoHotkey v2
#SingleInstance Force

#HotIf WinActive("ahk_exe Element.exe")
!k::!Up
!j::!Down
^!k::^!Up
^!j::^!Down
+!k::+!Up
+!j::+!Down
#HotIf
