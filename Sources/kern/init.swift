

@_silgen_name("initialize")
func initialize() {
    
    let uart = UART0(unsafeAddress: kUART0BaseAddress)
    
    uart.LCR.modify { $0.Div = true }
    // Set the baud rate
    uart.DLH.modify { $0.ClockMSB = BitField6(storage: 0 as UInt) }
    uart.DLL.modify { $0.ClockLSB = BitField8(storage: 26 as UInt) }
    
    uart.LCR.modify {
        $0.CharLength = BitField2(storage: 0x3 as UInt) // 8 bit char length
        $0.NBStop = false  // 1 stop bit
        $0.Parity = false  // No parity
    }
    

    print("santOS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
}


