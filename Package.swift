// swift-tools-version: 5.9
// Copyright (c) 2026 Scandit AG. All rights reserved.

import Foundation
import PackageDescription

let frameworkName = "ScanditPriceLabel"
let localFrameworkRelPath = "src/ios/framework/\(frameworkName).xcframework"
let useLocalFramework = FileManager.default.fileExists(
    atPath: Context.packageDirectory + "/" + localFrameworkRelPath
)

var dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/apache/cordova-ios.git", from: "8.0.0")
]
var targetDeps: [Target.Dependency] = [
    .product(name: "Cordova", package: "cordova-ios")
]
var targets: [Target] = []

if useLocalFramework {
    targets.append(.binaryTarget(name: frameworkName, path: localFrameworkRelPath))
    targetDeps.append(.byName(name: frameworkName))
}

var excludes: [String] = []
let iosDir = Context.packageDirectory + "/src/ios"
for candidate in [
    "framework",
    "ScanditPriceLabelPlugin-Bridging-Header.h",
    "scandit-cordova-datacapture-price-label-framework.podspec",
] where FileManager.default.fileExists(atPath: iosDir + "/" + candidate) {
    excludes.append(candidate)
}

targets.insert(
    .target(
        name: "ScanditCordovaDatacapturePriceLabel",
        dependencies: targetDeps,
        path: "src/ios",
        exclude: excludes
    ),
    at: 0
)

let package = Package(
    name: "scandit-cordova-datacapture-price-label",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "scandit-cordova-datacapture-price-label",
            targets: ["ScanditCordovaDatacapturePriceLabel"]
        )
    ],
    dependencies: dependencies,
    targets: targets
)
