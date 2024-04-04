

@_silgen_name("putchar")
public func putchar(_ c: CInt) -> CInt {
    waitWriteBufferEmpty()
    transmit(value: UInt8(c))
    waitWriteBufferEmpty()
    return 0
}
