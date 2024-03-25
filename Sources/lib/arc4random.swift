
func simpleRand() -> UInt32 {
    var seed: UInt32 = 0
    seed = (seed &* 1103515245 &+ 12345) & 0x7FFFFFFF
    return seed
}

@_cdecl("arc4random_buf")
public func arc4random_buf(_ buf: UnsafeMutableRawPointer!, _ nbytes: Int) {
    let ptr = buf.bindMemory(to: UInt8.self, capacity: nbytes)
    for i in 0..<nbytes {
        ptr[i] = UInt8(simpleRand() & 0xFF)
    }
}