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
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "CharactersCore", targets: ["CharactersCore"]),
        .library(name: "CharactersCoreMocks", targets: ["CharactersCoreMocks"]),
        .library(name: "CharactersFeature", targets: ["CharactersFeature"]),
        .library(name: "PictureFeature", targets: ["PictureFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-clocks.git", from: "1.0.6"),
    ],
    targets: [
        .target(
            name: "Common",
            swiftSettings: swiftSettings
        ),
        .target(
            name: "Networking",
            swiftSettings: swiftSettings
        ),
        .target(
            name: "CharactersCore",
            dependencies: ["Common", "Networking"],
            swiftSettings: swiftSettings
        ),
        .target(
            name: "CharactersCoreMocks",
            dependencies: ["CharactersCore"],
            swiftSettings: swiftSettings
        ),
        .target(
            name: "CharactersFeature",
            dependencies: [
                "Common",
                "CharactersCore",
                "CharactersCoreMocks",
                .product(name: "Kingfisher", package: "Kingfisher"),
            ],
            swiftSettings: swiftSettings
        ),
        .target(
            name: "PictureFeature",
            dependencies: [
                "Common",
                .product(name: "Kingfisher", package: "Kingfisher"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "CharactersFeatureTests",
            dependencies: [
                "Common",
                "CharactersFeature",
                "CharactersCore",
                "CharactersCoreMocks",
                .product(name: "Clocks", package: "swift-clocks"),
            ],
            swiftSettings: swiftSettings
        ),
    ]
)
