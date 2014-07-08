
 ;Program 1 hello.asm , John Clem, CIS 206, Barbara Smith 

        .MODEL SMALL

        .STACK 100h

        .DATA
Msgone DB 10, 13, 'John Clem.', 10, 13, '$'
Msgtwo DB 10, 13, 'hello.asm', 10, 13, '$'
Msgthree DB 10, 13, 'completed January 24th, 2011', 10, 13, '$'



        .CODE
Hello   PROC
       
        ;startup code must be the first lines in any assembler program
        mov ax, @data
        mov ds, ax

        ;Display the message
        mov dx, OFFSET Msgone
        mov ah, 09h
        int 21h

        mov dx, OFFSET Msgtwo
        mov ah, 09h
        int 21h

        mov dx, OFFSET Msgthree
        mov ah, 09h
        int 21h


        ;exit to dos
        mov al, 0
        mov ah, 4ch
        int 21h

Hello ENDP
      END Hello  
