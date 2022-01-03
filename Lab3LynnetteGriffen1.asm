;-------------------------------------
;Lynnette Griffen
;Find the sum of random numbers in an array
;-------------------------------------

;Library for I/O and other purposes
;-------------------------
include     c:\asmio\asm32.inc
includelib  c:\asmio\asm32.lib
includelib  c:\asmio\user32.lib     ;Need these two files for SASM with I/O
includelib  c:\asmio\kernel32.lib   ;Need these two files for SASM with I/O
;---------------------------------
.const
    NULL equ    0
;------------------------------
.data?          ;Uninitialized data section
   ; rnumb dword ?
   SZ dword ?
   Array dword 50 dup (?) ; Uninitialized cells
  
.data
                   ;strings must be null terminated!
    Input byte "Pick a number between 10-30: ", NULL
    blanks byte "  ", NULL
    summsg byte "The sum of the cells is: ", NULL
    arraymsg byte "The array cells are: ", NULL
    sum dword 0
;------------------------------------------
.code
main proc   ;Start the main procedure   

    ;Random generating code: we need to start the seed at the current time
    ;-----------------------
    call Randomize          ;Sets the seed - MUST BE DONE ONCE!!
    
    ;Request a number between 10-30 from user
    ;-----------------------
    mov     edx, OFFSET Input       ; String must be in edx
    call    WriteString             ; NOT CASE SENSITIVE
    call    readInt                 ;number is in EAX
    mov     SZ, eax                 ; save number
    
    
    mov     ecx, SZ ; Set Loop counter to Input
    
    ;Set Range of Random Number
    mov     eax, 100                  ;
    inc     eax
    call    RandomRange 
    
    ;Sets array ellements
    ;----------
    mov     esi, OFFSET Array
L1: mov     eax, 100                  ;
    inc     eax
    call    RandomRange
    mov [esi], eax
   ; mov ecx, SZ
  mov eax, [esi]
   ; call    WriteInt
    ;add     sum, eax
    ;mov     edx, OFFSET blanks       ; String must be in edx
    ;call    WriteString
    add esi, TYPE dword
    loop L1
    call Crlf
    
    mov     edx, OFFSET arraymsg
    call    WriteString
    call Crlf
    
    
    ;Print on one line with space between
    ;------------------
    mov esi, OFFSET Array
    mov ecx, SZ
    mov ebx, 0      ; set ebx to 0
    L2: mov eax, [esi]
    add ebx, eax      ;Add number in array to ebx
    add esi, type Array
    call    WriteInt
    
    mov     edx, OFFSET blanks
    call    WriteString
    
    loop L2
    
    call Crlf
    ;Print the sum of array stored in ebx
    mov     edx, OFFSET summsg
    call    WriteString
    ;mov eax, sum
    mov eax, ebx
    call WriteInt
 
    call    readInt
    
    ret     0                        ; Must always ret 0
main    endp                         ; End of main Procedure
    end         main                 ; End of program