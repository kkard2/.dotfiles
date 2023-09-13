#Requires AutoHotkey v2
#SingleInstance Force

; https://stackoverflow.com/a/68547452
GetWindowMonitorIndex(hwnd) {
    ;Get number of monitor
    monCount := MonitorGetCount()

    windowX := 0
    windowY := 0
    windowWidth := 0
    windowHeight := 0

    ;Get the position of the focus window
    WinGetPos(&windowX, &windowY, &windowWidth, &windowHeight, hwnd)

    ;Make an array to hold the sub-areas of the window contained within each monitor
    monitorSubAreas := []

    ;Iterate through each monitor
    Loop monCount {
        ;Get Monitor working area

        monitorLeft := 0
        monitorTop := 0
        monitorRight := 0
        monitorBottom := 0

        MonitorGet(A_Index, &monitorLeft, &monitorTop, &monitorRight, &monitorBottom)

        ;Calculate sub-area of the window contained within each monitor
        xStart := max(windowX,  monitorLeft)
        xEnd :=  min(windowX + windowWidth,  monitorRight)
        yStart := max(windowY, monitorTop)
        yEnd :=  min(windowY + windowHeight,  monitorBottom)
        area := (xEnd - xStart) * (yEnd - yStart)

        ;Remember these areas, and which monitor they were associated with
        monitorSubAreas.push({area: area, index: A_Index})
    }

    ;Loop to figure out which monitor's recorded sub-area was largest
    winningMonitor := 0
    winningArea := 0
    for index, monitor in monitorSubAreas {
        winningMonitor := monitor.area > winningArea ? monitor.index : winningMonitor
        winningArea := monitor.area > winningArea ?  monitor.area : winningArea
    }
    return winningMonitor
}

monitorCount := MonitorGetCount()

;; contains hwnds of all windows in the workspace
workspaces
workspaces := [
    [], ; 1
    [], ; 2
    [], ; 3
    [], ; 4
    [], ; 5
    [], ; 6
    [], ; 7
    [], ; 8
    [], ; 9
    [], ; 10 (0)
]

monitorWorkspaces := []

if (monitorCount == 2) {
    monitorWorkspaces := [
        [1, 2, 3, 4, 5, 6], ; 1
        [7, 8, 9, 10] ; 2
    ]
} else {
    for i in range(1, monitorCount) {
        monitorWorkspaces.push([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    }
}

UpdateWorkspaceIds(workspace_id) {
    global workspaces
    global monitorWorkspaces
    global monitorCount

    ; get all windows
    ids := WinGetList(,, "Program Manager") ; tbh idk why program manager

    ; loop through all windows
    for windowId in windowList {

        ; get window's monitor
        windowMonitor := GetWindowMonitor(windowId)

        ; if window is on the workspace we're updating
        if (windowMonitor == workspace_id) {
            ; add it to the workspace
            workspaces[workspace_id].push(windowId)
        }
    }
}

ids := WinGetList(,, "Program Manager")
for this_id in ids {
    this_class := WinGetClass(this_id)
    this_title := WinGetTitle(this_id)
    result := MsgBox(
    (
        "Visiting All Windows
        " A_Index " of " ids.Length "
        ahk_id " this_id "
        ahk_class " this_class "
        " this_title "
        monitor " GetWindowMonitorIndex(this_id) "

        Continue?"
    ),, 4)
    if (result = "No")
        break
}
