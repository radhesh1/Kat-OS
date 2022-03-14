@this file will save current register values by writing them to a file called data.txt
@if a file called data.txt is not found it will return an error
  .global _start
_start:
  PUSH {R4-R12} @pushes the data in registers 4-12 to the stack
  LDR R0,=data.txt @loads R0 with the address of the data file
  MOV R1, #0 @flag read only file
  MOV R2, #0666
  MOV R7, #5
  SWI 0
  
  MOVS R8, R0
  BPL writebuffer
  MOV R0, #1
  LDR R1,=error1
  MOV R2, #18
  MOV R7, #4
  SWI 0
  B   finish

store:  @ignore this section as it is still under developement because I am confused as to when I should use LDR and when I should use STR
  POP {R12}
  STR R12,=regvals
  BL writebuffer
  POP {R11}
  STR R11,=regvals
  BL writebuffer
  POP {R10}
  STR R10,=regvals
  BL writebuffer
  POP {R9}
  STR R9,=regvals
  BL writebuffer
  POP {R8}
  STR R8,=regvals
  BL writebuffer
  POP {R7}
  STR, R7,=regvals
  BL writebuffer
  POP {R6}
  STR R6,=regvals
  BL writebuffer
  POP {R5}
  STR R5,=regvals
  BL writebuffer
  POP {R4}
  STR R4,=regvals
  BL writebuffer
  
writebuffer: 
  LDR R1,=regvals @loads R1 with the string at regvals
  MOV R2, #16 @string is 16 characters long
  MOV R7, #4 @system write
  SWI 0 @interrupt

@flush and close data.txt
  MOV R0, R8
  MOV R7, #118
  SWI 0
  MOV R0, R8
  MOV R7, #6
  SWI 0
  
finish:
  MOV R0, #0 @0 return code
  MOV R7, #1 @sys exit
  SWI 0
  
.data
data.txt: .asciz "data.txt" @file name
regvals: .asciz "                \n" @string