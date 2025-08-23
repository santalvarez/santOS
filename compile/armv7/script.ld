OUTPUT_ARCH(arm)
ENTRY(_start)
physbase = 0x40200000;

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

  /* Exception unwinding information (required by the linker) */
  .ARM.exidx :
  {
    *(.ARM.exidx*)
  }

  /* Discard sections that are not needed in the final bare-metal image */
  /DISCARD/ :
  {
    *(.swift_modhash)
    *(.ARM.attributes)
    *(.comment)
    *(.note*)
    *(.swift_ast*)
    /* Debug sections */
    *(.debug_info)
    *(.debug_abbrev)
    *(.debug_aranges)
    *(.debug_line)
    *(.debug_line_str)
    *(.debug_loc)
    *(.debug_ranges)
    *(.debug_str)
    *(.debug_names)
    *(.debug_frame)
    *(.debug_pubtypes)
    *(.debug_pubnames)
    *(.debug_macinfo)
    *(.debug_macro)
    *(.debug_types)
    *(.debug_gnu_pubtypes)
    *(.debug_gnu_pubnames)
  }

  /* String tables required by ELF format */
  .strtab :
  {
    *(.strtab)
  }
  .shstrtab :
  {
    *(.shstrtab)
  }
  .symtab : { *(.symtab) }
}
