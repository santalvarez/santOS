ENTRY(_start)
phys = 0x40200000;          /* RAM base on QEMU virt (AArch32) */

SECTIONS {
  . = phys;

  /* code & read-only data */
  .text : {
    *(.text.start)          /* put _start first for neatness */
    *(.text .text.*)
    *(.rodata .rodata.*)
  }

  /* initialized data */
  .data : {
    *(.data .data.*)
  }

  /* zero-fill at runtime; not stored in the file */
  .bss (NOLOAD) : {
    __bss_start__ = .;
    *(.bss .bss.*) *(COMMON)
    __bss_end__ = .;
  }

  /* a simple stack placed right after the image (64 KiB) */
  . = ALIGN(16);
  stack_top = . + 0x10000;
}
