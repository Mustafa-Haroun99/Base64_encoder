%include "io.inc"
global _main
extern _printf
section .data
Table: db 
'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
+/', 0
input: db 'TUYxNjQxMDFNQTE2NDA5NEFBMTY0MDY3', 0 ;Write Your Input 
Here Between The Quotes 
output: db 'E', 0
Counter: dd 5
shiftCount: db 0
edxCopy: db 0
section .text
_main:
mov ebp, esp
xor eax, eax
xor edx, edx
mov ebx, input
numOfCharsLoop:
mov al, [ebx]
cmp al, 0
jz mainProcess
inc edx
inc ebx
jmp numOfCharsLoop 
cmp edx, 0
je done
mainProcess:
mov [Counter], edx
xor eax, eax
xor ecx, ecx
mov ebx, Table
mov esi, input
mov edi, output
add esi, edx
sub esi, 4
mov edi, output
mov eax, [esi]
bswap eax
cmp ah, '='
jne oneequal
add ecx, 4
jmp caseone
oneequal:
cmp al, '='
jne casethree
add ecx, 2
jmp casetwo
caseone:
shr eax, 16
xor edx, edx
search_1:
inc edx
inc ebx
cmp al, [ebx-1]
jne search_1
dec edx
shr edx, 4
mov ecx, edx
mov ebx, Table
shr eax, 8
xor edx, edx
search0:
inc edx
inc ebx
cmp al, [ebx-1]
jne search0
dec edx
shl edx, 2
add ecx, edx
mov ebx, Table
sub dword[Counter], 4
sub esi, 4
mov [edi], cl
dec edi
jmp casethree
casetwo:
shr eax, 8
xor edx, edx
search:
inc edx
inc ebx
cmp al, [ebx-1]
jne search
dec edx
shr edx, 2
mov ecx, edx
mov ebx, Table
shr eax, 8
xor edx, edx
search1:
inc edx
inc ebx
cmp al, [ebx-1]
jne search1
dec edx
shl edx, 4
add ecx, edx
mov ebx, Table
shr eax, 8
xor edx, edx
search2:
inc edx
inc ebx
cmp al, [ebx-1]
jne search2
dec edx
shl edx, 10
add ecx, edx
mov ebx, Table
sub dword[Counter], 4
sub esi, 4
mov [edi], cl
dec edi
mov [edi], ch
dec edi
jmp casethree
casethree:
xor edx, edx
cmp dword[Counter], 0
je done
mov eax, [esi]
bswap eax
xor ecx, ecx
mainLoop:
mov dword[edxCopy], 0
search3:
inc dword[edxCopy]
inc ebx
cmp al, [ebx-1]
jne search3
dec dword[edxCopy]
shl dword[edxCopy], cl
add edx, dword[edxCopy]
add cl, 6
mov ebx, Table
cmp eax,0
je temp
shr eax, 8
jmp mainLoop
temp:
sub dword[Counter], 4
sub esi, 4
mov [edi], dl
dec edi
mov [edi], dh
dec edi
shr edx, 16
mov [edi], dl
dec edi
jmp casethree
done:
inc edi
push edi
call printf
add esp, 4
ret
