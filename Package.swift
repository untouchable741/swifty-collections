// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SwiftyCollections",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SwiftyCollections",
            targets: ["SwiftyCollections"]
        ),
    ],
    dependencies: [
        // No external dependencies (yet) — pure Swift package
    ],
    targets: [
        .target(
            name: "SwiftyCollections",
            dependencies: [],
            path: "Sources/SwiftyCollections"
        ),
        .testTarget(
            name: "SwiftyCollectionsTests",
            dependencies: ["SwiftyCollections"],
            path: "Tests/SwiftyCollectionsTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
