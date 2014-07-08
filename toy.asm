;CS 0dfa IP odf1 OP 63 61 6c 5c 54

.Model Small

.Stack 100h

.Data

menu1		DB 10, 13, '**\\\\\\\\\TOY//////////**'
				DB 10, 13, '________________________'
				DB 10, 13, '||A_________B_________C||', 10, 13, '$'
menu2	    DB 10, 13, '||1_________2_________3||', 10, 13, '$'
menu3	    DB 10, 13, '||_____4_________5_____||', 10, 13, '$'
menu4		DB 10, 13, '||6_________7_________8||'
				DB 10, 13, '||enter your selection ||'
				DB 10, 13, '||**************************************************||'
				DB 10, 13, '||enter 1 to put marble into hole A ' 
				DB 10, 13, '||enter 2 to put marble into hole B' 
				DB 10, 13, '||enter 3 to put marble into hole C'
				DB 10, 13, '||enter 4 to exit program'
				DB 10, 13, '||**************************************************||',10, 13, '$'
result1 DB 10, 13, 'ball exited from 6', 10, 13, '$'		
result2 DB 10, 13, 'ball exited from 7', 10, 13, '$'
result3 DB 10, 13, 'ball exited from 8', 10, 13, '$'	
toyarray1 DB '0', '$'
toyarray2 DB	 '0', '$'
toyarray3 DB '0', '$'
toyarray4 DB	'0', '$'
toyarray5 DB '0', '$'
toyarray6 DB	 '0', '$'
toyarray7 DB '0', '$'
toyarray8 DB	 '0', '$'
space DB '         ', '$'
space5 DB '        ', '$'
halfspace DB '     ', '$'
crln DB '', '$'
twobar DB '||', '$'
	
.Code

main Proc
	;startup
		mov ax, @data
		mov ds, ax
	 start:
		mov ax, 0
		mov bx, 0
		mov cx, 0
		mov dx, 0
		
		call displaytoy
	;get user selection	and verify
		call getsel
			
	; setup for exit to dos
	   exit:
		mov al, 0
		mov ah, 04ch
		int 21h
main ENDP

getsel proc
;enter character from keyboard with echo
	mov ah, 01h 
	int 21h
	
	mov ah, 0
;if character is 1 then jump to choice1
	cmp al, 31h
	jz choice1
;if character is 2 then jump to choice2
	cmp al, 32h
	jz choice2
;if character is 3 then jump to exit, if not 3 then error
	cmp al, 33h
	jz choice3
;if character is 4 then quit.	
	cmp al, 34h
	jz exit
	jnz errormsg
choice1: 
	call switch1
	jmp start
choice2: 
	call switch2
	jmp start	
choice3:
	call switch3
	jmp start
errormsg:
    jmp start	
getsel ENDP
;---------------------------------------
switch1 proc
cmp toyarray1,  '1'
jz one1
jnz zero1
zero1:
mov toyarray1,  '1'
call switch6
ret
one1:
mov toyarray1, '0'
call switch4
ret
switch1 ENDP
;---------------------------------------
switch2 proc
cmp toyarray2,  '1'
jz one2
jnz zero2
zero2:
mov toyarray2,  '1'
call switch5
ret
one2:
mov toyarray2, '0'
call switch4
ret
switch2 ENDP
;---------------------------------------
switch3 proc
cmp toyarray3,  '1'
jz one3
jnz zero3
zero3:
mov toyarray3,  '1'
call switch5
ret
one3:
mov toyarray3, '0'
call switch8
ret
switch3 ENDP
;---------------------------------------
switch4 proc

cmp toyarray4,  '1'
jz one4
jnz zero4
zero4:
mov toyarray4,  '1'
call switch7
ret
one4:
mov toyarray4, '0'
call switch6
ret
switch4 ENDP
;---------------------------------------
switch5 proc

cmp toyarray5,  '1'
jz one5
jnz zero5
zero5:
mov toyarray5,  '1'
call switch8
ret
one5:
mov toyarray5, '0'
call switch7
ret
switch5 ENDP
;---------------------------------------
switch6 proc

cmp toyarray6,  '1'
jz one6
jnz zero6
zero6:
mov toyarray6,  '1'
mov   ah, 0Fh                      
int   10h                         
mov  ah, 0h                       
int   10h 
 mov dx, OFFSET result1
       mov ah, 09h
       int 21h
jmp start
one6:
mov toyarray6, '0'
mov   ah, 0Fh                      
int   10h                         
mov  ah, 0h                       
int   10h 
mov dx, OFFSET result1
       mov ah, 09h
       int 21h
jmp start
switch6 ENDP
;---------------------------------------
switch7 proc

cmp toyarray7,  '1'
jz one7
jnz zero7
zero7:
mov toyarray7,  '1'
mov   ah, 0Fh                      
int   10h                         
mov  ah, 0h                       
int   10h 
mov dx, OFFSET result2
       mov ah, 09h
       int 21h
jmp start
one7:
mov toyarray7, '0'
mov   ah, 0Fh                      
int   10h                         
mov  ah, 0h                       
int   10h 
mov dx, OFFSET result2
       mov ah, 09h
       int 21h
jmp start
switch7 ENDP
;---------------------------------------
switch8 proc

cmp toyarray8,  '1'
jz one8
jnz zero8
zero8:
mov toyarray8,  '1'
mov   ah, 0Fh                      
int   10h                         
mov  ah, 0h                       
int   10h 
mov dx, OFFSET result3
       mov ah, 09h
       int 21h
jmp start
one8:
mov toyarray8, '0'
mov   ah, 0Fh                      
int   10h                         
mov  ah, 0h                       
int   10h 
 mov dx, OFFSET result3
       mov ah, 09h
       int 21h
jmp start
switch8 ENDP
;---------------------------------------
displaytoy proc
mov dx, OFFSET menu1
       mov ah, 09h
       int 21h
	    mov dx, OFFSET twobar
       mov ah, 09h
       int 21h
	   mov dx, OFFSET toyarray1
       mov ah, 09h
       int 21h
	   mov dx, OFFSET space
       mov ah, 09h
       int 21h
	   mov dx, OFFSET toyarray2
       mov ah, 09h
       int 21h
		mov dx, OFFSET space
       mov ah, 09h
       int 21h
	   mov dx, OFFSET toyarray3
       mov ah, 09h
       int 21h
	   mov dx, OFFSET crln
       mov ah, 09h
       int 21h
	    mov dx, OFFSET twobar
       mov ah, 09h
       int 21h
	   ; end of line 1
	   mov dx, OFFSET menu2
       mov ah, 09h
       int 21h
	    mov dx, OFFSET twobar
       mov ah, 09h
       int 21h
	   mov dx, OFFSET halfspace
       mov ah, 09h
       int 21h
	   mov dx, OFFSET toyarray4
       mov ah, 09h
       int 21h
	   mov dx, OFFSET space
       mov ah, 09h
       int 21h
	   mov dx, OFFSET toyarray5
       mov ah, 09h
       int 21h
	   mov dx, OFFSET halfspace
       mov ah, 09h
       int 21h
	    mov dx, OFFSET twobar
       mov ah, 09h
       int 21h
	   ; end of line 2
	   mov dx, OFFSET menu3
       mov ah, 09h
       int 21h
	    mov dx, OFFSET twobar
       mov ah, 09h
       int 21h
	   mov dx, OFFSET toyarray6
       mov ah, 09h
       int 21h
	   mov dx, OFFSET space
       mov ah, 09h
       int 21h
	   mov dx, OFFSET toyarray7
       mov ah, 09h
       int 21h
	   mov dx, OFFSET space
       mov ah, 09h
       int 21h
	   mov dx, OFFSET toyarray8
       mov ah, 09h
       int 21h
	   mov dx, OFFSET crln
       mov ah, 09h
       int 21h
	    mov dx, OFFSET twobar
       mov ah, 09h
       int 21h
	   ;end of line 3
	   mov dx, OFFSET menu4
       mov ah, 09h
       int 21h
	   
	   ret
displaytoy ENDP


END main
