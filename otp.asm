%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    mov eax, 0
    for1:
        mov ebx, [esi + eax] ; se pune cate un char din esi
        mov [edx + eax], ebx ; in edx prin intermediul ebx

        mov ebx, [edi + eax] ; se retine valoarea char ului corespunzator
        xor [edx + eax], bl ; din key si se face xor
    add eax, 1
    cmp eax, ecx
    jl for1

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY