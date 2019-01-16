// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GitLabCli",
    dependencies: [
        .package(url: "https://github.com/kylef/Commander.git", from: "0.8.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "4.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "GitLabCli",
            dependencies: [
                "Commander",
                "GitLabCore",
                "RxSwift"
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
            dependencies: ["GitLabCli"])
    ]
)
