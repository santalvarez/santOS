import _Volatile

public struct PL011 {
    // PL011 UART base address - commonly used on ARM platforms like Raspberry Pi
    private static let UART_BASE: UInt = 0x09000000
    
    // PL011 Register offsets
    private static let UART_DR     = UART_BASE + 0x00  // Data Register
    private static let UART_FR     = UART_BASE + 0x18  // Flag Register
    private static let UART_IBRD   = UART_BASE + 0x24  // Integer Baud Rate Register
    private static let UART_FBRD   = UART_BASE + 0x28  // Fractional Baud Rate Register
    private static let UART_LCRH   = UART_BASE + 0x2C  // Line Control Register
    private static let UART_CR     = UART_BASE + 0x30  // Control Register
    
    // Flag Register bits
    private static let UART_FR_TXFF: UInt32 = 1 << 5  // Transmit FIFO full
    private static let UART_FR_RXFE: UInt32 = 1 << 4  // Receive FIFO empty
    
    // Control Register bits
    private static let UART_CR_UARTEN: UInt32 = 1 << 0  // UART enable
    private static let UART_CR_TXE: UInt32    = 1 << 8  // Transmit enable
    private static let UART_CR_RXE: UInt32    = 1 << 9  // Receive enable
    
    // Line Control Register bits
    private static let UART_LCRH_WLEN_8: UInt32 = 3 << 5  // 8-bit words
    private static let UART_LCRH_FEN: UInt32    = 1 << 4  // FIFO enable
    
    // Memory-mapped registers
    private static let dataReg = unsafe VolatileMappedRegister<UInt32>(unsafeBitPattern: UART_DR)
    private static let flagReg = unsafe VolatileMappedRegister<UInt32>(unsafeBitPattern: UART_FR)
    private static let intBaudReg = unsafe VolatileMappedRegister<UInt32>(unsafeBitPattern: UART_IBRD)
    private static let fracBaudReg = unsafe VolatileMappedRegister<UInt32>(unsafeBitPattern: UART_FBRD)
    private static let lineCtrlReg = unsafe VolatileMappedRegister<UInt32>(unsafeBitPattern: UART_LCRH)
    private static let controlReg = unsafe VolatileMappedRegister<UInt32>(unsafeBitPattern: UART_CR)
    
    /// Initialize the PL011 UART
    public static func initialize() {
        // Disable UART
        controlReg.store(0)
        
        // Set baud rate to 115200 (assuming 48MHz UART clock)
        // Baud divisor = UART_CLK / (16 * baud_rate)
        // For 115200: 48000000 / (16 * 115200) = 26.041666...
        // Integer part = 26, fractional part = 0.041666... * 64 = 2.666... ≈ 3
        intBaudReg.store(26)
        fracBaudReg.store(3)
        
        // Configure line control: 8 bits, no parity, 1 stop bit, enable FIFO
        lineCtrlReg.store(UART_LCRH_WLEN_8 | UART_LCRH_FEN)
        
        // Enable UART, transmit and receive
        controlReg.store(UART_CR_UARTEN | UART_CR_TXE | UART_CR_RXE)
    }
    
    /// Send a single character via UART
    public static func putchar(_ char: UInt8) {
        // Wait until transmit FIFO is not full
        while (flagReg.load() & UART_FR_TXFF) != 0 {
            // Busy wait
        }
        
        // Write character to data register
        dataReg.store(UInt32(char))
    }
    
    /// Send a string via UART
    public static func puts(_ string: String) {
        for char in string.utf8 {
            putchar(char)
        }
    }
    
    /// Send "Hello, World!" message via UART
    public static func sayHello() {
        putchar(72)   // H
        putchar(101)  // e
        putchar(108)  // l
        putchar(108)  // l
        putchar(111)  // o
        putchar(44)   // ,
        putchar(32)   // (space)
        putchar(87)   // W
        putchar(111)  // o
        putchar(114)  // r
        putchar(108)  // l
        putchar(100)  // d
        putchar(33)   // !
        putchar(13)   // \r
        putchar(10)   // \n
    }
}