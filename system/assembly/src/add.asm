; Listing generated by Microsoft (R) Optimizing Compiler Version 19.00.23506.0 

	TITLE	D:\study\system\assembly\add.c
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

_DATA	SEGMENT
$SG4516	DB	'int is %d', 0aH, 00H
	ORG $+1
$SG4530	DB	'k is %d', 0aH, 00H
_DATA	ENDS
PUBLIC	___local_stdio_printf_options
PUBLIC	__vfprintf_l
PUBLIC	_printf
PUBLIC	_print_int
PUBLIC	_add
PUBLIC	_main
EXTRN	___acrt_iob_func:PROC
EXTRN	___stdio_common_vfprintf:PROC
_DATA	SEGMENT
COMM	?_OptionsStorage@?1??__local_stdio_printf_options@@9@9:QWORD							; `__local_stdio_printf_options'::`2'::_OptionsStorage
_DATA	ENDS
; Function compile flags: /Odtp
_TEXT	SEGMENT
_k$ = -12						; size = 4
_i$ = -8						; size = 4
_j$ = -4						; size = 4
_main	PROC
; File d:\study\system\assembly\add.c
; Line 16
	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH
; Line 17
	mov	DWORD PTR _i$[ebp], 3
	mov	DWORD PTR _j$[ebp], 4
; Line 18
	mov	eax, DWORD PTR _j$[ebp]
	push	eax
	call	_print_int
	add	esp, 4
	push	eax
	mov	ecx, DWORD PTR _i$[ebp]
	push	ecx
	call	_print_int
	add	esp, 4
	push	eax
	call	_add
	add	esp, 8
	mov	DWORD PTR _k$[ebp], eax
; Line 19
	mov	edx, DWORD PTR _k$[ebp]
	push	edx
	push	OFFSET $SG4530
	call	_printf
	add	esp, 8
; Line 20
	xor	eax, eax
; Line 21
	mov	esp, ebp
	pop	ebp
	ret	0
_main	ENDP
_TEXT	ENDS
; Function compile flags: /Odtp
_TEXT	SEGMENT
_c$ = -4						; size = 4
_a$ = 8							; size = 4
_b$ = 12						; size = 4
_add	PROC
; File d:\study\system\assembly\add.c
; Line 10
	push	ebp
	mov	ebp, esp
	push	ecx
; Line 11
	mov	eax, DWORD PTR _a$[ebp]
	add	eax, DWORD PTR _b$[ebp]
	mov	DWORD PTR _c$[ebp], eax
; Line 12
	mov	eax, DWORD PTR _c$[ebp]
; Line 13
	mov	esp, ebp
	pop	ebp
	ret	0
_add	ENDP
_TEXT	ENDS
; Function compile flags: /Odtp
_TEXT	SEGMENT
_num$ = 8						; size = 4
_print_int PROC
; File d:\study\system\assembly\add.c
; Line 4
	push	ebp
	mov	ebp, esp
; Line 5
	mov	eax, DWORD PTR _num$[ebp]
	push	eax
	push	OFFSET $SG4516
	call	_printf
	add	esp, 8
; Line 6
	mov	eax, DWORD PTR _num$[ebp]
; Line 7
	pop	ebp
	ret	0
_print_int ENDP
_TEXT	ENDS
; Function compile flags: /Odtp
;	COMDAT _printf
_TEXT	SEGMENT
__Result$ = -8						; size = 4
__ArgList$ = -4						; size = 4
__Format$ = 8						; size = 4
_printf	PROC						; COMDAT
; File c:\program files (x86)\windows kits\10\include\10.0.10240.0\ucrt\stdio.h
; Line 950
	push	ebp
	mov	ebp, esp
	sub	esp, 8
; Line 953
	lea	eax, DWORD PTR __Format$[ebp+4]
	mov	DWORD PTR __ArgList$[ebp], eax
; Line 954
	mov	ecx, DWORD PTR __ArgList$[ebp]
	push	ecx
	push	0
	mov	edx, DWORD PTR __Format$[ebp]
	push	edx
	push	1
	call	___acrt_iob_func
	add	esp, 4
	push	eax
	call	__vfprintf_l
	add	esp, 16					; 00000010H
	mov	DWORD PTR __Result$[ebp], eax
; Line 955
	mov	DWORD PTR __ArgList$[ebp], 0
; Line 956
	mov	eax, DWORD PTR __Result$[ebp]
; Line 957
	mov	esp, ebp
	pop	ebp
	ret	0
_printf	ENDP
_TEXT	ENDS
; Function compile flags: /Odtp
;	COMDAT __vfprintf_l
_TEXT	SEGMENT
__Stream$ = 8						; size = 4
__Format$ = 12						; size = 4
__Locale$ = 16						; size = 4
__ArgList$ = 20						; size = 4
__vfprintf_l PROC					; COMDAT
; File c:\program files (x86)\windows kits\10\include\10.0.10240.0\ucrt\stdio.h
; Line 638
	push	ebp
	mov	ebp, esp
; Line 639
	mov	eax, DWORD PTR __ArgList$[ebp]
	push	eax
	mov	ecx, DWORD PTR __Locale$[ebp]
	push	ecx
	mov	edx, DWORD PTR __Format$[ebp]
	push	edx
	mov	eax, DWORD PTR __Stream$[ebp]
	push	eax
	call	___local_stdio_printf_options
	mov	ecx, DWORD PTR [eax+4]
	push	ecx
	mov	edx, DWORD PTR [eax]
	push	edx
	call	___stdio_common_vfprintf
	add	esp, 24					; 00000018H
; Line 640
	pop	ebp
	ret	0
__vfprintf_l ENDP
_TEXT	ENDS
; Function compile flags: /Odtp
;	COMDAT ___local_stdio_printf_options
_TEXT	SEGMENT
___local_stdio_printf_options PROC			; COMDAT
; File c:\program files (x86)\windows kits\10\include\10.0.10240.0\ucrt\corecrt_stdio_config.h
; Line 73
	push	ebp
	mov	ebp, esp
; Line 75
	mov	eax, OFFSET ?_OptionsStorage@?1??__local_stdio_printf_options@@9@9 ; `__local_stdio_printf_options'::`2'::_OptionsStorage
; Line 76
	pop	ebp
	ret	0
___local_stdio_printf_options ENDP
_TEXT	ENDS
END
