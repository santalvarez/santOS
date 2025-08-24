/* start.S — tiny A32 startup for Cortex-A15 / QEMU virt */
  .syntax unified
  .cpu cortex-a15
  .arch armv7-a

  .extern __bss_start__
  .extern __bss_end__
  .extern stack_top

  .section .text.start, "ax", %progbits
  .global _start
_start:
  /* go to SVC, mask IRQ/FIQ so we can ignore vectors for now */
  mrs     r0, cpsr
  bic     r0, r0, #0x1f
  orr     r0, r0, #0x13            @ SVC
  orr     r0, r0, #(1<<7)|(1<<6)   @ I=1, F=1
  msr     cpsr_c, r0

  /* set up a stack */
  ldr     sp, =stack_top

  /* clear .bss: for (p=bss; p<ebss; p+=4) *p = 0; */
  ldr     r0, =__bss_start__
  ldr     r1, =__bss_end__
  mov     r2, #0
1:  cmp     r0, r1
  bcs     2f
  str     r2, [r0], #4
  b       1b
2:
  bl      Kern_main

hang:
  b       hang
