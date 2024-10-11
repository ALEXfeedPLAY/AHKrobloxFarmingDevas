#SingleInstance, Force
SetCapsLockState, Off
CoordMode, Pixel, Screen  ; Coordinates relative to the screen
CoordMode, Mouse, Screen
SetTitleMatchMode, 2
DetectHiddenWindows, On

; Activate Roblox window
IfWinExist, ahk_exe RobloxPlayerBeta.exe
{
    WinActivate
    WinWaitActive
}
else
{
    MsgBox, Roblox is not running. Please open the game and try again.
    ExitApp
}

GImagePath := A_ScriptDir . "\Image\g.bmp"

; Calculate the center of the screen
CenterX := A_ScreenWidth // 2
CenterY := A_ScreenHeight // 2

; Set the search radius (500 pixels from the center)
SearchRadius := 500
Left := CenterX - SearchRadius
Top := CenterY - SearchRadius
Right := CenterX + SearchRadius
Bottom := CenterY + SearchRadius

Paused := False  ; Flag to track if the script is paused

Loop
{
    ; Check if the script is paused
    if (Paused)
    {
        Sleep 1000  ; Avoid consuming too much CPU while paused
        Continue
    }

    ; Display tooltip for debugging
    ToolTip, Searching for G...

    ; ImageSearch with defined search area and tolerance
    ImageSearch, FoundX, FoundY, %Left%, %Top%, %Right%, %Bottom%, *10 *TransBlack %GImagePath%

    if (ErrorLevel = 0)  ; Image found
    {
        ToolTip, Image Found! Pressing G
        Send {G}
        Sleep 3000  ;
    }
    else  ; Image not found
    {
        ToolTip, Image not found! Pressing 2
        Send {2}
        Sleep 100  
    }

    Sleep 500 
}
Return

; Hotkey to toggle pause/resume with Ctrl + F7
^F7::
Paused := !Paused  ; Toggle between True and False
if (Paused)
    ToolTip, Script Paused
else
    ToolTip, Script Resumed
Return

; Hotkey to exit the script with Ctrl + F8
^F8::ExitApp
