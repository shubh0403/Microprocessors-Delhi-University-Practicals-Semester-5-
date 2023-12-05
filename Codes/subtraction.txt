.model small
.386
.data
num1 DD 00000000H
num2 DD 00000000H
num3 DD 00000000H
msg db 10,13,"Enter the first no.:: $"
msg1 db 10,13,"Enter the second no.:: $"
msg2 db 10,13,"The Resultant difference is :: $"

.code
.startup

MOV AH,09
MOV DX,OFFSET msg
INT 21H

MOV EBX,0
MOV CX,8

AGAIN: MOV AH,01 ;1ST NO. ENTERED
INT 21H
CMP AL,'A'
JGE L2
SUB AL,30H
SHL EBX,4
ADD BL,AL
LOOP AGAIN

MOV num1,EBX

MOV AH,09
MOV DX,OFFSET msg1
INT 21H

MOV EBX,0
MOV CX,8
AGAIN1:MOV AH,01 ;2nd NO. ENTERED
INT 21H
CMP AL,'A'
JGE L2
SUB AL,30H
SHL EBX,4
ADD BL,AL
LOOP AGAIN1

MOV num2, EBX

mov ax, word ptr num1
mov dx, word ptr num2
sub al,dl   ; Change ADD to SUB here
daa
mov bl,al

mov al,ah
sbb al,dh   ; Change ADC to SBB here
daa
mov bh,al

mov word ptr num3, bx

mov ax, word ptr num1+2
mov dx, word ptr num2+2
sbb al,dl   ; Change ADD to SUB here
daa
mov bl,al

mov al,ah
sbb al,dh   ; Change ADC to SBB here
daa
mov bh,al

mov word ptr num3+2,bx
mov ebx,num3

mov ah, 09h
mov dx, offset msg2
int 21h

jnc l6
mov ah, 02h
mov dl, "1"
int 21h 

l6: MOV CX,8
AGAIN2: ROL EBX,4
MOV DL,BL
AND DL,0FH
ADD DL,30H
MOV AH,02
INT 21H
LOOP AGAIN2
L2: .EXIT
END