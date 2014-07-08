;Today is the date program
;John Clem
;Jan 24th, 2011



.Model Small

.Stack 100h

.Data

Msg DB 10, 10, 13, 'Today is $'

.Code

today    Proc
; startup code

       mov ax, @data
       mov ds, ax


; display Msg

       mov dx, OFFSET Msg
       mov ah, 09h
       int 21h

; retrieve the date , year in cx, month in dh, day in dl
       mov ah, 02ah  ; pg. 710
       int 21h

; save the year

       push cx


; clear cx
       mov cx, 0


; move the day (dl) to cl
        mov cl, dl
        
; save the day
        push cx
; move the month(dh) to cl
        mov cl, dh

; save the month
        push cx
; retreive the month
        pop ax
call setup
call divproc
call disproc
call slash
call ClrCntr
;retrieve the day
		pop ax
call setup
call divproc
call disproc
call slash
call ClrCntr
;retrieve the year
		pop ax
call setup
call divproc
call disproc



; setup for exit to dos
        mov al, 0
        mov ah, 04ch
        int 21h
; done

today ENDP

divproc Proc
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
        jnz divloop
ret
divproc ENDP

disproc Proc
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
ret
disproc ENDP

setup Proc
; setup for division
       mov bx, 10    ;0ah in hex
       ; setup counter
       mov cx, 0
ret
setup ENDP	

slash Proc
   ; display '/'
        mov ah, 02h
        mov dl, '/'
        int 21h
ret		
slash ENDP

ClrCntr Proc
; setup counter
       mov cx, 0
ClrCntr ENDP

End today


