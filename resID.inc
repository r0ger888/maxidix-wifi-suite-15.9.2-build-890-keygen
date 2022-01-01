include		windows.inc 
include		kernel32.inc 
include		user32.inc 
include     gdi32.inc  
include 	shell32.inc
include		winmm.inc
include		masm32.inc
include		msvcrt.inc
include		comctl32.inc
include		oleaut32.inc
include		ole32.inc
include		advapi32.inc
include		comdlg32.inc
include     /masm32/macros/macros.asm

includelib	kernel32.lib
includelib	user32.lib 
includelib 	gdi32.lib
includelib 	shell32.lib
includelib	winmm.lib
includelib 	masm32.lib
includelib	msvcrt.lib
includelib	comctl32.lib
includelib  oleaut32.lib
includelib  ole32.lib
includelib	advapi32.lib
includelib	comdlg32.lib

include btnt.inc

include MagicV2mEngine.inc
includelib MagicV2mEngine.lib

DlgProc			PROTO	:DWORD,:DWORD,:DWORD,:DWORD
StaticLineInit	PROTO	:DWORD
FreeStatic		PROTO	:DWORD
Drawz    		PROTO
DrawLine		PROTO	:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GraphShake		PROTO	:DWORD
FadeOut			PROTO	:DWORD
MakeDialogTransparent	PROTO	:DWORD,:DWORD

.const
IDD_MAIN	equ	1000
IDD_ABOUT	equ	2000
IDB_EXIT	equ	1001
IDB_COPY	equ	1002
IDB_ABOUT	equ	1003
IDC_NAME	equ	1004
IDC_SERIAL	equ	1005

.data
include garbage.inc
WindowTitle	db	"Maxidix Wifi Suite 15.9.2 Build 890 KeyGen",0
DefaultName	db	"r0ger ^ PRF",0
Msg1		db	"copied 2 clipboard.",0
Cpt1		db	"PERYFERiAH tEAM",0
r3kt			RECT	<>
TxtFont		LOGFONT <12,0,0,0,FW_BOLD,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'ms sans serif'>
DELAY_VALUE			equ		6
Transparency		dd		?
TRANSPARENT_VALUE	equ 254

.data?
hInstance	dd	?
xWnd		dd	?
hFont			dd	?
hName			dd	?
hSerial			dd	?
hIMG			dd  ?
WndRect		RECT	<>
XndRect		RECT	<>
NameRect	RECT	<>
SerialRect	RECT	<>