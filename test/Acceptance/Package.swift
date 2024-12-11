// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Acceptance",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Acceptance",
            targets: ["Acceptance"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/hayesgm/Eth.swift", branch: "88a9f560e678fd480f85a38aaee0bef2d1f7e403"),
        .package(url: "https://github.com/attaswift/BigInt.git", from: "5.3.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Acceptance",
            dependencies: [
                .product(name: "Eth", package: "Eth.swift"),
                "BigInt",
            ]
        ),
        .testTarget(
            name: "AcceptanceTests",
            dependencies: ["Acceptance"]
        ),
    ]
)
