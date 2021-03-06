# start
  [Guide to x86 assembly Language](http://www.cs.virginia.edu/~evans/cs216/guides/x86.html)
  http://asm.sourceforge.net/resources.html
  http://mikeos.sourceforge.net/
  http://www.ctyme.com/intr/cat.htm
  http://beefchunk.com/documentation/sys-programming/bootstraps/PC_Bootstrap_Loader_Programming_Tutorial.html

# linux
  ```
  nasm -f elf hello.asm
  as --32 test.s -o test.o
  ld -m efl_i386 -s hello.o -o hello
  
  c/c++ sources ----+          +<-----gcc---->-----------------------+     glibc
                    |        +                +                        +    library(so, a)
                    |      +                    +                        +   |
                complier +                      as ----->                  ld
                    |     +                    +         +                +  |
                    |       +                +             +            +    |
  headers from: ----+       assembler source                elf relocable     elf executable
  glibc, linux, gcc
  ```

# basics
  * push 
    1. decrements ESP by 4
    2. places its operand into the contents of the 32-bit location at address [ESP]

  * call, ret — Subroutine call and return 
    ```
    ; enter
    push ebp
    mov ebp, esp

    ; leave
    mov esp, ebp
    pop eb
    ```

  * Calling Convention

    a protocol about how to call and return from routines

    * The C calling convention: based on the push, pop, call, and ret instructions
        * Subroutine parameters are passed on the stack
        * registers saved on stack, local variables are placed in memory on the stack
    
    * two sets of rules
      * the caller of the subroutine
      * the callee 
    
    * The following calling conventions are supported by the Visual C/C++ compiler:
      Keyword     | Stack cleanup | Parameter passing
      -------     | ------------- | -----------------
      __cdecl     |  Caller       |  Pushes parameters on the stack, in reverse order (right to left)
      __clrcall   |  n/a          |  Load parameters onto CLR expression stack in order (left to right).
      __stdcall   |  Callee       |  Pushes parameters on the stack, in reverse order (right to left)
      __fastcall  |  Callee       |  Stored in registers, then pushed on stack
      __thiscall  |  Callee       |  Pushed on stack; this pointer stored in ECX
     __vectorcall |  Callee       |  Stored in registers, then pushed on stack in reverse order (right to left)

    1. cdecl: must return the value of the stack pointer ( ESP ) to its initial state after the callee function exits.
      ```
      cl helloc.c /Fahelloc_Gd.asm /Gd
        _main   PROC
            push    ebp
            mov ebp, esp
            push    2
            push    1
            call    _print_int
            add esp, 8
            xor eax, eax
            pop ebp
            ret 0
        _main   ENDP
      ```
    2. stdcall:  the callee must set ESP to the initial state by executing the RET x instruction instead of RET
      ```
      cl helloc.c /Fahelloc_Gz.asm /Gz
       _main   PROC
        push    ebp
        mov ebp, esp
        push    2
        push    1
        call    _print_int@8
        xor eax, eax
        pop ebp
        ret 0
      _main   ENDP

      _a$ = 8                         ; size = 4
      _b$ = 12                        ; size = 4
      _print_int@8 PROC
          push    ebp
          mov ebp, esp
          mov eax, DWORD PTR _b$[ebp]
          push    eax
          mov ecx, DWORD PTR _a$[ebp]
          push    ecx
          push    OFFSET $SG4505
          call    _printf
          add esp, 12                 ; 0000000cH
          mov eax, DWORD PTR _a$[ebp]
          add eax, DWORD PTR _b$[ebp]
          pop ebp
          ret 8
      _print_int@8 ENDP
      ```
    3. fastcall: Both MSVC and GCC pass the first and second arguments via ECX and EDX and the rest of the arguments via the stack.
      ```
      cl helloc.c /Fahelloc_Gr.asm /Gr
      _TEXT   SEGMENT
      _main   PROC
          push    ebp
          mov ebp, esp
          mov edx, 2
          mov ecx, 1
          call    @print_int@8
          xor eax, eax
          pop ebp
          ret 0
      _main   ENDP
      _TEXT   ENDS
      _TEXT   SEGMENT
      _b$ = -8                        ; size = 4
      _a$ = -4                        ; size = 4
      @print_int@8 PROC
          push    ebp
          mov ebp, esp
          sub esp, 8
          mov DWORD PTR _b$[ebp], edx
          mov DWORD PTR _a$[ebp], ecx
          mov eax, DWORD PTR _b$[ebp]
          push    eax
          mov ecx, DWORD PTR _a$[ebp]
          push    ecx
          push    OFFSET $SG4505
          call    _printf
          add esp, 12                 ; 0000000cH
          mov eax, DWORD PTR _a$[ebp]
          add eax, DWORD PTR _b$[ebp]
          mov esp, ebp
          pop ebp
          ret 0
      @print_int@8 ENDP
      _TEXT   ENDS
      ```
  * using gcc
    * __attribute__(stdcall)
    * -mrtd: 
      * Use a different function-calling convention, in which functions that take a fixed number of arguments return
           with the "ret" num instruction, which pops their arguments while returning.
      * You can specify that an individual function is called with this calling sequence with the function attribute
           stdcall.  You can also override the -mrtd option by using the function attribute cdecl.
    * -mregparm=num:
      Control how many registers are used to pass integer arguments.  By default, no registers are used to pass
           arguments, and at most 3 registers can be used.  You can control this behavior for a specific function by
           using the function attribute regparm.
# asm 
  
  gcc.pdf 
  ibm https://www.ibm.com/developerworks/library/l-ia/
    ```
    asm [volatile] ( AssemblerTemplate
                    : OutputOperands
                    [ : InputOperands
                    [ : Clobbers ] ])

    asm [volatile] goto ( AssemblerTemplate
                        :
                        : InputOperands
                        : Clobbers
                        : GotoLabels)
    extended asm statements must be inside a function, Only basic asm may be outside functions
    The asm keyword is a GNU extension. When writing code that can be compiled with ‘-ansi’ and the various ‘-std’ options, use __asm__ instead of asm

    - Simple Constraints:
      * ‘g’ Any register, memory or immediate integer operand is allowed, except for registers that are not general registers.
      * ‘r’ A register operand is allowed provided that it is in a general register.
        ```
          a	%eax
          b 	%ebx
          c 	%ecx
          d 	%edx
          S	%esi
          D	%edi
        ```
      * ‘m’ A memory operand is allowed, with any kind of address that the machine supports in general.
      * ‘o’ A memory operand is allowed, but only if the address is offsettable. 
      * ‘p’ An operand that is a valid memory address is allowed
      * ‘i’ An immediate integer operand (one with constant value) is allowed including symbolic constants 
            whose values will be known only at assembly time or later
      * i386
        ```
        q - byte-addressable register (eax, ebx, ecx, edx)
        A - eax or edx
        I - immediate 0..31
        J - immediate 0..63
        K - immediate 255
        L - immediate 65535
        M - immediate 0..3 (shifts that can be done with lea)
        N - immediate 0..255 (one-byte immediate value)
        O - immediate 0..32
        ```

   - Constraint Modifier Characters:
     When the compiler fixes up the operands to satisfy the constraints, it needs to know which operands are read by the instruction and which are written by it.
     1.‘=’ identifies an operand which is only written; 
     2. ‘+’ identifies an operand that is both read and written; 
     3. all other operands are assumed to only be read.
       * '=' Means that this operand is written to by this instruction: the previous value is discarded and replaced by new data.
       * '+' Means that this operand is both read and written by the instruction.
       * '&' Means (in a particular alternative) that this operand is an earlyclobber operand, which is written before the instruction is finished using the input operands.Therefore, this operand may not lie in a register that is read by the instruction or as part of any memory address.
       * '%' Declares the instruction to be commutative for this operand and the following operand. This means that the compiler
          may interchange the two operands if that is the cheapest way to make all operands fit the constraints. ‘%’ applies to
          all alternatives and must appear as the first character in the constraint. Only read-only operands can use ‘%’.

    - [Matching(Digit) constraints](https://www.ibiblio.org/gferg/ldp/GCC-Inline-Assembly-HOWTO.html)
      - a single variable may serve as both the input and the output operand
        ```C
        /* the register %eax is used as both the input and the output variable
         * var input is read to %eax and updated %eax is stored in var again after increment. 
         * "0" here specifies the same constraint as the 0th output variable. 
         */
        asm ("incl %0" 
          :"=&a"(var)
          :"0"(var)
          );
        asm volatile(
            "movsl"
            : "=&D"(edi), "=&S"(esi)
            : "0"(edi), "1"(esi)  /* use "0" in case of error */
            : "memory");
        ```   

  - Specifying Registers for Local Variables
    - register int *foo asm ("r12");
      ```
      int t1 = ...;
      register int *p1 asm ("r0") = ...;
      register int *p2 asm ("r1") = t1;
      register int *result asm ("r0");
      asm ("sysint" : "=r" (result) : "0" (p1), "r" (p2));
      ```

  - omit frame pointer
    ```
    -fomit-frame-pointer
    Don't keep the frame pointer in a register for functions that don't need one. This avoids the instructions to save, set up and restore frame pointers; it also makes an extra register available in many functions. It also makes debugging impossible on some machines.
    ```

* exceptions and interrupts 
  The difference between interrupts and exceptions is that interrupts are used to
  handle asynchronous events external to the processor, but exceptions handle
  conditions detected by the processor itself in the course of executing
  instructions.
  1. interrupts
    * Maskable interrupts, which are signalled via the INTR pin.
    * Nonmaskable interrupts, which are signalled via the NMI (Non-Maskable Interrupt) pin.
  2. exceptions
    * Processor detected. These are further classified as 
      1. faults: Faults are either detected before the instruction begins to execute, or during execution of the instruction.
                  If detected during the instruction, the fault is reported with the machine restored to a state that permits the
                  instruction to be restarted.
      2. traps: A trap is an exception that is reported at the instruction boundary immediately after the instruction 
                in which the exception was detected. 
      3. aborts: An abort is an exception that permits neither precise location of the instruction causing the exception nor restart of the program
                  that caused the exception. Aborts are used to report severe errors, such as hardware errors and inconsistent or 
                  illegal values in system tables.
    * Programmed. The instructions INTO, INT 3, INT n, and BOUND can trigger exceptions.
      These instructions are often called "software interrupts", but the processor handles them as exceptions.
      
  * compile intel architecture  using gcc
    [gas vs nasm] (https://web.archive.org/web/20090303224539/http://ibm.com/developerworks/linux/library/l-gas-nasm.html)
    [at&t intel](http://www.lxhp.in-berlin.de/lhpas86.html)
    [GAS](http://asm.sourceforge.net/howto/gas.html)
    * as now supports assembly
      * using Intel assembler syntax __.intel_syntax__ selects Intel mode, __.att_syntax__ switches back to the usual AT&T mode 
        for compatibility with the output of gcc. 
      * prefix, or noprefix specifying whether registers require a % prefix.

   * [AT&T Intel](http://www.sourceware.org/binutils/docs-2.12/as.info/i386-Syntax.html)
      * immediate: AT&T immediate operands are preceded by $; Intel immediate operands are undelimited
      * register:  AT&T register operands are preceded by %; Intel register operands are undelimited. 
      * jump/call: AT&T absolute (as opposed to PC relative) jump/call operands are prefixed by *; they are undelimited in Intel syntax. 
      * operands:  AT&T and Intel syntax use the opposite order for source and destination operands. Intel add eax, 4 is addl $4, %eax. 
                   The source, dest convention is maintained for compatibility with previous Unix assemblers.
      * memory size: 
        In AT&T syntax the size of memory operands is determined from the last character of the instruction mnemonic. 
        Mnemonic suffixes of b, w, l and q specify byte (8-bit), word (16-bit), long (32-bit) and quadruple word (64-bit) memory references. 

        Intel syntax accomplishes this by prefixing memory operands (not the instruction mnemonics) with byte ptr, word ptr, dword ptr and qword ptr. 
         Intel: mov al, byte ptr foo
         AT&T:  movb foo, %al
      * immediate long jump:
        AT&T: lcall/ljmp $CS:$DX   lret $stack-adjust
        INTEL: call/jmp far cs:dx  ret far stack-adjust
      * sections:The AT&T assembler does not provide support for multiple section programs. Unix style systems expect all programs to be single sections. 
        

    1. add .intel_syntax noprefix
    ```c
    /* intel_syntax.c
    #include <stdio.h>
    #include <stdlib.h>

    int get_random(void)
    {
        __asm__(".intel_syntax noprefix \n\tmov eax, 42");
    }

    int main(void)
    {
        printf("number is %d\n", get_random());
        exit(0);
    }
    ```
    2. compile use inter
      ```
      gcc -masm=intel intel_syntax.c
      ```

  - string instructions;
    instructions permit large data structures, such as alphanumeric character strings, to be moved and examined in memory. 
    - MOVS (Move String)
      ```
      cld / std
      DS:ESI  <---> ES:EDI
      ```
    - CMPS (Compare string)
      ```
      cld / std
      [DS:SI] or [DS:ESI] <----> [ES:DI] or [ES:EDI]
      inc/dec si,di
       sets the flags accordingly. 
      ```
    - SCAS (Scan string): 
      - subtracts the destination string from the EAX, AX, or AL register (depending on operand length) 
      - updates the status flags according to the results
      ```
      Error: no instruction mnemonic suffix given and no register operands
      repnz scas  --> repnz scasb

      [strlen](http://lxr.free-electrons.com/source/arch/s390/include/asm/string.h#L140)
      ```
    - LODS (Load string):
      ```
      ESI -------> EAX, AX, AL
      ```
    - STOS (Store string) 
      ```
      EAX, AX, AL ------> EDI
      ```
# [as](https://sourceware.org/binutils/docs/as/)
  - concepts
    - CFI and CFA
      ```
      CFI call frame information
      CFA call frame address
      .L<num> denotes labels    
      BF<num> indicates Function-Begin 
      EF<num> indicates FUNCTION-END   
      ```

* nasm
  * macro
    * normal define
       %define are case sensitive
       %idefine instead of %define (the ‘i’ stands for ‘insensitive’) 
       you can define all the case variants of a macro at once
      %define THIS_VERY_LONG_MACRO_NAME_IS_DEFINED_TO \
          THIS_VALUE
    * Resolving %define: %xdefine
      ```asm
      %xdefine isTrue 1
      %xdefine isFalse isTrue
      %xdefine isTrue 0
      val1: db isFalse          # 1
      %xdefine isTrue 1
      val2: db isFalse          # 1
      ```
    
    * Macro Indirection: %[...]
      ```asm
      [bits 16]
      mov ax,Foo%[__BITS__] ; # mov ax, Foo16

      %xdefine Bar Quux     ; Expands due to %xdefine
      %define Bar %[Quux]   ; Expands due to %[...]
      ```

    * Concatenating Single Line Macro Tokens: %+
      ```asm
      %define BDASTART 400h ; Start of BIOS data area
      struc tBIOSDA ; its structure
      .COM1addr RESW 1
      .COM2addr RESW 1
      ; ..and so on
      endstruc

      %define BDA(x) BDASTART + tBIOSDA. %+ x

      mov ax,BDA(COM1addr)    ; mov ax,BDASTART + tBIOSDA.COM1addr
      mov bx,BDA(COM2addr)    ; mov bx,BDASTART + tBIOSDA.COM2addr
      ```
    * The Macro Name Itself: %? and %??
      * %? refers to the macro name as invoked.
      * %?? refers to the macro name as declared.
      ```asm
      %idefine Foo mov %?,%??
      foo      ; mov foo,Foo
      FOO      ; mov FOO,Foo
      

      %idefine keyword $%?
      can be used to make a keyword "disappear", for example in case a new instruction has been used as a label in
      older code. For example:
         %idefine pause $%?
      ```
    * Undefining Single−Line Macros: %undef

    * Preprocessor Variables: %assign
      %assign i i+1

    * Defining Strings: %defstr
      ```
      %defstr test TEST
      %define test ’TEST’
      ```
    * Defining Tokens: %deftok
      ```
      %deftok test ’TEST’
      %define test TEST
      ```

    * usage
      ```
      # with debug info
      nasm -f elf -F dwarf print.asm -o read
      ```
      
* nop operations[http://computer-programming-forum.com/46-asm/218312f780fb733f.htm]
  ```
  NOPs are recommended for the following operations:
  . 1-byte: xchg EAX, EAX
  . 2-byte: mov reg, reg
  . 3-byte: lea reg, 0 (reg) (8-bit displacement)
  . 6-byte: lea reg, 0 (reg) (32-bit displacement)

  These are all true NOPs, having no effect on the state of the machine except
  to advance the EIP. Because NOPs require hardware resources to decode and
  execute, use the least number of NOPs to achieve the desired padding.

  The one byte NOP, xchg EAX,EAX, has special hardware support.
  ```

* c/c++ disassemble
  * set developing env
    ```
    call C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat
    ```
  * compile 
    ```
    cd /d D:\study\system\assembly\src 
    cl stdcall_x64.c /Fastdcall_x64.asm
    cl stdcall_x64 /Ob /Fa stdcall_x64.asm
    ```

# IDA pro
  # why disassebly
    * analysis of malware
    * analysis of vulnerabilities
    * software interoperability
    * compile validation
    * debugging display
    