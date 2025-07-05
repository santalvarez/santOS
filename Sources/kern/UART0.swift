// import MMIO


// let kUART0BaseAddress: UInt = 0x44E0_9000


// // https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
// // Page 4377
// @RegisterBank
// struct UART0 {

//     @RegisterBank(offset: 0x0)
//     var THR: Register<THRRegister>

//     @RegisterBank(offset: 0x0)
//     var RHR: Register<RHRRegister>

//     @RegisterBank(offset: 0x0)
//     var DLL: Register<DLLRegister>

//     @RegisterBank(offset: 0x4)
//     var IER: Register<IERRegister>

//     @RegisterBank(offset: 0x4)
//     var DLH: Register<DLHRegister>

//     @RegisterBank(offset: 0x8)
//     var FCR: Register<FCRRegister>

//     @RegisterBank(offset: 0xC)
//     var LCR: Register<LCRRegister>

//     @RegisterBank(offset: 0x14)
//     var LSR: Register<LSRRegister>

//     @RegisterBank(offset: 0x20)
//     var MDR1: Register<MDR1Register>

// }

// // Transmitter Holding Register
// @Register(bitWidth: 16)
// struct THRRegister {

//     @WriteOnly(bits: 0..<8)
//     var THR: THRField
// }

// // Receiver Holding Register
// @Register(bitWidth: 16)
// struct RHRRegister {
//     @ReadOnly(bits: 0..<8)
//     var RHR: RHRField
// }

// @Register(bitWidth: 16)
// struct DLLRegister {
//     @ReadWrite(bits: 0..<8)
//     var ClockLSB: ClockLSBField
// }

// @Register(bitWidth: 16)
// struct IERRegister {
//     @ReadWrite(bits: 0..<1, as: Bool.self)
//     var RHRIT: RHRITField

//     @ReadWrite(bits: 1..<2, as: Bool.self)
//     var THRIT: THRITField

//     @ReadWrite(bits: 2..<3, as: Bool.self)
//     var LineStatusIT: LineStatusITField
// }

// @Register(bitWidth: 16)
// struct DLHRegister {
//     @ReadWrite(bits: 0..<6)
//     var ClockMSB: ClockMSBField
// }

// @Register(bitWidth: 16)
// struct LCRRegister {

//     @ReadWrite(bits: 7..<8, as: Bool.self)
//     var Div: DivField

//     @ReadWrite(bits: 6..<7, as: Bool.self)
//     var Break: BreakField

//     @ReadWrite(bits: 5..<6, as: Bool.self)
//     var ParityType2: ParityType2Field

//     @ReadWrite(bits: 4..<5, as: Bool.self)
//     var ParityType1: ParityType1Field

//     @ReadWrite(bits: 3..<4, as: Bool.self)
//     var Parity: ParityField

//     @ReadWrite(bits: 2..<3, as: Bool.self)
//     var NBStop: NBStopField

//     @ReadWrite(bits: 0..<2)
//     var CharLength: CharLengthField
// }


// @Register(bitWidth: 16)
// struct MDR1Register {

//     @ReadWrite(bits: 7..<8, as: Bool.self)
//     var FrameEndMode: FrameEndModeField

//     @ReadWrite(bits: 6..<7, as: Bool.self)
//     var SIPMode: SIPModeField

//     @ReadWrite(bits: 5..<6, as: Bool.self)
//     var SCT: SCTField

//     @ReadWrite(bits: 4..<5, as: Bool.self)
//     var SetTXIR: SetTXIRField

//     @ReadWrite(bits: 3..<4, as: Bool.self)
//     var IRSSleep: IRSSleepField

//     @ReadWrite(bits: 0..<3)
//     var ModeSelect: ModeSelectField

// }

// @Register(bitWidth: 16)
// struct FCRRegister {

//     @WriteOnly(bits: 6..<8)
//     var RXTrig: RXTrigField

//     @WriteOnly(bits: 4..<6)
//     var TXTrig: TXTrigField

//     @WriteOnly(bits: 3..<4, as: Bool.self)
//     var DMAMode: DMAModeField

//     @WriteOnly(bits: 2..<3, as: Bool.self)
//     var TXClear: TXClearField

//     @WriteOnly(bits: 1..<2, as: Bool.self)
//     var RXClear: RXClearField

//     @WriteOnly(bits: 0..<1, as: Bool.self)
//     var EN: ENField

// }

// @Register(bitWidth: 16)
// struct LSRRegister {  // UART

//     @ReadOnly(bits: 6..<7, as: Bool.self)
//     var TXSRE: TXSREField

//     @ReadOnly(bits: 5..<6, as: Bool.self)
//     var TXFIFOE: TXFIFOEField

// }
