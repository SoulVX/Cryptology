%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    while1: ; se "normeaza" key la o valoare intre 0 si 26 prin
        cmp edi, 26 ; scadere repetata (posibil datorita circularitatii)
            jae norm_26

    mov eax, 0
    for1:
        mov ebx, [esi + eax]
        cmp bl, 65 ; se incepe verificarea in legatura cu categoria
            jae peste_65 ; de char din care face parte char-ul curent
        continue_for:
        mov [edx+eax], bl
    add eax, 1
    cmp eax, ecx
    jl for1

    jmp exit

    norm_26:
        sub edi, 26
    jmp while1

    norm_26_litera:
        sub bl, 26
    jmp continue_for 

    peste_65:
        cmp bl, 90
            jbe e_litera_mare
        cmp bl, 97
            jae peste_97
    jmp continue_for ; nu e litera => se ignora

    peste_97:
        cmp bl, 122
            jbe e_litera_mica
    jmp continue_for

    e_litera_mare:
        add ebx, edi
        cmp bl, 90
            jg norm_26_litera
    jmp continue_for

    e_litera_mica:
        add ebx, edi
        cmp bl, 0 ; daca in urma aditiei s-a facut overflow peste bit-ul
            jl overflow ; de semn, se corecteaza
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