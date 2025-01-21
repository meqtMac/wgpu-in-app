// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WgpuDemoCore",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WgpuDemoCore",
            targets: ["WgpuDemoCore"]),
    ],
    targets: [
    .binaryTarget(
            name: "WgpuDemoCore",
            path: "Frameworks/WgpuDemoCore.xcframework" // Path to your local .xcframework
        )
   ]
)
