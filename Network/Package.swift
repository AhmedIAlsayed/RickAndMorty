// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Network",
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
