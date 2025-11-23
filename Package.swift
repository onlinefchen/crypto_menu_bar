// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CryptoMenuBar",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "CryptoMenuBar", targets: ["CryptoMenuBar"])
    ],
    targets: [
        .executableTarget(
            name: "CryptoMenuBar",
            dependencies: []
        )
    ]
)
