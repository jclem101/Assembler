;factorial program
;John Clem
;Feb 9th, 2011



.Model Small

.Stack 100h

.Data

Msg DB 10, 13, 'enter a whole number less than 8 or greater than one' ,10, 13, '$'
Msgtwo DB 10, 13, 'the factorial of the number you entered is', 10, 13, '$'
.Code

fact   Proc
; startup code

       mov ax, @data
       mov ds, ax

entry:
; display Msg

       mov dx, OFFSET Msg
       mov ah, 09h
       int 21h


; get character from keyboard

    mov ah, 01h 
	int 21h
;jump to entry if user enters a character greater than 8
     cmp al, 38h
	JG entry 
;jump to entry if enters a value less than 1
	cmp al, 31h
	JL entry
	
;clear ah
	mov ah, 0
; convert character entered into numeral 
	sub al, 30h 
;push first value to stack
	push ax
;clear ax
	mov ax, 0
;call recurse
		call recurse
;display second message        
	   mov dx, OFFSET Msgtwo
       mov ah, 09h
       int 21h
;provide value to be divided/displayed
	   push ax 
;display total of factorial
	   call disp10
; setup for exit to dos
        mov al, 0
        mov ah, 04ch
        int 21h
; done

fact ENDP



disp10 Proc 


; setup for division
       mov bx, 10    ;0ah in hex
; setup counter
       mov cx, 0

divloop:
;clear dx for future divides
        mov dx, 0

; divide by 10, divisor in bx
        div bx
; save the remainder
        push dx
; add one to counter
        add cx, 1
; if quotient is not zero, divide again
        cmp ax, 0
        JNZ divloop
	
disploop:
; retrieve the digit to dx
        pop dx
; change to character
        add dx, 30h
; display character
        mov ah, 02h
        int 21h
; if not done, go back to retrieve/disloop 
        LOOP disploop

disp10 ENDP

recurse proc 
;get the value 
	;pop bx
;get value
	pop ax
	
	;push bx
; see if done, if current number is equal to one then jump to factret
	
    cmp ax, 1
    JE factret
;put the value back for later	
	push ax
; decrement value 
	dec ax
; puttin in the lower value on top, should have in ax when goes to mul	
	push ax

call recurse ; recursion occurs here
;multiplication occurs here after all values are inserted factret returns here when called
	pop bx
	mul bx
factret:	
ret ; returns to fact process

recurse ENDP

End fact
