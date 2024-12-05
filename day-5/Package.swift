// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "day-5",
  targets: [
    .executableTarget(
      name: "day-5",
      resources: [
        .copy("rules"),
        .copy("updates")
      ]
    ),
  ]
)
