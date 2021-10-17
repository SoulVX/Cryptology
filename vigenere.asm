%include "io.mac"

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    mov eax, 0
    mov ecx, 0
    for1:
        movzx ebx, byte [esi + eax]
        cmp ecx, [ebp + 24]
            jae repetare_key ; se ocupa de extinderea cheii
        continue_for_prim:
        push ecx
        movzx ecx, byte [edi + ecx] ; ecx se transforma din indice in
        sub ecx, 65 ; valoarea deplasarii fiecarei litere
        cmp bl, 65
            jae peste_65
        pop ecx
        continue_for:
        mov [edx + eax], bl
    inc eax
    cmp eax, [ebp + 16]
    jl for1

    jmp exit

    repetare_key:
        sub ecx, [ebp + 24]
        cmp ecx, [ebp + 24]
            jae repetare_key
    jmp continue_for_prim

    norm_26_litera:
        sub bl, 26
    jmp continue_for

    peste_65:
        cmp bl, 90
            jbe e_litera_mare
        cmp bl, 97
            jae peste_97
    jmp continue_for_cu_pop

    peste_97:
        cmp bl, 122
            jbe e_litera_mica
    jmp continue_for_cu_pop

    continue_for_cu_pop:
        pop ecx
    jmp continue_for

    e_litera_mare:
        add ebx, ecx
        pop ecx
        inc ecx
        cmp bl, 90
            jg norm_26_litera
    jmp continue_for

    e_litera_mica:
        add ebx, ecx
        pop ecx
        inc ecx
        cmp bl, 0
            jl overflow
        cmp bl, 122
            jg norm_26_litera
    jmp continue_for

    overflow:
        sub ebx, edi
        sub ebx, 26
        add ebx, edi
    jmp continue_for
    
    exit:

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY