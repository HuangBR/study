; Listing generated by Microsoft (R) Optimizing Compiler Version 18.00.40629.0 

	TITLE	D:\study\system\c\src\var_loc.c
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

_DATA	SEGMENT
$SG3057	DB	'1234567890', 00H
	ORG $+1
$SG3059	DB	'1234567890', 00H
_DATA	ENDS
PUBLIC	_print
PUBLIC	_main
EXTRN	@__security_check_cookie@4:PROC
EXTRN	___security_cookie:DWORD
; Function compile flags: /Odtp
_TEXT	SEGMENT
_p$ = -24						; size = 4
_a$ = -17						; size = 1
_c$ = -16						; size = 11
__$ArrayPad$ = -4					; size = 4
_main	PROC
; File d:\study\system\c\src\var_loc.c
; Line 13
	push	ebp
	mov	ebp, esp
	sub	esp, 24					; 00000018H
	mov	eax, DWORD PTR ___security_cookie
	xor	eax, ebp
	mov	DWORD PTR __$ArrayPad$[ebp], eax
; Line 14
	mov	BYTE PTR _a$[ebp], 1
; Line 15
	mov	eax, DWORD PTR $SG3057
	mov	DWORD PTR _c$[ebp], eax
	mov	ecx, DWORD PTR $SG3057+4
	mov	DWORD PTR _c$[ebp+4], ecx
	mov	dx, WORD PTR $SG3057+8
	mov	WORD PTR _c$[ebp+8], dx
	mov	al, BYTE PTR $SG3057+10
	mov	BYTE PTR _c$[ebp+10], al
; Line 16
	mov	DWORD PTR _p$[ebp], OFFSET $SG3059
; Line 17
	mov	ecx, 1
	shl	ecx, 0
	mov	dl, BYTE PTR _c$[ebp+ecx]
	mov	BYTE PTR _a$[ebp], dl
; Line 18
	mov	eax, 1
	shl	eax, 0
	mov	ecx, DWORD PTR _p$[ebp]
	mov	dl, BYTE PTR [ecx+eax]
	mov	BYTE PTR _a$[ebp], dl
; Line 19
	push	2
	push	1
	call	_print
	add	esp, 8
; Line 20
	xor	eax, eax
; Line 21
	mov	ecx, DWORD PTR __$ArrayPad$[ebp]
	xor	ecx, ebp
	call	@__security_check_cookie@4
	mov	esp, ebp
	pop	ebp
	ret	0
_main	ENDP
_TEXT	ENDS
; Function compile flags: /Odtp
_TEXT	SEGMENT
_f$ = -16						; size = 4
_e$ = -12						; size = 4
_c$ = -8						; size = 4
_d$ = -4						; size = 4
_a$ = 8							; size = 4
_b$ = 12						; size = 4
_print	PROC
; File d:\study\system\c\src\var_loc.c
; Line 4
	push	ebp
	mov	ebp, esp
	sub	esp, 16					; 00000010H
; Line 5
	mov	DWORD PTR _c$[ebp], 1
; Line 6
	mov	DWORD PTR _d$[ebp], 2
; Line 7
	mov	eax, DWORD PTR _c$[ebp]
	add	eax, DWORD PTR _d$[ebp]
	mov	DWORD PTR _e$[ebp], eax
; Line 8
	mov	ecx, DWORD PTR _e$[ebp]
	add	ecx, 1
	mov	DWORD PTR _f$[ebp], ecx
; Line 9
	mov	eax, DWORD PTR _d$[ebp]
	add	eax, DWORD PTR _c$[ebp]
	add	eax, DWORD PTR _e$[ebp]
	add	eax, DWORD PTR _f$[ebp]
; Line 10
	mov	esp, ebp
	pop	ebp
	ret	0
_print	ENDP
_TEXT	ENDS
END
