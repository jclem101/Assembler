.Model Small

.Stack 100h

.Data
Menu1		DB 10, 13, '_______________________'
				DB 10, 13, '||enter your selection||'
				DB 10, 13, '||**************************************************||'
				DB 10, 13, '||enter 1 to convert a dec value to hex ' 
				DB 10, 13, '||enter 2 to convert a character to hex' 
				DB 10, 13, '||enter 3 to exit the program'
				DB 10, 13, '||**************************************************||',10, 13, '$'
Msg5 DB 10,13, 'enter a base ten number up to 5 digits, press enter when done', 10, 13, '$'
Msg6 DB 10,13, 'enter any one character, press enter when done' ,10 , 13, '$'
Msg7 DB 10,13,10,13, 'your converted number is as follows', 10, 13, '$'
.Code

main Proc

	;startup
		mov ax, @data
		mov ds, ax
	 start:
		call menu
	;get user selection	and verify
		call getsel
			
	; setup for exit to dos
	   exit:
		mov al, 0
		mov ah, 04ch
		int 21h

main ENDP
;-------------------------------------
menu proc
	;displays menu
		mov dx, OFFSET Menu1
		mov ah, 09h
		int 21h
	;clear trash
		mov ax,0
		mov dx,0
		ret   	   
menu ENDP
;--------------------------------------------
getsel proc
;enter character from keyboard with echo
	mov ah, 01h 
	int 21h
;clear trash
	mov ah, 0
;if character is 1 then jump to choice1
	cmp al, 31h
	jz choice1
;if character is 2 then jump to choice2
	cmp al, 32h
	jz choice2
;if character is 3 then jump to exit, if not 3 then error
	cmp al, 33h
	jnz errormsg
	jz exit
choice1: 
	call dectohex
	jmp start
choice2: 
	call chartohex
	jmp start	
errormsg:

	jmp start
getsel ENDP

;----------------------
get10 proc ;no arguments, pushes result, result should not exceed word size.
;display message 5 
	mov dx, OFFSET Msg5
	mov ah, 09h
	int 21h
;clear  trash from registers
	mov ax,0
	mov dx,0
;put a single zero on the stack 
	push ax
getachar:
;getchar with echo
	mov ah, 01h
	int 21h
;clear trash 
	mov ah, 0
;check for enter
	cmp al, 13
	JZ finished	
;convert to dec, sub 30h	
	sub ax, 30h
;clear cx
	mov cx, 0
;save ax to add
	mov cx, ax
;pop ax
	pop ax
;;setup for division
	mov bx, 10	
;mul by 10, multiply bx
	mul bx
;add previous digit to lower order of product of mul
	add ax, cx
; push ax
	push ax
; get another character
	jmp getachar
finished:
;pop ax
	pop ax
;return
	ret
get10 ENDP
;-------------------------------------------
;--------------------------------------
disp16 proc
;setup for division
	mov bx,16
;clear counter	
	mov cx, 0
divloop:
	mov dx,0
;divide, dividend  in ax, divisor in bx	
	div bx
; push remainder	
	push dx
; increment counter	
	inc cx
; compare quotient to 0, if zero jump to display portion	
	cmp ax, 0
	jnz divloop
disploop:
; pop remainder that was pushed during divide portion	
	pop dx
;see if its higher than 9, if it is then you want to display charactercharacter, not deccharacter	
	cmp dx, 9
	jle displaydec
	jg displaychar
; if it is higher than 9 we need to display character not numeral	,41 hex - 10 hex is 37 hex 
displaydec:
;change to decimal character
	add dx, 30h
; display character
	mov ah, 02h
	int 21h
	jmp looper
displaychar:
; change to character character	
	add dx, 37h 
;display	
	mov ah, 02h
	int 21h
	jmp looper
looper:	
	LOOP disploop
; return	
	ret
disp16 ENDP
;------------------------------------
dectohex PROC
;get some numbers from user	
	call get10
;save ax from message
	push ax
;display result message	
	mov dx, OFFSET Msg7
	mov ah, 09h
	int 21h
;clear trash from int	
	mov ax, 0
	mov dx, 0
;retrieve number	
	pop ax
;display the number	
	call disp16
ret
dectohex ENDP
;---------------------------------------------------
chartohex PROC
; display prompt	
	mov dx, OFFSET Msg6
	mov ah, 09h
	int 21h
;clear trash from int	
	mov ax, 0
	mov dx, 0
;get the character
	mov ah, 01h
	int 21h	
;clear trash from upper order byte	
	mov ah, 0
;push to save from message	
	push ax
;display result message	
	mov dx, OFFSET Msg7
	mov ah, 09h
	int 21h
;retrieve the character	
	pop ax
;display character using disp16	
	call disp16
;return to getsel	
ret
chartohex ENDP
;---------------------------------------------------
End main	