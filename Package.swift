// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TempoClient",
    products: [
        .library(name: "TempoClient", targets: ["TempoClient"]),
        ],
    dependencies: [
        .package(url: "https://github.com/cpageler93/quack", .branch("1.4.0"))
    ],
    targets: [
        .target(name: "TempoClient", dependencies: ["Quack"]),
        .testTarget(name: "TempoClientTests", dependencies: ["TempoClient"]),
        ]
)
