StaticLineInit	PROTO	:DWORD
FreeStatic		PROTO	:DWORD
Drawz    		PROTO
DrawLine		PROTO	:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GraphShake		PROTO	:DWORD

.const
xLinePos		equ	21
yLinePos		equ	124
LineWidth		equ	234
LineHeight		equ 4
NoiseColor		equ	00FFFFFFh

.data?
wParam2 		dd ?
nHeight    		dd ?
nWidth			dd ?
BmpDC    		dd ?
dword_404044    dd ?
BoxDC			dd ?
dword_404030    dd ?
dword_404034    dd ?
dword_404038    dd ?
ho				dd ?
rc 				RECT <?>
hDC 			dd ?
hThread			dd ?
hBrush			dd ?


.code
StaticLineInit proc hWnd:DWORD
LOCAL ThreadId:DWORD

	mov edx, nWidth
	add edx, 0Ch
           	
	invoke CreateBitmap,nHeight,edx,1,20h,0
	mov BmpDC, eax           
	invoke CreateCompatibleDC,0
	mov BoxDC, eax
	invoke SelectObject,BoxDC,BmpDC
	invoke DeleteDC,dword_404034
	invoke CreatePatternBrush,dword_404030                
	mov dword_404038, eax
	invoke CreateSolidBrush,Black; background color                               
	mov ho, eax

	call Randomize     
	invoke GetDC,hWnd               
	mov hDC, eax             
	mov rc.left, 0
	mov rc.top, 0
	mov eax, nHeight
	mov rc.right, eax
	mov eax, nWidth
	mov rc.bottom, eax                            
	lea eax, [ThreadId]
	invoke CreateThread,0,0,offset Drawz,0,0,eax               
	mov hThread, eax
	
	xor eax,eax
	ret
StaticLineInit endp

FreeStatic proc hWnd:DWORD
	invoke TerminateThread,hThread,0
	invoke ReleaseDC,hWnd,hDC
	xor eax,eax
	ret
FreeStatic endp
Drawz    proc near 
LOCAL x:DWORD
LOCAL cc:DWORD
LOCAL var_45:DWORD
LOCAL rect:RECT
	


loc_40289C:    

                invoke FillRect,BoxDC,offset rc,ho
                invoke DrawLine,BoxDC,-5,0,376,0,6,NoiseColor,0,0 ; <-- top wall   
      
                push    8                  
                xor     eax, eax                
                invoke BitBlt,BoxDC,10h,nWidth,0D2h,0Ch,BoxDC,10h,0BAh,0CC0020h
                invoke GraphShake,2
             
loc_402CCB:                       
                cmp     edi, 0C6h
                ja      loc_402D70
                mov     esi, 10h ; <-- left fade X axis value

loc_402CDC:                         
                cmp     esi, 2Eh
                ja      short loc_402D1E
                invoke GetPixel,BoxDC,esi,edi
                cmp     eax, 0FFFFFFh
                jnz     short loc_402D1B
                mov     eax, esi
                sub     eax, 10h
                push    1               ; int
                push    eax             ; nNumber
                push    1Eh             ; nDenominator
                push    0               ; int
                push    0FFFFFFh        ; int
                call    sub_402E31
                invoke SetPixel,BoxDC,esi,edi,eax
                
                
                
loc_402D1B:                      
                inc     esi
                jmp     short loc_402CDC
loc_402D1E:                         
                mov     esi, 0C4h ; <-- right fade X axis value
loc_402D23:                          
                cmp     esi, 0E2h
                ja      short loc_402D6A
                invoke GetPixel,BoxDC,esi,edi
                cmp     eax, 0FFFFFFh
                jnz     short loc_402D67
                mov     eax, esi
                sub     eax, 0C4h ;<-- right fade size
                push    0               ; int
                push    eax             ; nNumber
                push    1Eh             ; nDenominator
                push    0               ; int
                push    0FFFFFFh        ; int
                call    sub_402E31
                invoke SetPixel,BoxDC,esi,edi,eax
loc_402D67:       
                inc     esi
                jmp     short loc_402D23
loc_402D6A:              
                inc     edi
                jmp     loc_402CCB
                
loc_402D70:     
           
                mov     ecx, 28h ; <-- text line up width
                mov     esi, 79h ; <-- text line up X axis
                mov     edi, 0B8h ; <-- text line up Y axis
                
loc_402D7F:                     
                push    ecx
                invoke GraphShake,14h
                add     esi, eax
                invoke GraphShake,14h
                sub     esi, eax
              ;  invoke SetPixel,BoxDC,esi,edi,0FFFFFFh ;0000FF00h  <-- text line up color 
                pop     ecx
                loop    loc_402D7F
                mov     ecx, 0Ah
                mov     esi, 79h
                mov     edi, 0C8h
                
loc_402DB7:           
                push    ecx
                invoke GraphShake,14h
                add     esi, eax
                invoke GraphShake,14h ;<-- text line down X axis
                sub     esi, eax
            ;    invoke SetPixel,BoxDC,esi,edi,0FFFFFFh ; 0000FFFFh <-- text line down color
                pop     ecx
                loop    loc_402DB7
                invoke BitBlt,hDC,xLinePos,yLinePos,LineWidth,LineHeight,BoxDC,0,0,0CC0020h
                invoke Sleep,10 ; <-- scroller speed
                dec     [x]
                mov     eax, [x]
                neg     eax
                cmp     eax, [var_45]
                jle     loc_402E27
                mov     [x], 0E2h ; <-- scroller start position (when it ends)

loc_402E27:                       
                jmp     loc_40289C
                ret
Drawz    endp
sub_402E31      proc arg_011:DWORD,arg_41:DWORD,nDenominatorr:DWORD,nNumbeer:DWORD,arg_10:DWORD 
LOCAL var_8:BYTE
LOCAL var_7:BYTE
LOCAL var_6:BYTE
LOCAL var_5:BYTE
LOCAL var_4z:BYTE
LOCAL var_3:BYTE
                cmp     [arg_10], 0
                jz      short loc_402EA8
                mov     eax, [arg_41]
                mov     edx, [arg_011]
                mov     [var_8], al
                mov     [var_5], dl
                sub     [var_5], al
                shr     eax, 8
                shr     edx, 8
                mov     [var_7], al
                mov     [var_4z], dl
                sub     [var_4z], al
                shr     eax, 8
                shr     edx, 8
                mov     [var_6], al
                mov     [var_3], dl
                sub     [var_3], al
                movzx   eax, [var_5]
                push    [nDenominatorr] ; nDenominator
                push    eax             ; nNumerator
                push    [nNumbeer]   ; nNumber
                call    MulDiv
                add     [var_8], al
                movzx   eax, [var_4z]
                push    [nDenominatorr] ; nDenominator
                push    eax             ; nNumerator
                push    [nNumbeer]   ; nNumber
                call    MulDiv
                add     [var_7], al
                movzx   eax, [var_3]
                push    [nDenominatorr] ; nDenominator
                push    eax             ; nNumerator
                push    [nNumbeer]   ; nNumber
                call    MulDiv
                add     [var_6], al
                jmp     short loc_402F11
loc_402EA8:                            
                mov     eax, [arg_011]
                mov     edx, [arg_41]
                mov     [var_8], al
                mov     [var_5], al
                sub     [var_5], dl
                shr     eax, 8
                shr     edx, 8
                mov     [var_7], al
                mov     [var_4z], al
                sub     [var_4z], dl
                shr     eax, 8
                shr     edx, 8
                mov     [var_6], al
                mov     [var_3], al
                sub     [var_3], dl
                movzx   eax, [var_5]
                push    [nDenominatorr] ; nDenominator
                push    eax             ; nNumerator
                push    [nNumbeer]   ; nNumber
                call    MulDiv
                sub     [var_8], al
                movzx   eax, [var_4z]
                push    [nDenominatorr] ; nDenominator
                push    eax             ; nNumerator
                push    [nNumbeer]   ; nNumber
                call    MulDiv
                sub     [var_7], al
                movzx   eax, [var_3]
                push    [nDenominatorr] ; nDenominator
                push    eax             ; nNumerator
                push    [nNumbeer]   ; nNumber
                call    MulDiv
                sub     [var_6], al

loc_402F11:                           
                mov     al, [var_6]
                shl     eax, 8 ; <-- right fade color 
                mov     al, [var_7]
                shl     eax, 8
                mov     al, [var_8]
                ret
sub_402E31      endp

DrawLine      proc hdca:DWORD,arg_48:DWORD,arg_888:DWORD,arg_E:DWORD,arg_169:DWORD,arg_141:DWORD,colorz:DWORD,arg_AMOGUS:DWORD,arg_222:DWORD
LOCAL var_2:BYTE
LOCAL var_1:BYTE
                push    ecx
                push    ebx
                push    esi
                push    edi
                mov     edi, [arg_141]
                mov     esi, [arg_888]
                mov     ebx, [arg_48]
                mov     [var_1], 0
                mov     [var_2], 0
                cmp     ebx, [arg_E]
                jge     short loc_402F45
                mov     [var_1], 1
loc_402F45:                         
                cmp     esi, [arg_169]
                jge     short loc_402F4E
                mov     [var_2], 1
loc_402F4E:                            
                cmp     ebx, [arg_E]
                jle     short loc_402F57
                mov     [var_1], 0FFh
loc_402F57:                           
                cmp     esi, [arg_169]
                jle     short loc_402F94
                mov     [var_2], 0FFh
                jmp     short loc_402F94
loc_402F62:                                                          
                mov     eax, [colorz]
                push    eax          
                push    edi
                call    GraphShake
                add     eax, esi
                add     eax, [arg_222]
                push    eax             
                push    edi
                call    GraphShake
                add     eax, ebx
                add     eax, [arg_AMOGUS]
                push    eax       
                mov     eax, [hdca]
                push    eax            
                call    SetPixel
                movsx   eax, [var_2]
                add     esi, eax
                movsx   eax, [var_1]
                add     ebx, eax
loc_402F94: 
                cmp     ebx, [arg_E]
                jnz     short loc_402F62
                cmp     esi, [arg_169]
                jnz     short loc_402F62
                pop     edi
                pop     esi
                pop     ebx
                pop     ecx
                ret
DrawLine      endp

Randomize      proc near
LOCAL SystemTime:SYSTEMTIME
                lea     edx, [SystemTime]
                push    edx          
                call    GetSystemTime
                movzx   eax, [SystemTime.wHour]
                imul    eax, 3Ch
                add     ax, [SystemTime.wMinute]
                imul    eax, 3Ch
                xor     edx, edx
                mov     dx, [SystemTime.wSecond]
                add     eax, edx
                imul    eax, 3E8h
                mov     dx, [SystemTime.wMilliseconds]
                add     eax, edx
                mov     dword_404044, eax
                ret
Randomize      endp

GraphShake      proc arg_w:DWORD
                mov     eax, [arg_w]
                imul    edx, dword_404044, 8088405h
                inc     edx
                mov     dword_404044, edx
                mul     edx
                mov     eax, edx
                ret
GraphShake      endp