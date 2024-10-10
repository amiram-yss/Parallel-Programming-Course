.intel_syntax noprefix

.section .data
    .align 16

.section .text
    .globl hamming_dist

hamming_dist:
    push rbp
    mov rbp, rsp
    push rsi
    push rdi

    xor eax, eax      # initialize counter

    pxor xmm0, xmm0   # initialize xmm0 register to zero

loop_start:

    pxor    xmm1, xmm1
    pxor    xmm2, xmm2
    
    movdqu xmm1, [rsi] # load 16 bytes from first string
    movdqu xmm2, [rdi] # load 16 bytes from second string
    pcmpeqb xmm1, xmm2 # compare the bytes for equality
    pmovmskb eax, xmm2 # move the comparison result to eax

    popcnt eax, eax   # count the number of set bits in eax

    add rsi, 16       # move to next 16 bytes in first string
    add rdi, 16       # move to next 16 bytes in second string

    cmp byte ptr [rsi], 0 # check if end of string
    jne loop_start

end_loop:
    pop rdi
    pop rsi
    leave
    ret