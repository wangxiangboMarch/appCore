// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APPCoreLibrary",
    defaultLocalization: .init("zh-Hans"),
    platforms: [
        .iOS(.v13),
        .macOS(.v10_14)
    ],
    products: [
        .library(name: "APPCoreLibrary", targets: ["APPCoreLibrary"]),
        .library(name: "PUMLog", targets: ["PUMLog"]),
        .library(name: "PUMUtils", targets: ["PUMUtils"]),
        .library(name: "PUMLogConsole", targets: ["PUMLogConsole"]),
    ],
    dependencies:[
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        .target(name: "APPCoreLibrary",
                dependencies: [
                    "PUMUtils",
                    "PUMLog",
                    "SnapKit"
                ],
                resources: [
                ],
                swiftSettings:[
                    .define("SPM")
                ]),
        
        .target(name: "PUMLogConsole",
                dependencies: ["PUMLog"],
                swiftSettings:[
                    .define("SPM")
                ]),
        
        .target(name: "PUMLog",
                dependencies: ["PUMUtils"],
                swiftSettings: [
                    .define("SPM")
                ]),
        
        .target(name: "PUMUtils",
                resources: [
                    .copy("./Extension-Util/String/Pinyin/unicode_to_hanyu_pinyin.txt")
                ],
                swiftSettings:[
                    .define("SPM")
                ]),
        
        .testTarget(name: "APPCoreLibraryTests",dependencies: ["PUMUtils"])
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
