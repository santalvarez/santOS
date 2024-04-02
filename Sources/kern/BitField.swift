import MMIO


// TODO: find a way to not repeat code here

struct BitField2: BitFieldProjectable {
    static var bitWidth: Int { return 2 }

    private let storage: UInt8

    init<Storage>(storage: Storage) where Storage: FixedWidthInteger & UnsignedInteger {
        // Ensure the provided storage value can be represented within 2 bits
        precondition(storage >= 0 && storage <= 0b11)
        self.storage = UInt8(storage)
    }

    func storage<Storage>(_: Storage.Type) -> Storage where Storage: FixedWidthInteger & UnsignedInteger {
        return Storage(storage)
    }
}

struct BitField3: BitFieldProjectable {
    static var bitWidth: Int { return 3 }

    private let storage: UInt8

    init<Storage>(storage: Storage) where Storage: FixedWidthInteger & UnsignedInteger {
        // Ensure the provided storage value can be represented within 3 bits
        precondition(storage >= 0 && storage <= 0b111)
        self.storage = UInt8(storage)
    }

    func storage<Storage>(_: Storage.Type) -> Storage where Storage: FixedWidthInteger & UnsignedInteger {
        return Storage(storage)
    }
}

struct BitField6: BitFieldProjectable {
    static var bitWidth: Int { return 6 }

    private let storage: UInt8

    init<Storage>(storage: Storage) where Storage: FixedWidthInteger & UnsignedInteger {
        // Ensure the provided storage value can be represented within 6 bits
        precondition(storage >= 0 && storage <= 0b111111)
        self.storage = UInt8(storage)
    }

    func storage<Storage>(_: Storage.Type) -> Storage where Storage: FixedWidthInteger & UnsignedInteger {
        return Storage(storage)
    }
}

struct BitField8: BitFieldProjectable {
    static var bitWidth: Int { return 8 }

    private let storage: UInt8

    init<Storage>(storage: Storage) where Storage: FixedWidthInteger & UnsignedInteger {
        // Ensure the provided storage value can be represented within 8 bits
        precondition(storage >= 0 && storage <= UInt8.max)
        self.storage = UInt8(storage)
    }

    func storage<Storage>(_: Storage.Type) -> Storage where Storage: FixedWidthInteger & UnsignedInteger {
        return Storage(storage)
    }
}
