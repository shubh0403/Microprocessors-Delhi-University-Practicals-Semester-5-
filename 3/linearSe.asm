.model small
.386
.data
ARRAY DW 20 DUP (?)
DATA1 dw 0000H
success db 10,13,"Element is present in the array $"
fail db 10,13,"Element is not present in the arary $"
msg db 10,13,"Enter the size of the array :: $"
msg2 db 10,13,"Enter the array :: $"
msg3 db 10,13,"Enter the element to be searched :: $"
.code
.startup
MOV AH,09
MOV DX,OFFSET msg
INT 21H

MOV AH,01
INT 21H
SUB AL,30H
MOV AH,0
MOV CX,AX

MOV DATA1,AX

MOV AH,09
MOV DX,OFFSET msg2
INT 21H
MOV AH,0
MOV SI, 0
MOV BX, OFFSET ARRAY
L1: MOV DL, 0AH ; jump onto next line
MOV AH, 02H
INT 21H
MOV DX, SI ; input element of the array
MOV AH, 01H
INT 21H

SUB AL,30H
;MOV SI, DX
MOV [BX + SI], AX
INC SI
LOOP L1

MOV CX,DATA1

MOV AH,09
MOV DX,OFFSET msg3
INT 21H

MOV AH,01 ; Enter element to be searched
INT 21H
SUB AL,30H
MOV SI, 0
MOV BX, OFFSET ARRAY
L2: CMP [BX + SI], AL ; linear search loop
JZ L3 ; jump if element is found
INC SI
LOOP L2

MOV AH, 09H
MOV DX,OFFSET fail ; if the element is not found
INT 21H
MOV AH, 4CH ; to forcefully terminate the program
INT 21H
L3: MOV AH, 09H
MOV DX,OFFSET success ; if the element is found
INT 21H
MOV AH, 4CH
INT 21H
.EXIT
END
