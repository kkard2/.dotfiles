#Requires AutoHotkey v2
#SingleInstance Force

#HotIf GetKeyState("CapsLock", "P")
^j::!Down
^k::!Up
^u::^!Down
^i::^!Up
^m::+!Down
^,::+!Up
#HotIf
