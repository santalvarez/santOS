import _Volatile

@main
public struct Kernel {
    public static func main() {
        
        // Initialize the PL011 UART for serial communication
        PL011.initialize()
        
        // Send Hello World message
        PL011.sayHello()
        
    }
}
