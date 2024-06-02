


let uart = UART0(unsafeAddress: kUART0BaseAddress)

func receive() -> UInt8 {
    return UInt8(uart.RHR.read().raw.RHR)
}

func transmit(value: UInt8) {
    uart.THR.write { $0.raw.THR = UInt16(value)}
}

func waitReadBufferFull() {
}

func waitWriteBufferEmpty() {
    while uart.LSR.read().raw.TXSRE == 0 {}
}


@_silgen_name("initialize")
func initialize() {
    
    // Divisor latch enable (allow access to DLH and DLL)
    uart.LCR.modify { $0.Div = true }
    // Set the baud rate
    // Baud rate divisor = 48,000,000 / (16 * 115200) ≈ 26.0417
    uart.DLH.modify { $0.raw.ClockMSB = 0 }
    uart.DLL.modify { $0.raw.ClockLSB = 26 }
    
    uart.LCR.modify {
        $0.raw.CharLength = 0x3 // 8 bit char length
        $0.NBStop = false  // 1 stop bit
        $0.Parity = false  // No parity
    }
    // Disable FIFO
    uart.FCR.modify {
        $1.EN = false
    }
    
    // 16x mode (required by AM335X)
    uart.MDR1.modify { $0.raw.ModeSelect = 0 }

    uart.IER.modify {
        $0.RHRIT = true
        $0.THRIT = true
    }

    print("santOS on BeagleBone Black!!!!!!!!!")
    
    while true {
        
    }
}


