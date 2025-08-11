// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "santOS",
    products: [
        .executable(name: "santOS", targets: ["Kern"])
    ],
    targets: [
        .executableTarget(
            name: "Kern",
            dependencies: ["ArmV7"],
            path: "Sources/Kern"
        ),
        .target(
            name: "ArmV7",
            path: "Sources/Arch/armv7"
        )
    ],
    swiftLanguageModes: [.v6]
)
