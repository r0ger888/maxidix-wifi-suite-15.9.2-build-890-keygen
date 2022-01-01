
include sha1.asm
include base64.asm

Hex2ch		PROTO	:DWORD,:DWORD,:DWORD
GenKey		PROTO	:DWORD

.data
Magicbytes	db	65h,72h,68h,24h,34h,53h,33h,38h,2Ah,64h,5Dh,66h,5Eh,67h,2Bh,2Eh
ShaNamehash	db	100h	dup(0)
Noname		db	"Insert ur name!",0
TooLong		db	"Name too long!",0

.data?
Namebuff	db	60h	dup(?)
Base64Enk	db	60h	dup(?)
Srlbuff		db	60h	dup(?)
ShaHash		db	60h	dup(?)
hLen		dd	?

.code
Hex2ch proc HexValue:DWORD,CharValue:DWORD,HexLength:DWORD
    mov esi,[ebp+8]
    mov edi,[ebp+0Ch]
    mov ecx,[ebp+10h]
    @HexToChar:
      lodsb
      mov ah, al
      and ah, 0Fh
      shr al, 4
      add al, '0'
      add ah, '0'
       .if al > '9'
          add al, 'a'-'9'-1
       .endif
       .if ah > '9'
          add ah, 'a'-'9'-1
       .endif
      stosw
    loopd @HexToChar
    ret
Hex2ch endp

GenKey proc	hWin:DWORD
	
	invoke GetDlgItemText,hWin,IDC_NAME,addr Namebuff,256
	.if eax == 0
		invoke SetDlgItemText,hWin,IDC_SERIAL,addr Noname
		invoke GetDlgItem,hWin,IDB_COPY
		invoke EnableWindow,eax,FALSE
	.elseif eax > 32
		invoke SetDlgItemText,hWin,IDC_SERIAL,addr TooLong
		invoke GetDlgItem,hWin,IDB_COPY
		invoke EnableWindow,eax,FALSE
	.elseif
		invoke lstrcat,addr ShaHash,addr Namebuff
		invoke lstrcat,addr ShaHash,addr Magicbytes
		invoke lstrlen,addr ShaHash
		mov hLen,eax
		invoke SHA1Init
		invoke SHA1Update,addr ShaHash,hLen
		invoke SHA1Final
		invoke Hex2ch,addr SHA1Digest,addr ShaNamehash,20
		push offset Base64Enk
		push 20
		push offset SHA1Digest
		call Base64Enc ; had to get Jowy's modified base64 routine to get the last char right :E
		invoke SetDlgItemText,hWin,IDC_SERIAL,addr Base64Enk
		invoke GetDlgItem,hWin,IDB_COPY
		invoke EnableWindow,eax,TRUE
		call Clean
		
	.endif
	ret
GenKey endp

Clean proc
	
	invoke RtlZeroMemory,addr Namebuff,sizeof Namebuff
	invoke RtlZeroMemory,addr ShaNamehash,sizeof ShaNamehash
	invoke RtlZeroMemory,addr ShaHash,sizeof ShaHash
	invoke RtlZeroMemory,addr Base64Enk,sizeof Base64Enk
	ret
Clean endp