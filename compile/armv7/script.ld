OUTPUT_ARCH(arm)
ENTRY(_start)
physbase = 0x81000000;

SECTIONS
{
  . = physbase;                 /* Image starts here */
  . = ALIGN(4096);              /* Accommodate bad physbase */
  .text : {
    text = ABSOLUTE(.);         /* text: beginning of text segment */
    *(.text .text.*)            /* asm text, then C text */
    *(.rodata .rodata.*)        /* asm and C read-only data */
    etext = ABSOLUTE(.) ;       /* etext: end of text */
    . = ALIGN(4096);
  }
  .data :
  {
    data = ABSOLUTE(.);         /* data: beginning of data segment */
    *(.data .data.*)
    edata = ABSOLUTE(.) ;       /* edata: end of data */
    . = ALIGN(4096);
  }
  .bss :
  {
    bss = ABSOLUTE(.);          /* bss: beginning of bss segment */
    *(.bss .bss.*)
    *(COMMON)                   /* extra sections that are common */
    ebss = ABSOLUTE(.) ;        /* ebss: end of bss */
    . = ALIGN(4096);
    end = ABSOLUTE(.);          /* end: end of image */
    _end = ABSOLUTE(.);         /* _end: end of image */
    . = ALIGN(4096);
  }
}
