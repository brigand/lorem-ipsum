; Lorem ipsum app
; Made for use with Appifyer (http://appifyer.com/)
; Author: Frankie Bagnardi
; Author Site: http://aboutscript.com/
; Tested on AutoHotkey_L 1.1.05.00 Unicode 32-bit

#Include <cursor>
#include <sublorem>

BS_Flat := 0x8000

Gui, Font, Italic, Serif
Gui, Font,, Times New Roman Italic
Gui, Font, s24 cAAAAAA
Gui, Color, 222222
Gui, Add, Text,, Lorem ipsum generator

MaxLength := StrLen(SubLorem(1))
Gui, Add, Slider, ToolTip NoTicks Range5-%MaxLength% AltSubmit vSlidePos gUpdateSlide, 120

GuiControlGet, SlidePos, Pos
CopyX := SlidePosX
CopyW := SlidePosW // 2  - 10
PasteX := SlidePosX + SlidePosW - CopyW

Gui, Font, s18
Gui, Font,, Arial
Gui, Font,, Palatino Linotype
Gui, Add, Button, BackgroundTrans Section gCopy x%CopyX% w%CopyW%, Copy
Gui, Add, Button,  BackgroundTrans ys wp gPasteTo x%PasteX% w%CopyW%, Paste To

Gui, Font, Italic, Serif
Gui, Font,, Lucida Console Italic
Gui, Font, s12 cAAAAAA
Gui, Color, 222222
Gui, Add, Text, w%SlidePosW% r30 xm vPreview

Gui, +ToolWindow
Gui, Show
OnExit, ExitSub
return

UpdateSlide:
GuiControlGet, SlidePos
LINE_WIDTH := 42 ; Characters
LINE_HEIGHT := 19

Lines := SlidePos // LINE_WIDTH + 1
Height := Lines  * LINE_HEIGHT

GuiControl, Move, Preview, h%Height%
GuiControl,, Preview, % SubLorem(1, SlidePos)
Gui, Show, AutoSize
return

Copy:
Clipboard := SubLorem(1, SlidePos)
ExitApp

PasteTo:
Gui, Hide
SetSystemCursor("IDC_CROSS")
Hotkey, ~LButton, PasteLocation
Hotkey, $Esc, ExitSub
return

PasteLocation:
; Wait up to 1/4 of  a second for the control to gain focus
; We store data in the clipboard while we're waiting to not waste time.
StartTime := A_TickCount
BackUpClip := ClipboardAll
GuiControlGet, SlidePos
Clipboard := SubLorem(1, SlidePos)

; Now we wait up to 250 seconds, subtracting any time spent saving
; data to the clipboard
Sleep % 250 - (A_TickCount  - StartTime)

; Paste the clipboard
Send ^v

; Restore the previous clipboard state
Clipboard := BackUpClipboard
ExitApp
return

ExitSub:
RestoreCursors()
ExitApp

GuiClose:
ExitApp
