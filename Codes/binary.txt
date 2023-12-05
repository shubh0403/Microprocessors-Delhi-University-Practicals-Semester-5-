.model small
.386
.data
ARRAY DW 20 DUP (?)
DATA1 dw 0000H
DATA2 dw 0000H
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
MOV SI, DX
MOV [BX + SI], AX
INC SI
LOOP L1

MOV AH,09
MOV DX,OFFSET msg3
INT 21H
MOV AH,01 ; Enter element to be searched
INT 21H
SUB AL,30H


MOV DATA2,AX
MOV CX,DATA1
MOV SI,0
MOV DI, DATA1
MOV BP, 0
MOV BX, OFFSET ARRAY
MOV AX, DATA1
L2: MOV SI, DI
ADD SI, BP
MOV AX, SI
MOV DL, 2
DIV DL

MOV AH,0
MOV DX,0
MOV SI,AX
MOV DX,DATA2
CMP [BX + SI],DL
JZ L3
CALL L4
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

L4 PROC NEAR
CMP [BX+SI], DL
JL L6
MOV DI, SI
RET
L6: MOV BP,SI
RET
L4 ENDP
.EXIT
END
