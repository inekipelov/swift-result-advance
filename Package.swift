// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-result-advance",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "ResultAdvance",
            targets: ["ResultAdvance"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ResultAdvance",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "ResultAdvanceTests",
            dependencies: ["ResultAdvance"],
            path: "Tests"),
    ]
)
