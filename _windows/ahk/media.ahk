#Requires AutoHotkey v2
#SingleInstance Force

^#Space::Send "{Media_Play_Pause}"
^#x::Send "{Media_Next}"
^#z::Send "{Media_Prev}"
^#Up::Send "{Volume_Up}"
^#Down::Send "{Volume_Down}"
