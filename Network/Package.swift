// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Network",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Network",
            targets: ["Network"]
        )
    ],
    targets: [
        .target(
            name: "Network"
        )
    ]
)
