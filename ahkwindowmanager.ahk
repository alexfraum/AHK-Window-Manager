#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Part One - Variables

;Dimensions, Window Locations
windowsbarheight := 40
Sysget, totalwidth, 78
Sysget, totalheight, 79

usefulheight := totalheight - windowsbarheight
halfheight := usefulheight //2
quarterwidth := totalwidth //4  ;here in Queens it's 960
eighthwidth := totalwidth //8

programsopened := 0
extrabuffer := 250




;Programs
SetTitleMatchMode, 2

prgm0array := ["Window Name", "Filepath", "Winmove x", "Winmove y", "Winmove H", "Winmove W", "extra"]

prgm2 := "https://servicedesk.hotelfunds.org:8080/"
prgm2title := "ManageEngine"
prgm2array := ["ManageEngine", "https://servicedesk.hotelfunds.org:8080/WOListView.do?viewID=2401&globalViewName=All_Requests", 953, 0, 975, 1047]



prgm1 := "C:\Program Files\RealVNC\VNC Viewer\vncviewer.exe"
prgm1title := "VNC Viewer"
prgm1array := ["VNC Viewer", "C:\Program Files\RealVNC\VNC Viewer\vncviewer.exe", 2873, halfheight, 464, halfheight]

prgm3 := "C:\Program Files (x86)\Mitel\Connect\Mitel.exe"
prgm3title := "Mitel Connect"
prgm3array := ["Mitel Connect", "C:\Program Files (x86)\Mitel\Connect\Mitel.exe", 0, 0, quarterwidth, 600]

prgm4 := "n:\blankdocument.docx"
prgm4title := "ahk_exe WINWORD.EXE"
prgm4array := ["ahk_exe WINWORD.EXE","n:\blankdocument.docx", 952, halfheight, 582, halfheight]

prgm5 := "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Outlook 2016.lnk"
prgm5title := "ahk_exe OUTLOOK.EXE"
prgm5array := ["ahk_exe OUTLOOK.EXE", "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE",1920, 0, quarterwidth, halfheight]

prgm6 := "C:\Users\afraum\AppData\Local\slack\slack.exe"
prgm6title := "ahk_exe slack.exe"
prgm6array := ["ahk_exe slack.exe", "C:\Users\afraum\AppData\Local\slack\slack.exe", 2880, 0, quarterwidth, halfheight]

prgm7 := "N:\daily windows\helpdesksrv.rdp"
prgm7title := "helpdesksrv - helpdesksrv - Remote Desktop Connection"
prgm7array := ["helpdesksrv - helpdesksrv - Remote Desktop Connection", "N:\daily windows\helpdesksrv.rdp", 1913, halfheight, 974, halfheight]

prgm8 := "n:\tip of the day.xlsx"
prgm8title := "tip of the day"
prgm8array :=["tip of the day", "n:\tip of the day.xlsx", 0, halfheight, quarterwidth, halfheight]

prgm9 := "C:\Windows\system32\cmd.exe"
prgm9title := "C:\Windows\system32\cmd.exe"
prgm9array := ["C:\Windows\system32\cmd.exe", "C:\Windows\system32\cmd.exe", 1519, 519, 409, halfheight]

prgm11 := "N:\Calendar.xlsx"
prgm11title := "Calendar"
prgm11array := ["Calendar", "N:\Calendar.xlsx", 3330, halfheight, 513, halfheight]





; Functions
ifwinnotexist(a,b)
{
IfWinNotExist, %a%
{
Run, %b%
programsopened := programsopened + 1
}
}

getwindowmath(z)
{
WinGet, var, MinMax, %z%
If var != 0
{
WinRestore, %z%
}
WinGetPos X, Y, W, H, %z%
sum_of_dimensions := X + Y
sum_of_area := W + H
;msgbox, %z% `nSum of dimensions: %sum_of_dimensions% `nSum of area %sum_of_area%
}

;Part Two - Hotkeys 
f1:: ;Opening Programs



;Look up the first element in the array. it's a window title. if the window title does not exist, run the exe that runs it. 




ifwinnotexist(prgm2array[1],prgm2array[2])
ifwinnotexist(prgm5array[1],prgm5array[2])
ifwinnotexist(prgm1array[1],prgm1array[2])
ifwinnotexist(prgm3array[1],prgm3array[2])
ifwinnotexist(prgm4array[1],prgm4array[2])
ifwinnotexist(prgm6array[1],prgm6array[2])
ifwinnotexist(prgm7array[1],prgm7array[2])
ifwinnotexist(prgm8array[1],prgm8array[2])
ifwinnotexist(prgm9array[1],prgm9array[2])
ifwinnotexist(prgm11array[1],prgm11array[2])


;Sleep Time
sleeptime := (programsopened * 500) + extrabuffer

;Moving The Programs
;Get the status of the named window. If it's either minimized or maximized, return it to a non minimized or maximized state. 
;Then get its current x y h w. Then add its x and y values and call that sum_of_dimensions, then add its w and h value and call it sum_of_area
;Those past two lines, we summarize all of that as a function called getwindowmath()
;If sum_of_dimensions or sum_of_area are not the ideal numbers, then move the named window to specific coordinates.

;Chrome
getwindowmath(prgm2array[1])
;x: 953	y: 0	w: 974	h: 527
If (sum_of_dimensions != 953 Or sum_of_area != 1501)
{
;msgbox, %prgm2title% `nSum of dimesnions: %sum_of_dimensions% `nSum of area %sum_of_area%
Winmove, %prgm2title%,, 953, 0, 974, %halfheight%
}



;Mitel Connect
getwindowmath(prgm3array[1])
;msgbox, %prgm3title% `nSum of dimesnions: %sum_of_dimensions% `nSum of area %sum_of_area%

If (sum_of_dimensions != 0 Or sum_of_area != 1560)
{

Winmove, %prgm3title%,, 0, 0, %quarterwidth%, 600
}

;CYA Excel
getwindowmath(prgm8array[1])
If (sum_of_dimensions != %halfheight% Or sum_of_area != 1480)
{
;msgbox, %prgm8title% `nSum of dimesnions: %sum_of_dimensions% `nSum of area %sum_of_area%
Winmove, %prgm8title%,, 0, %halfheight%, %quarterwidth%, %halfheight%
}

;Excel calendar
getwindowmath(prgm11array[1])
If (sum_of_dimensions != 3850 Or sum_of_area != 1033)
{
;msgbox, %prgm8title% `nSum of dimesnions: %sum_of_dimensions% `nSum of area %sum_of_area%
Winmove, %prgm11title%,, 3330, %halfheight%, 513, %halfheight%
}

;blankdocument.docx
getwindowmath(prgm4array[1])
If (sum_of_dimensions != 1471 Or sum_of_area != 1110)
{
;msgbox, %prgm4title% `nSum of dimesnions: %sum_of_dimensions% `nSum of area %sum_of_area%
Winmove, %prgm4title%,, 952, %halfheight%, 582, %halfheight%
}



;Slack
getwindowmath(prgm6array[1])
;x: 2880	y: 0	w: 960	h: 520
If (sum_of_dimensions != 2880 Or sum_of_area != 1480)
{
;msgbox, %prgm6title% `nSum of dimesnions: %sum_of_dimensions% `nSum of area %sum_of_area%
Winmove, %prgm6title%,, 2880, 0, %quarterwidth%, %halfheight%
}

;techsrv
getwindowmath(prgm7array[1])
;x: 1913	y: 520	w: 974	h: 527
If (sum_of_dimensions != 2433 Or sum_of_area != 1501)
{
;msgbox, %prgm7title% `nSum of dimesnions: %sum_of_dimensions% `nSum of area %sum_of_area%
Winmove, %prgm7title%,, 1913, %halfheight%, 974, %halfheight%
}



;vnc viewer
getwindowmath(prgm1array[1])
If (sum_of_dimensions != 3393 Or sum_of_area != 991)
{
;msgbox, %prgm1title% `nSum of dimesnions: %sum_of_dimensions% `nSum of area %sum_of_area%
Winmove, %prgm1title%,, 2873, %halfheight%, 464, %halfheight%
}

;cmd
getwindowmath(prgm9array[1])
If (sum_of_dimensions != 2038 Or sum_of_area != 937)
{
;msgbox, %prgm9title% `nSum of dimesnions: %sum_of_dimensions% `nSum of area %sum_of_area%    
Winmove, %prgm9title%,, 1519, 519, 409, %halfheight%
}

;outlook
;WinWait, %prgm5title%
;Sleep, 2000
getwindowmath(prgm5array[1])
;x: 1920	y: 0	w: 960	h: 520
If (sum_of_dimensions != 1920 Or sum_of_area != 1480)
{
;msgbox, %prgm5title% `nSum of dimesnions: %sum_of_dimensions% `nSum of area %sum_of_area%
Winmove, %prgm5title%,, 1920, 0, %quarterwidth%, %halfheight%
}

return
