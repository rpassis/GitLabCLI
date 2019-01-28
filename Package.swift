// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "gitlab-cli",
    dependencies: [
        .package(url: "https://github.com/nsomar/Guaka.git", from: "0.3.1"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "4.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "gitlab-cli",
            dependencies: [
                "Guaka",
                "GitLabCore"
            ],
            path: "Sources/GitLabCli"),
        .target(
            name: "GitLabCore",
            dependencies: [
                "RxSwift"
            ],
            path: "Sources/GitLabCore"),
        .testTarget(
            name: "gitlab-cliTests",
            dependencies: ["gitlab-cli"])
    ]
)
