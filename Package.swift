// swift-tools-version: 5.11

import PackageDescription

let package = Package(
    name: "santOS",
    products: [
        .library(name: "santOS", type: .static, targets: ["santOS"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-mmio", branch: "swift-embedded-examples")
    ],
    targets: [
        .target(
            name: "santOS",
            dependencies: [
                "santOS-arch",
                .product(name: "MMIO", package: "swift-mmio")
            ],
            path: "Sources",
            exclude: [
                "kern/arch"
            ],
            sources: [
                "kern",
                "lib"
            ],
            publicHeadersPath: "include",
            swiftSettings: [
                .enableExperimentalFeature("Embedded"),
                .unsafeFlags([
                    "-Xfrontend", "-function-sections", // Enables dead stripping of unused runtime functions
                    "-Xfrontend", "-disable-stack-protector",
                    "-Xfrontend", "-no-allocations",
                    "-wmo", // Whole-module optimization is always required for Embedded Swift
                    "-Xcc", "-mthumb",
                    "-Xcc", "-fshort-enums",
                    "-Xcc", "-mfloat-abi=soft"
                ])
            ]
        ),
        .target(
            name: "santOS-arch",
            path: "Sources",
            sources: [
                "kern/arch"
            ],
            publicHeadersPath: "include"
        )
    ],
    swiftLanguageVersions: [.v5]
)
