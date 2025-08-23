// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "santOS",
    products: [
        .executable(name: "santOS", targets: ["Kern"])
    ],
    targets: [
        .executableTarget(
            name: "Kern",
            dependencies: ["Arch"],
        ),
        .target(
            name: "Arch",
        )
    ]
)
