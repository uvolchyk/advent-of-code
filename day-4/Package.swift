// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "day-4",
  platforms: [.iOS(.v18), .macOS(.v15)],
  targets: [
    .executableTarget(
      name: "day-4",
      resources: [.copy("data.txt")]
    ),
  ]
)
