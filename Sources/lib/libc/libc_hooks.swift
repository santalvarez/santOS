
@_cdecl("_kill")
public func _kill(_ pid: Int32, _ sig: Int32) -> Int32 {
    return 0
}

@_cdecl("_write")
public func _write(_ fd: Int32, _ buf: UnsafeRawPointer?, _ count: Int) -> Int32 {
    return 0
}

@_cdecl("_exit")
public func _exit(_ status: Int32) {
    while true {
        // Do nothing
    }
}

@_cdecl("_getpid")
public func _getpid() -> Int32 {
    return 0
}

@_cdecl("_sbrk")
public func _sbrk(_ incr: Int) -> UnsafeMutableRawPointer? {
    return nil
}
