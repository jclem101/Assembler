;example11
.model small
.stack
.code
mov ah,2h
mov dl,2ah
;
int 21h
mov ah,4ch
int21h
end
