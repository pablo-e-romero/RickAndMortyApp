// swift-tools-version: 6.0

import PackageDescription

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
            name: "Common"
        ),
        .target(
            name: "Domain"
        ),
        .target(
            name: "Networking"
        ),
        .target(
            name: "Data",
            dependencies: ["Common", "Domain", "Networking"]
        ),
        .target(
            name: "Mocks",
            dependencies: ["Domain"]
        ),
        .target(
            name: "Presentation",
            dependencies: [
                "Common",
                "Domain",
                "Mocks",
                .product(name: "Kingfisher", package: "Kingfisher"),
            ]
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Presentation", "Common", "Domain", "Mocks"]
        ),
    ]
)
