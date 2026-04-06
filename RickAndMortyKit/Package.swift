// swift-tools-version: 6.2

import PackageDescription

let swiftSettings: Array<SwiftSetting> = [
    .swiftLanguageMode(.v6),
    .defaultIsolation(MainActor.self)
]

let package = Package(
    name: "RickAndMortyKit",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "Common", targets: ["Common"]),
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "Data", targets: ["Data"]),
        .library(name: "Mocks", targets: ["Mocks"]),
        .library(name: "Presentation", targets: ["Presentation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.0.0"),
    ],
    targets: [
        .target(
            name: "Common",
            swiftSettings: swiftSettings
        ),
        .target(
            name: "Domain",
            swiftSettings: swiftSettings
        ),
        .target(
            name: "Networking",
            swiftSettings: swiftSettings
        ),
        .target(
            name: "Data",
            dependencies: ["Common", "Domain", "Networking"],
            swiftSettings: swiftSettings
        ),
        .target(
            name: "Mocks",
            dependencies: ["Domain"],
            swiftSettings: swiftSettings
        ),
        .target(
            name: "Presentation",
            dependencies: [
                "Common",
                "Domain",
                "Mocks",
                .product(name: "Kingfisher", package: "Kingfisher"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Presentation", "Common", "Domain", "Mocks"],
            swiftSettings: swiftSettings
        ),
    ]
)
