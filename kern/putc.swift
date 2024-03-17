

// syscall	putc(
// 	  did32		descrp,		/* Descriptor for device	*/
// 	  char		ch		/* Character to send		*/
// 	)
// {
// 	intmask		mask;		/* Saved interrupt mask		*/
// 	struct dentry	*devptr;	/* Entry in device switch table	*/
// 	int32		retval;		/* Value to return to caller	*/

// 	mask = disable();
// 	if (isbaddev(descrp)) {
// 		restore(mask);
// 		return SYSERR;
// 	}
// 	devptr = (struct dentry *) &devtab[descrp];
// 	retval = (*devptr->dvputc) (devptr, ch);
// 	restore(mask);
// 	return retval;
// }

func isbaddev(_ desc: Int32) -> Bool {
    return false
}


@_cdecl("putc")
func putc(desc: Int32, ch: CChar) -> syscall {

    let mask: UInt32 = disable()

    if isbaddev(desc) {
        restore(mask)
        return SYSERR
    }

    restore(mask)
    return 0

}