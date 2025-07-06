// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "santOS",
    products: [
        .executable(name: "santOS", targets: ["Kern"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-mmio", branch: "main")
    ],
    targets: [
        .executableTarget(
            name: "Kern",
            dependencies: ["ArmV7", .product(name: "MMIO", package: "swift-mmio")],
            path: "Sources/Kern"
        ),
        .target(
            name: "ArmV7",
            path: "Sources/Arch/armv7"
        )
    ],
    swiftLanguageModes: [.v6]
)
