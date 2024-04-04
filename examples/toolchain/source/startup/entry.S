.section .init

.option norvc

.type asm_start, @function
.global asm_start
asm_start:
    .cfi_startproc

.option push
.option norelax
    la gp, global_pointer
.option pop

    /* Reset satp */
    # csrw satp, zero

    /* Setup stack */
    la sp, stack_top

    /* Clear the BSS section */
    la t5, bss_start
    la t6, bss_end
bss_clear:
    # sd zero, (t5)
    addi t5, t5, 8
    bgeu t5, t6, bss_clear

    la t0, _start
    # csrw mepc, t0

    /* Jump to _start function! */
    tail _start

    .cfi_endproc

.end
